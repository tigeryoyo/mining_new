package com.hust.mining.urltags;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.collections.map.HashedMap;

import com.hust.mining.util.CommonUtil;
import com.hust.mining.util.ExcelUtil;

public class URLTool {
	
	public static void main(String[] args) {
		String fileName = "E:/测试数据/汪哥交流以及数据5.11/汪哥交流以及数据5.11/准数据/四川戒毒管理局2017.5.4~5.10准数据.xlsx";//C:/Users/tankai/Desktop/result.xls
		new URLTool().statisticUrl(fileName);
	}
	/**
	 * 统计准数据文件url中出现次数最多的网站
	 * @param fileName
	 */
	public void statisticUrl(String fileName){
		Map<String,Integer> urlNumberMap = new HashedMap();
		try {
			List<String[]> dataList = ExcelUtil.read(fileName);
			
			if(dataList.isEmpty()){
				return;
			}
			System.out.println(dataList.size());
			for(String[] strs : dataList){
				String url = strs[5].trim();
				System.out.println(url);
				if(!url.equals("")){
					url = CommonUtil.getPrefixUrl(url);
					countUrl(url,urlNumberMap);
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		for(String url : urlNumberMap.keySet()){
			System.out.println(url+"    "+urlNumberMap.get(url));
		}
		
		System.out.println("排序后-----");
		sort(urlNumberMap);
	}

	public void countUrl(String url, Map<String, Integer> urlNumberMap) {
		// TODO Auto-generated method stub
		if(urlNumberMap.keySet().contains(url)){
			urlNumberMap.replace(url, urlNumberMap.get(url)+1);
		}else{
			urlNumberMap.put(url, 1);
		}
		
	}
	
	public void sort( Map<String, Integer> urlNumberMap){
		List<Map.Entry<String, Integer>> urls = new ArrayList<>(urlNumberMap.entrySet());
		Collections.sort(urls, new Comparator<Map.Entry<String, Integer>>() {

			@Override
			public int compare(Entry<String, Integer> o1, Entry<String, Integer> o2) {
				// TODO Auto-generated method stub
				return o2.getValue() - o1.getValue();
			}
		});
		
		for (Entry<String, Integer> entry : urls) {
			System.out.println(entry.getKey()+"    "+entry.getValue());
		}
	}
}
