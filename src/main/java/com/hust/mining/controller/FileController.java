package com.hust.mining.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hust.mining.constant.Constant.DIRECTORY;
import com.hust.mining.constant.Constant.KEY;
import com.hust.mining.dao.IssueDao;
import com.hust.mining.model.Issue;
import com.hust.mining.model.IssueFile;
import com.hust.mining.model.StandardResult;
import com.hust.mining.model.params.Condition;
import com.hust.mining.service.FileService;
import com.hust.mining.service.IssueService;
import com.hust.mining.service.RedisService;
import com.hust.mining.service.ResultService;
import com.hust.mining.service.UserService;
import com.hust.mining.util.ExcelUtil;
import com.hust.mining.util.ResultUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/file")
public class FileController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = LoggerFactory.getLogger(FileController.class);

	@Autowired
	private FileService fileService;
	@Autowired
	private IssueService issueService;
	@Autowired
	private ResultService resultService;
	@Autowired
	private UserService userService;
	@Autowired
	private RedisService redisService;

	/**
	 * 上传文件
	 * @param file  文件流
	 * @param titleIndex  标题下标，excel文件标题栏 新闻标题的位置
	 * @param timeIndex   时间下标
	 * @param urlIndex    url下标
	 * @param sourceType  新闻类型下标
	 * @param request     请求
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public Object upload(@RequestParam(value = "file", required = true) MultipartFile file,
			@RequestParam(value = "titleIndex", required = true) int titleIndex,
			@RequestParam(value = "timeIndex", required = true) int timeIndex,
			@RequestParam(value = "urlIndex", required = true) int urlIndex,
			@RequestParam(value = "sourceType", required = true) String sourceType, HttpServletRequest request) {
		if (issueService.getCurrentIssueId(request) == null) {
			return ResultUtil.errorWithMsg("请选择或者创建一个任务");
		}
		// 数组之间必须是一一对应关系
		if (file.isEmpty()) {
			logger.info(file.getName() + "is empty");
			return ResultUtil.errorWithMsg("文件为空");
		}
		Condition condition = new Condition();
		condition.setFile(file);
		condition.setTimeIndex(timeIndex);
		condition.setUrlIndex(urlIndex);
		condition.setTitleIndex(titleIndex);
		condition.setSourceType(sourceType);
		if (fileService.insert(condition, request) == 0) {
			logger.info("file insert failed");
			return ResultUtil.errorWithMsg("上传失败");
		}
		return ResultUtil.success("上传成功");
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/downloadExtFile", method = RequestMethod.POST)
	public void downloadExtFile(@RequestParam(value = "fileId", required = true) String fileId,
			@RequestParam(value = "fileName", required = true) String fileName, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		OutputStream outputStream = null;
		try {
			List<String[]> cluster = fileService.getContentById(DIRECTORY.FILE, fileId);
			if (cluster == null) {
				return;
			}
			outputStream = response.getOutputStream();
			response.setCharacterEncoding("utf-8");
			response.setContentType("multipart/form-data");
			fileName = fileName.replace(" ", "");
			fileName = fileName.replace("，", "");
			fileName = fileName.replace(",", "");
			String name = new String(fileName.trim().replace(".xlsx", ".xls").getBytes(),"ISO8859-1");
			response.setHeader("Content-Disposition", "attachment;filename=" + name);
			HSSFWorkbook workbook = ExcelUtil.exportToExcel(cluster);
			workbook.write(outputStream);
		} catch (Exception e) {
			logger.info("excel 导出失败\t" + e.toString());
		} finally {
			try {
				outputStream.close();
			} catch (Exception e) {
				logger.info("导出excel时，关闭outputstream失败");
				return;
			}
		}
	}

	@ResponseBody
	@RequestMapping(value = "/queryIssueFiles")
	public Object queryIssueFiles(@RequestParam(value = "issueId", required = false) String issueId,
			HttpServletRequest request) {
		String user = userService.getCurrentUser(request);
		if (StringUtils.isBlank(issueId)) {
			issueId = redisService.getString(KEY.ISSUE_ID, request);
		}
		if (StringUtils.isBlank(issueId)) {
			return ResultUtil.errorWithMsg("查询任务文件失败");
		}
		Issue issue = issueService.queryIssueById(issueId);
		if (issue == null) {
			return ResultUtil.errorWithMsg("查询任务文件失败");
		}
		List<IssueFile> list = fileService.queryFilesByIssueId(issueId);
		redisService.setString(KEY.ISSUE_ID, issueId, request);
		JSONObject json = new JSONObject();
		json.put("issue", issue);
		json.put("list", list);
		return ResultUtil.success(json);
	}

	@ResponseBody
	@RequestMapping(value = "/deleteFileById")
	public Object deleteFileById(@RequestParam(value = "fileid", required = true) String fileId,
			HttpServletRequest request) {
		String issueId = issueService.getCurrentIssueId(request);
		if (StringUtils.isEmpty(issueId)) {
			return ResultUtil.errorWithMsg("获取当前任务失败,请重新进入任务");
		}
		int i = fileService.deleteById(fileId);
		// 删除文件是更改issue的修改时间
		Issue issue = issueService.queryIssueById(issueId);
		issueService.updateIssueInfo(issue, request);
		if (i > 0) {
			return ResultUtil.success("删除成功");
		}
		return ResultUtil.errorWithMsg("删除失败");
	}

	@ResponseBody
	@RequestMapping("/getColumnTitle")
	public Object getColumnTime(@RequestParam(value = "file", required = true) MultipartFile file) {
		if (file.isEmpty()) {
			return ResultUtil.errorWithMsg("文件是空的");
		}
		try {
			List<String[]> list = ExcelUtil.read(file.getOriginalFilename(), file.getInputStream(), 0, 1);
			return ResultUtil.success(list.get(0));
		} catch (Exception e) {
			logger.warn("read column title fail" + e.toString());
		}
		return ResultUtil.errorWithMsg("获取列表题失败");
	}

	/**
	 * 读取停用词文件，返回list集合
	 * 
	 * @param file
	 * @return 5月8号
	 */
	// 读取停用词文件，返回list集合
	@ResponseBody
	@RequestMapping("/getStopword")
	public Object getStopword(@RequestParam(value = "file", required = true) MultipartFile file) {
		if (file.isEmpty()) {
			return ResultUtil.errorWithMsg("文件为空");
		}
		try {
			List<String> list = ExcelUtil.read(file.getOriginalFilename(), file.getInputStream());
			if (null == list || 0 == list.size()) {
				return ResultUtil.errorWithMsg("文件读取错误！");
			}
			return ResultUtil.success(list);
		} catch (Exception e) {
			logger.warn("read stopword file fail" + e.toString());
		}
		return ResultUtil.errorWithMsg("文件预浏览失败!");
	}

	@ResponseBody
	@RequestMapping("/searchFileByCon")
	public Object searchFileByCon(@RequestParam(value = "startTime", required = true) Date startTime,
			@RequestParam(value = "endTime", required = true) Date endTime, HttpServletRequest request) {
		String issueId = issueService.getCurrentIssueId(request);
		if (StringUtils.isEmpty(issueId)) {
			return ResultUtil.errorWithMsg("获取当前任务失败,请重新进入任务");
		}
		List<IssueFile> list = fileService.searchFilesByTime(issueId, startTime, endTime);
		return ResultUtil.success(list);
	}

	// 生成核心数据，TODO
	@RequestMapping("/exportAbstract")
	public void exportAbstract(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String issueId = issueService.getCurrentIssueId(request);
		if (StringUtils.isBlank(issueId)) {
			response.sendError(404, "未找到当前处理事件，请先创建或者选择某一事件");
			logger.info("从session中无法s获得任务的任务id");
			return;
		}
		String resultId = resultService.getCurrentResultId(request);
		if (StringUtils.isBlank(resultId)) {
			response.sendError(404, "未找到当前处理记录，请先创建或者选择某一记录");
			logger.info("从session中无法s获得记录的记录id");
			return;
		}
		OutputStream outputStream = null;
		try {
			// 这里有错，因为我修改了exportService的返回类型。
			List<String[]> count = resultService.exportService(issueId, resultId, request);
			outputStream = response.getOutputStream();
			response.setCharacterEncoding("utf-8");
			response.setContentType("multipart/form-data");
			response.setHeader("Content-Disposition", "attachment;fileName=abstrct.txt");
			String content = resultService.exportAbstract(count);
			outputStream.write(content.getBytes());
		} catch (Exception e) {
			logger.info("excel 导出失败\t" + e.toString());
		} finally {
			try {
				outputStream.close();
			} catch (Exception e) {
				logger.info("导出excel时，关闭outputstream失败");
			}
		}
	}

	@InitBinder
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		CustomDateEditor editor = new CustomDateEditor(df, false);
		binder.registerCustomEditor(Date.class, editor);
	}

}
