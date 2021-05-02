package com.furLis.model;

import java.io.Serializable;
import java.sql.Timestamp;

import com.furCat.model.FurCatVO;
import com.furIte.model.FurIteVO;

public class FurLisVO implements java.io.Serializable {
	private Integer fnt_id;
	private Integer fnt_it_no;
	private Timestamp fnt_acq_date;
	private Byte fnt_status;
	private Byte fnt_rent_status;
	private Timestamp fnt_unusable_date;
	
	
	public Timestamp getFnt_acq_date() {
		return fnt_acq_date;
	}
	public void setFnt_acq_date(Timestamp fnt_acq_date) {
		this.fnt_acq_date = fnt_acq_date;
	}
	public Timestamp getFnt_unusable_date() {
		return fnt_unusable_date;
	}
	public void setFnt_unusable_date(Timestamp fnt_unusable_date) {
		this.fnt_unusable_date = fnt_unusable_date;
	}
	private FurIteVO furIteVO;
	private FurCatVO furCatVO;
	
	
	public Integer getFnt_id() {
		return fnt_id;
	}
	public void setFnt_id(Integer fnt_id) {
		this.fnt_id = fnt_id;
	}
	public Integer getFnt_it_no() {
		return fnt_it_no;
	}
	public void setFnt_it_no(Integer fnt_it_no) {
		this.fnt_it_no = fnt_it_no;
	}
	public Byte getFnt_status() {
		return fnt_status;
	}
	public void setFnt_status(Byte fnt_status) {
		this.fnt_status = fnt_status;
	}
	public Byte getFnt_rent_status() {
		return fnt_rent_status;
	}
	public void setFnt_rent_status(Byte fnt_rent_status) {
		this.fnt_rent_status = fnt_rent_status;
	}
	public FurIteVO getFurIteVO() {
		return furIteVO;
	}
	public void setFurIteVO(FurIteVO furIteVO) {
		this.furIteVO = furIteVO;
	}
	public FurCatVO getFurCatVO() {
		return furCatVO;
	}
	public void setFurCatVO(FurCatVO furCatVO) {
		this.furCatVO = furCatVO;
	}
	
	
	
}
