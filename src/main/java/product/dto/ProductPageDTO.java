package product.dto;

import java.util.List;

public class ProductPageDTO {
	private int total;
	private int currentPage;
	private List<ProductDTO> productList;

	private int totalPages;
	private int startPage;
	private int endPage;

	public int getTotal() {
		return total;
	}

	public boolean getHasNoProducts() {
		return total == 0;
	}

	public boolean getHasProducts() {
		return total > 0;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public List<ProductDTO> getProductList() {
		return productList;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public int getEndPage() {
		return endPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public ProductPageDTO(int total, int currentPage, int size, List<ProductDTO> productList) {
		this.total = total;
		this.currentPage = currentPage;
		this.productList = productList;

		if (total == 0) {
			totalPages = 0;
			startPage = 0;
			endPage = 0;
		} else {
			totalPages = total / size;
			if (total % size > 0) {
				totalPages++;
			}
			int modVal = currentPage % 5;
			startPage = currentPage / 5 * 5 + 1;
			if (modVal == 0) {
				startPage -= 5;
			}

			endPage = startPage + 4;
			if (endPage > totalPages) {
				endPage = totalPages;
			}
		}

	}

}