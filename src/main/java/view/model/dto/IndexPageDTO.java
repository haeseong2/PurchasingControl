package view.model.dto;

import java.util.List;



public class IndexPageDTO {
	private int total;
	private int currentPage;
	private List<IndexDTO> indexList;
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

	public List<IndexDTO> getIndexList() {
		return indexList;
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

	public IndexPageDTO(int total, int currentPage, int size, List<IndexDTO> indexList) {
		this.total = total;
		this.currentPage = currentPage;
		this.indexList = indexList;

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
