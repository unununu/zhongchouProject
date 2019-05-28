package com.hehuiming.zc.util.bean;

import java.util.List;

import com.hehuiming.zc.bean.User;

public class Page<T> {
	
    private Integer pageNo; //当前页号
    private List<T> dataList; //记录列表
    private Integer pageSize; //每页的记录条数
    private Integer totalPageCount;//总页数
    private Integer totalCount ; //总记录条数
    private Integer pageFirstNO; //本页第一条记录序号
	
	

	public Page(Integer pageNo, Integer pageSize) {
		//控制参数范围
		this.pageNo = pageNo>=1?pageNo:1;
		this.pageSize = pageSize>=1?pageSize:10;
		this.pageFirstNO = (pageNo-1)*pageSize +1;
	}



	public Integer getPageNo() {
		return pageNo;
	}



	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}



	public List<T> getDataList() {
		return dataList;
	}



	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}



	public Integer getPageSize() {
		return pageSize;
	}



	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}



	public Integer getTotalPageCount() {
		return totalPageCount;
	}



	private void setTotalPageCount(Integer totalPageCount) {
		this.totalPageCount = totalPageCount;
	}



	public Integer getTotalCount() {
		return totalCount;
	}



	public void setTotalCount(Integer totalCount) {
		setTotalPageCount(totalCount%pageSize ==0?totalCount/pageSize:totalCount/pageSize+1);
		this.totalCount = totalCount;
		
	}



	public Integer getPageFirstNO() {
		return pageFirstNO;
	}



	public void setPageFirstNO(Integer pageFirstNO) {
		this.pageFirstNO = pageFirstNO;
	}
	

}