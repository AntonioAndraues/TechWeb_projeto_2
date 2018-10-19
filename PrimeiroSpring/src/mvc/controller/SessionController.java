package mvc.controller;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import mvc.model.usuario;
import util.EnviarEmail;
import mvc.model.DAO;

@Controller
public class SessionController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	@RequestMapping(value = "/session",method = RequestMethod.GET)
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			DAO dao;
			dao = new DAO();
			usuario usuario = new usuario();
			
			usuario.setEmail(request.getParameter("email")); 
			usuario.setSenha(request.getParameter("senha")); 
			usuario = dao.loga(usuario);
			if (usuario.getPrimeiroNome()!=null) {
				Cookie email = new Cookie("email",request.getParameter("email"));
				email.setMaxAge(30*60);
				response.addCookie(email);
				Cookie senha = new Cookie("senha",request.getParameter("senha"));
				senha.setMaxAge(30*60);
				response.addCookie(senha);
				
				
				response.sendRedirect("http://localhost:8080/PrimeiroSpring/usuario");
				
			
		}else{
			response.sendRedirect("http://localhost:8080/PrimeiroSpring/");
		}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		
	
	
	
}


}