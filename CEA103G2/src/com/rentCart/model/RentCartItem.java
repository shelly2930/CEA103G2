package com.rentCart.model;

public class RentCartItem implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	private Integer fnt_it_no;
	private String fnt_name;
	private Integer fnt_price;
	private Integer quantity;


//	@Override
//	public String toString() {
//		return "BOOK [name=" + name + ", author=" + author + ", publisher=" + publisher + ", price=" + price
//				+ ", quantity=" + quantity + "]";
//	}

	public Integer getFnt_it_no() {
		return fnt_it_no;
	}

	public void setFnt_it_no(Integer fnt_it_no) {
		this.fnt_it_no = fnt_it_no;
	}

	public String getFnt_name() {
		return fnt_name;
	}

	public void setFnt_name(String fnt_name) {
		this.fnt_name = fnt_name;
	}

	public Integer getFnt_price() {
		return fnt_price;
	}

	public void setFnt_price(Integer fnt_price) {
		this.fnt_price = fnt_price;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((fnt_name == null) ? 0 : fnt_name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RentCartItem other = (RentCartItem) obj;
		if (fnt_name == null) {
			if (other.fnt_name != null)
				return false;
		} else if (!fnt_name.equals(other.fnt_name))
			return false;
		return true;
	}

}