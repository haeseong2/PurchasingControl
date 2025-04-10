package requestManagement.dto;

public class RequestDTO {
	private String requestId;
	private String id;
	private String productId;
	private String requestQuantity;
	private String requestStatus;
	private String requestReason;
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
	public RequestDTO() {}
	public RequestDTO(String requestId, String id, String productId, String requestQuantity, String requestStatus,
			String requestReason) {
		super();
		this.requestId = requestId;
		this.id = id;
		this.productId = productId;
		this.requestQuantity = requestQuantity;
		this.requestStatus = requestStatus;
		this.requestReason = requestReason;
	}
	@Override
	public String toString() {
		return "RequestDTO [requestId=" + requestId + ", id=" + id + ", productId=" + productId + ", requestQuantity="
				+ requestQuantity + ", requestStatus=" + requestStatus + ", requestReason=" + requestReason
				+ ", getRequestId()=" + getRequestId() + ", getId()=" + getId() + ", getProductId()=" + getProductId()
				+ ", getRequestQuantity()=" + getRequestQuantity() + ", getRequestStatus()=" + getRequestStatus()
				+ ", getRequestReason()=" + getRequestReason() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString() + "]";
	}
	
	
}
