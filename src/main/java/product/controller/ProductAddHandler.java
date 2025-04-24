package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import view.command.CommandHandler;

public class ProductAddHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	System.out.println("productRegister 제품 등록 페이지 접근 성공");
    	
            return "/WEB-INF/product/productRegister.jsp";
        }
}