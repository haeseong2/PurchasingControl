package view.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import view.model.dao.IndexDAO;
import view.model.dto.IndexDTO;
import view.model.dto.IndexPageDTO;

public class IndexHandler implements CommandHandler {

	private IndexDAO iDao = new IndexDAO();
	private int size = 10;
	
	public IndexPageDTO getIndexPage(int pageNum) {
		int firstRow = 0;
		int endRow = 0;
		List<IndexDTO> indexList = new ArrayList<IndexDTO>();
		try {
			int total = iDao.selectCount();
			if (total > 0) {
				firstRow = (pageNum - 1) * size + 1;
				endRow = pageNum * size;
				indexList = iDao.selectIndex(firstRow, endRow);
			}
			return new IndexPageDTO(total, pageNum, size, indexList);
		} catch (Exception e) {
			e.printStackTrace();
			return new IndexPageDTO(0, pageNum, size, indexList);
		}
	}
	
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ProductListHandler アクセス成功");
        request.setCharacterEncoding("UTF-8");
        IndexDAO dao = new IndexDAO();
        
		String pageNoVal = request.getParameter("pageNo");
		int pageNo = 1;
		if (pageNoVal != null && !pageNoVal.isEmpty()) {
			pageNo = Integer.parseInt(pageNoVal);
		}
		
		IndexPageDTO indexPage = this.getIndexPage(pageNo);
		request.setAttribute("indexPage", indexPage);
		request.setAttribute("index", indexPage.getIndexList());
        
		List<IndexDTO> requestResult = dao.requestResult();
        System.out.println("requestResult : "+ requestResult);
        
        request.setAttribute("requestResult", requestResult);
		return "index.jsp";
        }
}

