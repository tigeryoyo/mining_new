package com.hust.mining.urltags;


import cn.edu.hfut.dmic.webcollector.model.CrawlDatums;


import cn.edu.hfut.dmic.webcollector.model.Page;
import cn.edu.hfut.dmic.webcollector.plugin.berkeley.BreadthCrawler;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.nodes.Document;

public class crawler extends BreadthCrawler {

	
    public crawler(String crawlPath, boolean autoParse) {
        super(crawlPath, autoParse);
        /*不要爬取 jpg|png|gif*/
        this.addRegex("-.*\\.(jpg|png|gif).*");
        /*不要爬取包含 # 的URL*/
        this.addRegex("-https://www.lagou.com/gongsi/.*");
    }

    public void visit(Page page, CrawlDatums next) {
    
            Document doc = page.getDoc();   
            //如果是法制网、四川法制报、司法部，用以下规则
            if(page.matchUrl("http://www.legaldaily.com.cn/.*")||
            		page.matchUrl("http://dzb.scfzbs.com/.*")||
            		page.matchUrl("http://www.moj.gov.cn/.*"))
            {
            	String content = page.select("p").text();
        	   System.out.println("content:\n" + content);
            }
            //如果是四川法制网，用以下规则
            if(page.matchUrl("http://www.scfz.org/.*"))
            {
            	String content = page.select("td[class=content_word]").text();
        	   System.out.println("content:\n" + content);
            }
            //如果是人民网，用以下规则
            if(page.matchUrl("http://.*people.com.cn/.*"))
            {
            	String content = page.select("div[class=fl text_con_left]").text();
        	   System.out.println("content:\n" + content);
            }
         
    }
    

    public static void main(String[] args) throws Exception {
    	crawler crawler = new crawler("crawl", true);
        /*线程数*/
    	List<String> list= new ArrayList<String>();
    	list.add("http://www.legaldaily.com.cn/index_article/content/2017-06/11/content_7200042.htm?node=5955");
    	list.add("http://www.scfz.org/news/html/72-29/29973.htm");
    	list.add("http://dzb.scfzbs.com/shtml/scfzb/20170609/50658.shtml");
    	list.add("http://www.moj.gov.cn/index/content/2017-05/31/content_7186914.htm?node=86528");
    	list.add("http://politics.people.com.cn/n1/2017/0610/c1001-29331177.html");
    	
    	
    	for (String string : list) {
			crawler.addSeed(string);
		}
    	
        crawler.start(1);
       
    }

}