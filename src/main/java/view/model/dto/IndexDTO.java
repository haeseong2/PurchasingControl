package view.model.dto;

public class IndexDTO {

	private String userName;
	private String productName;
	private String productPrice;
	private String settlementDate;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(String productPrice) {
		this.productPrice = productPrice;
	}
	public String getSettlementDate() {
		return settlementDate;
	}
	public void setSettlementDate(String settlementDate) {
		this.settlementDate = settlementDate;
	}
	
	@Override
	public String toString() {
		return "IndexDTO [userName=" + userName + ", productName=" + productName + ", productPrice=" + productPrice
				+ ", settlementDate=" + settlementDate + ", getUserName()=" + getUserName() + ", getProductName()="
				+ getProductName() + ", getProductPrice()=" + getProductPrice() + ", getSettlementDate()="
				+ getSettlementDate() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
	
}
