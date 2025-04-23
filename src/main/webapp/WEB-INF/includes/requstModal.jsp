<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<!-- 구매요청 모달 -->
	<div class="modal fade" id="requestModal" tabindex="-1"
		aria-labelledby="joinModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="request.do" method="post">
					<div class="modal-header">
						<h5 class="modal-title" id="joinModalLabel">구매 요청</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label for="quantity" class="form-label">수량</label> <input
								type="number" class="form-control" id="quantity" name="quantity"
								required>
						</div>
						<div class="mb-3">
							<label for="reason" class="form-label">요청 사유</label>
							<textarea class="form-control" id="reason" name="reason" rows="3"
								required></textarea>
						</div>
					</div>
					<input type="hidden" id="productId" name="productId"> <input
						type="hidden" id="requestStatus" name="requestStatus" value="0">
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">요청하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- 요청 성공 모달 -->
	<div class="modal fade" id="RequestSuccessModal" tabindex="-1"
		aria-labelledby="RequestSuccessModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="requestSuccessModalLabel">요청 성공</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">요청이 확인되었습니다.</div>
				<div class="modal-footer">
					<a href="requestcheck.do" class="btn btn-primary">내 구매 요청 목록</a>
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 요청 실패 모달 -->
	<div class="modal fade" id="RequestFailModal" tabindex="-1"
		aria-labelledby="RequestFailModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="requestFailModalLabel">요청 실패</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">요청이 실패하였습니다. 다시 확인하여 주십시오.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>