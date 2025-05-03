package requestManagement.dto;

import java.util.Date;

public class RequestDTO {
	private String requestId;
	private String id;
	private String productId;
	private String requestQuantity;
	private String requestStatus;
	private String requestReason;
	private Date requestDate;
	private String rejectReason;
	private String userName;
	private String prodoctName;
	
	

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getProdoctName() {
		return prodoctName;
	}
	public void setProdoctName(String prodoctName) {
		this.prodoctName = prodoctName;
	}
	public String getRequestId() {
		return requestId;
	}
	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	
	public String getRequestQuantity() {
		return requestQuantity;
	}
	public void setRequestQuantity(String requestQuantity) {
		this.requestQuantity = requestQuantity;
	}
	
	public String getRequestStatus() {
		return requestStatus;
	}
	public void setRequestStatus(String requestStatus) {
		this.requestStatus = requestStatus;
	}
	
	public String getRequestReason() {
		return requestReason;
	}
	public void setRequestReason(String requestReason) {
		this.requestReason = requestReason;
	}
	
	public Date getRequestDate() {
		return requestDate;
	}
	public void setRequestDate(Date requestDate) {
		this.requestDate = requestDate;
	}
	
	public String getRejectReason() {
		return rejectReason;
	}
	public void setRejectReason (String rejectReason) {
		this.rejectReason = rejectReason;
	}

	
	
	public RequestDTO() {}
	public RequestDTO(String requestId, String id, String productId, String requestQuantity, String requestStatus,
			String requestReason, Date requestDate, String rejectReason) {
		super();
		this.requestId 			= requestId;
		this.id 				= id;
		this.productId 			= productId;
		this.requestQuantity 	= requestQuantity;
		this.requestStatus 		= requestStatus;
		this.requestReason 		= requestReason;
		this.requestDate 		= requestDate;
		this.rejectReason 		= rejectReason;
	}
	@Override
	public String toString() {
		return "RequestDTO [requestId=" + requestId + ", id=" + id + ", productId=" + productId + ", requestQuantity="
				+ requestQuantity + ", requestStatus=" + requestStatus + ", requestReason=" + requestReason
				+ ", requestDate=" + requestDate + ", rejectReason=" + rejectReason + ", userName=" + userName
				+ ", prodoctName=" + prodoctName + "]";
	}

	

	
	
}
