package com.hust.mining.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FileUtil {
    /**
     * Logger for this class
     */
    private static final Logger logger = LoggerFactory.getLogger(FileUtil.class);

    public static List<String[]> read(String...filenames) {
        if (CommonUtil.hasEmptyArray(filenames)) {
            return null;
        }
        int taskSize = filenames.length;
        ExecutorService pool = Executors.newFixedThreadPool(taskSize);
        List<String[]> content = new ArrayList<String[]>();
        FileUtil util = new FileUtil();
        for (int i = 0; i < taskSize; i++) {
            Callable<List<String[]>> thread = util.new ReadThread(filenames[i]);
            Future<List<String[]>> f = pool.submit(thread);
            try {
                content.addAll(f.get());
            } catch (InterruptedException | ExecutionException e) {
                logger.error("read from {} failed", filenames[i]);
            }
        }
        pool.shutdown();
        return content;
    }
    
    //不同文件第一行属性不同，作并集处理
    public static List<String[]> readForUnificating(String...filenames){
    	if (CommonUtil.hasEmptyArray(filenames)) {
            return null;
        }    	
    	List<String[]> content = new ArrayList<String[]>();
    	try {
			Map<String, Object> map = readAttr(filenames);
			List<String> allAttrs = (List<String>) map.get("allAttrs");
			Map<String, List<Integer>> attrPos = (Map<String, List<Integer>>) map.get("attrPos");
			int taskSize = filenames.length;
	        ExecutorService pool = Executors.newFixedThreadPool(taskSize);
	        FileUtil util = new FileUtil();
	        for (int i = 0; i < taskSize; i++) {
	            Callable<List<String[]>> thread = util.new UnionReadThread(filenames[i],attrPos.get(filenames[i]),allAttrs);
	            Future<List<String[]>> f = pool.submit(thread);
	            try {
	                content.addAll(f.get());
	            } catch (InterruptedException | ExecutionException e) {
	                logger.error("read from {} failed", filenames[i]);
	            }
	        }
	        String[] allAttrs_str = new String[allAttrs.size()];
	        for(int i=0; i<allAttrs_str.length; i++){
	        	allAttrs_str[i] = allAttrs.get(i);
	        }
	        content.add(0, allAttrs_str);
	        pool.shutdown();
	        return content;
		} catch (Exception e) {
			logger.error("readAttr error 可能的原因是excel文件不含有url。");
		}
        return content;
    }
    
    //读取属性行，即第一行
    private static Map<String, Object> readAttr(String...filenames) throws Exception{
    	List<String> allAttrs = new ArrayList<String>();
    	Map<String, List<Integer>> attrPos = new HashMap<String,List<Integer>>();
    	
    	//偏好词位置设置。例如 摘要、内容属性放在最后面、序号、属性放在第一二列。
    	Map<String,Map<String,Integer>> preference = new HashMap<String, Map<String,Integer>>();
    	// TODO
    	List<Integer> pos_i = new ArrayList<Integer>();
    	BufferedReader br = new BufferedReader(new FileReader(filenames[0]));
    	String line = br.readLine();
    	String[] subAttrs = line.split("\t");
    	for(int i=0; i<subAttrs.length; i++){
    		allAttrs.add(subAttrs[i]);
    		pos_i.add(i);
    	}
    	if(AttrUtil.findIndexOfUrl(allAttrs) == -1){
    		logger.error("excel文件格式不正确：含有不包含url的文件。");
    		return null;
    	}
    	attrPos.put(filenames[0],pos_i);
    	br.close();
    	
    	for(int i=1; i<filenames.length; i++){
    		pos_i = new ArrayList<Integer>();
    		br = new BufferedReader(new FileReader(filenames[1]));
    		line = br.readLine();
    		String[] subAttrs_i = line.split("\t");
    		for(int j=0; j<subAttrs_i.length; j++){
    			int index = allAttrs.indexOf(subAttrs_i[j]);
    			if(index == -1){
    				if(Pattern.matches("链接|网址|[Uu][Rr][Ll]",subAttrs_i[j])){
        				pos_i.add(AttrUtil.findIndexOfUrl(allAttrs));
        				continue;
    				}
    				pos_i.add(allAttrs.size());
    				allAttrs.add(subAttrs_i[j]);
    			}else{
    				pos_i.add(index);
    				continue;
    			}
    		}
    		attrPos.put(filenames[i], pos_i);
    		br.close();
    	}
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("allAttrs", allAttrs);
    	map.put("attrPos", attrPos);
    	return map;
    }
    
    public static boolean write(String filename, List<String[]> content) {
        if (StringUtils.isEmpty(filename)) {
            return false;
        }
        if (content == null || content.size() == 0) {
            return false;
        }
        ExecutorService pool = Executors.newSingleThreadExecutor();
        Callable<Boolean> thread = new FileUtil().new WriteThread(filename, content);
        Future<Boolean> f = pool.submit(thread);
        try {
            return f.get();
        } catch (Exception e) {
            logger.error("写文件失败:{}", e.toString());
        }
        return false;
    }

    public static boolean delete(String filename) {
        File file = new File(filename);
        if (file.exists() && file.isFile()) {
            file.delete();
            return true;
        }
        return false;
    }

    class ReadThread implements Callable<List<String[]>> {

        private String filename;

        protected ReadThread(String filename) {
            super();
            this.filename = filename;
        }

        @Override
        public List<String[]> call() throws Exception {
            BufferedReader br = new BufferedReader(new FileReader(filename));
            List<String[]> content = new ArrayList<String[]>();
            synchronized (br) {
                String line;
                while (true) {
                    line = br.readLine();
                    if (StringUtils.isEmpty(line)) {
                        break;
                    }
                    String[] row = line.split("\t");
                    content.add(row);
                }
            }
            br.close();
            return content;
        }
    }

    class WriteThread implements Callable<Boolean> {
        private String filename;
        private List<String[]> content;

        protected WriteThread(String filename, List<String[]> content) {
            super();
            this.filename = filename;
            this.content = content;
        }

        @Override
        public Boolean call() throws Exception {
            // TODO Auto-generated method stub
            try {
                BufferedWriter bw = new BufferedWriter(new FileWriter(filename));
                for (String[] row : content) {
                    String line = StringUtils.join(row, "\t");
                    bw.write(line + "\r\n");
                }
                bw.close();
            } catch (Exception e) {
                logger.error("write {} failed, because:{}", filename, e.toString());
                return false;
            }
            return true;
        }

    }

    class UnionReadThread implements Callable<List<String[]>> {

        private String filename;
        private List<Integer> attrPos;
        private List<String> allAttrs;
        
        protected UnionReadThread(String filename,List<Integer> attrPos,List<String> allAttrs) {
            super();
            this.filename = filename;
            this.attrPos = attrPos;
            this.allAttrs = allAttrs;
        }

        @Override
        public List<String[]> call() throws Exception {
            BufferedReader br = new BufferedReader(new FileReader(filename));
            List<String[]> content = new ArrayList<String[]>();
            synchronized (br) {
            	//第一行属性读丢
            	br.readLine();
                String line;
                while (true) {
                    line = br.readLine();
                    if (StringUtils.isEmpty(line)) {
                        break;
                    }
                    String[] row = line.split("\t");
                    content.add(takeRightSeat(row));
                }
            }
            br.close();
            return content;
        }
        
        private String[] takeRightSeat(String[] row){
        	String[] res = new String[allAttrs.size()];
        	for(int i=0; i<res.length; i++){
        		res[i] = "";
        	}
        	for(int i=0; i<row.length; i++){
        		res[attrPos.get(i)] = row[i];
        	}
        	
        	return res;
        }
    }
}
