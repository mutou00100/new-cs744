package com.utils;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;


public class SeparatePage {

	
	private int pageNo = 1;
	
	private int pageSize = 10;
	
	
	private int totalRecord;
	
	
	private int totalPage;
	
	
	private Map parameters;
	
	
	private List searchData;
	
	
	private String callUrl;
	
	
	private String separateString;


	public SeparatePage createSeparatePage(String callUrl, int pageNo, int pageSize, 
			int totalRecord, List data, Map parameters){
		
		this.callUrl = callUrl;
	
		this.pageNo = pageNo;
	
		this.pageSize = pageSize;
		this.setSearchData(data);
		this.totalRecord = totalRecord;
		this.parameters = parameters;
		this.adjustData(totalRecord);
		
		createSeparateString();
		
		return this;
	}
	
	private void adjustData(int totalRecord){
		
		if (totalRecord != 0){
			
			if (pageSize > totalRecord){
				pageSize = totalRecord;
			
			} else if (pageSize < 1){
				pageSize = 8;
			}
		
			int remainder = totalRecord % pageSize;
			
			if (remainder == 0){
				totalPage = totalRecord / pageSize;
			
			} else {
				totalPage = totalRecord / pageSize + 1;
			}
		
			if (pageNo < 1){
				pageNo = 1;
		
			} else if (pageNo > totalPage){
				pageNo = totalPage;
			}
		
		} else {
		
			pageSize = 8;
		
			totalPage = 1;
			
			pageNo = 1;
		}
	}
	

	private void createSeparateString(){
	
		String keysAndValues = "";

		if (parameters != null){
		
			Set keySet = parameters.keySet();
			
			if (keySet != null && keySet.size() > 0){
				
				Iterator iterator = keySet.iterator();
			
				while (iterator.hasNext()){
				
					String key = (String)iterator.next();
				
					Object value = parameters.get(key);
					
					keysAndValues += "&" + key + "=" + value; 
				}
			}
		}
	
		StringBuffer sb = new StringBuffer();
		
		sb.append("<form id='jumpPageForm' method='post' onsubmit='return checkPage();'>");
		
		if (pageNo == 1){
			sb.append("first page &nbsp;&nbsp;&nbsp;previous page&nbsp;&nbsp;");
	
		} else {
		
			sb.append("<a href='" + callUrl + "?pageNo=1&pageSize=" + pageSize + keysAndValues + "'>first page</a>&nbsp;&nbsp;");
			sb.append("<a href='" + callUrl + "?pageNo=" + (pageNo - 1) + "&pageSize=" + pageSize + keysAndValues + "'>previous page</a>&nbsp;&nbsp;");
		}
	
		if (pageNo == totalPage){
			sb.append("next page &nbsp;&nbsp;last page &nbsp;&nbsp;");
	
		} else {
			sb.append("<a href='"+ callUrl +"?pageNo="+ (pageNo + 1) + "&pageSize=" + pageSize + keysAndValues + "'>next page</a>&nbsp;&nbsp;");
			sb.append("<a href='"+ callUrl +"?pageNo="+ totalPage + "&pageSize=" + pageSize + keysAndValues +"'>last page</a>&nbsp;&nbsp;");
		}
		
		sb.append("current/total&nbsp;");
		sb.append(pageNo + "/" + totalPage);
		
		sb.append("&nbsp;&nbsp;all&nbsp;");
		sb.append(totalRecord);
		sb.append("&nbsp;item &nbsp;&nbsp;jump to");
		
		sb.append("<input type='text' id='jumpPage' value='"+ pageNo +"' onmouseover='this.focus();this.select()' style='width:50px;' />");
		
		sb.append("<input type='submit' id='btn' value='go' /></form>");
		
		sb.append("<script language='javascript'>");
		sb.append("function checkPage(){");
		
		sb.append("var pageNo = document.getElementById('jumpPage').value;");
		
		sb.append("if (isNaN(pageNo)){alert('invalid input');return false;}else{");
	
		sb.append("if (pageNo < 1 || pageNo > " + totalPage + "){alert('invalid input');return false;}else{");
	
		sb.append("var form = document.getElementById('jumpPageForm'); var btn = document.getElementById('btn');");
	
		sb.append("var action = '"+ callUrl +"?pageNo=' + pageNo + '&pageSize=" + pageSize + keysAndValues +"';");
		sb.append("form.action = action; document.getElementById('btn').disabled = true; return true;}}");
		sb.append("}</script>");
		
		separateString = sb.toString();
	}
	
	public int getPageNo() {
		return pageNo;
	}
	
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
	public int getPageSize() {
		return pageSize;
	}
	
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public Map getParameters() {
		return parameters;
	}
	
	public void setParameters(Map parameters) {
		this.parameters = parameters;
	}

	public String getCallUrl() {
		return callUrl;
	}

	public void setCallUrl(String callUrl) {
		this.callUrl = callUrl;
	}

	public String getSeparateString() {
		return separateString;
	}

	public void setSeparateString(String separateString) {
		this.separateString = separateString;
	}

	public int getTotalRecord() {
		return totalRecord;
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public List getSearchData() {
		return searchData;
	}

	public void setSearchData(List searchData) {
		this.searchData = searchData;
	}
}