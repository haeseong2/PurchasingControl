package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import view.command.CommandHandler;

public class ProductAddHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	request.setCharacterEncoding("UTF-8");
    	System.out.println("productRegister 製品登録ページへのアクセス成功");
    	
            return "/WEB-INF/product/productRegister.jsp";
        }
}