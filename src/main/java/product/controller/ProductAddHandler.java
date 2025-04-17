package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.dao.ProductDAO;
import product.dto.ProductDTO;
import view.command.CommandHandler;

public class ProductAddHandler implements CommandHandler {

    private ProductDAO productDAO = new ProductDAO();

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // POST 요청일 때, 폼에서 입력 받은 데이터를 받아옴
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            String Quantity = request.getParameter("Quantity");

            // ProductDTO 객체 생성
            ProductDTO product = new ProductDTO(id, name, description, price, Quantity);

            // ProductDAO를 통해 데이터베이스에 추가
            productDAO.insertProduct(product);

            // 성공적으로 추가된 후, 제품 목록으로 리다이렉트
            response.sendRedirect("productList.do");
            return null; // 리다이렉트 시에는 뷰를 반환하지 않음
        } else {
            // GET 요청일 때는 제품 등록 폼 페이지로 이동
            return "/WEB-INF/product/productRegister.jsp";
        }
    }
}
