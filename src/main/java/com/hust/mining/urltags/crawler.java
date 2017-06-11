package com.hust.mining.urltags;


import cn.edu.hfut.dmic.webcollector.model.CrawlDatums;


import cn.edu.hfut.dmic.webcollector.model.Page;
import cn.edu.hfut.dmic.webcollector.plugin.berkeley.BreadthCrawler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class crawler extends BreadthCrawler {

	
    public crawler(String crawlPath, boolean autoParse) {
        super(crawlPath, autoParse);
        /*不要爬取 jpg|png|gif*/
        this.addRegex("-.*\\.(jpg|png|gif).*");
        /*不要爬取包含 # 的URL*/
        this.addRegex("-https://www.lagou.com/gongsi/.*");
    }

    public void visit(Page page, CrawlDatums next) {
    
            //如果是法制网、四川法制报、司法部，用以下规则
            if(page.matchUrl("http://www.legaldaily.com.cn/.*")||
            		page.matchUrl("http://dzb.scfzbs.com/.*")||
            		page.matchUrl("http://www.moj.gov.cn/.*"))
            {
            	String content = page.select("p").text();
        	    System.out.println("content:\n" + content);
            }
            //如果是，用以下规则
            if(page.matchUrl("http://www.scfz.org/.*"))
            {
            	String content = page.select("td[class=content_word]").text();
        	   System.out.println("content:\n" + content);
            }
           
    }
    
  //爬取法制网、四川法制报、司法部
    private static List<String> getContent(String url) throws IOException {  
        // TODO Auto-generated method stub          
    	 Document doc;  
         doc=Jsoup.connect(url).get(); 
         //标题
         Element title = doc.select("title").first();
         String tString = title.text();
         String strings[] = tString.split("-");
         System.out.println(strings[0]);
 		//正文
         Elements pElements=doc.select("p");
         for (Element element : pElements) {
 			System.out.println(element.text());
 		}
 		return null;          
    }  
    
  //爬取四川法制网
    private static List<String> getContent1(String url) throws IOException {  
        // TODO Auto-generated method stub          
    	 Document doc;  
         doc=Jsoup.connect(url).get(); 
         //标题
         Element title = doc.select("title").first();
        	System.out.println(title.text());
 		//正文
         Elements pElements=doc.select("p");
         for (Element element : pElements) {
 			String pString = element.text();
 			String[] ss = pString.split(" ");
 			for (String string : ss) {
				System.out.println(string);
			}
 		}
 		return null;          
    }  
    
    //爬取人民网
    private static List<String> getContent2(String url) throws IOException {  
        // TODO Auto-generated method stub          
        Document doc;  
        doc=Jsoup.connect(url).get(); 
        //标题
        Element title = doc.select("h1").first();
       	System.out.println(title.text());
		//正文
        Elements pElements=doc.select("div.box_con>p");
        for (Element element : pElements) {
			System.out.println(element.text());
		}
		return null;          
    }  

    public static void main(String[] args) throws Exception {
    	
    	getContent("http://www.legaldaily.com.cn/index_article/content/2017-06/11/content_7200041.htm?node=5955");
    	//人民网
    //	getContent2("http://politics.people.com.cn/n1/2017/0610/c1001-29331177.html");
       
    }

}