package view.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import view.command.CommandHandler;

public class FrontController extends HttpServlet {
    private Map<String, CommandHandler> handlerMap = new HashMap<>();

    @Override
    public void init() throws ServletException {
    	String configPath = getServletContext().getRealPath("/WEB-INF/view/commandHandlerURI.properties");


        Properties prop = new Properties();

        try (FileInputStream fis = new FileInputStream(configPath)) {
            prop.load(fis);
            for (String uri : prop.stringPropertyNames()) {
                String handlerClass = prop.getProperty(uri);
                Class<?> clazz = Class.forName(handlerClass);
                CommandHandler handler = (CommandHandler) clazz.getDeclaredConstructor().newInstance();
                handlerMap.put(uri, handler);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String command = uri.substring(contextPath.length());

        CommandHandler handler = handlerMap.get(command);
        if (handler == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        try {
            String viewPage = handler.process(request, response);
            if (viewPage != null) {
                RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
