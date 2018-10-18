package mvc.controller;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import mvc.model.usuario;
import mvc.model.DAO;

@Controller
public class UsuarioController {
	 @RequestMapping(value = "/")
	 public String execute() {
		System.out.println("Login");
		return "login";
	 }
	 @RequestMapping(value = "/register")
	 public String execute2() {
		System.out.println("register");
		return "register";
	 }
	@RequestMapping(value = "/usuario", method = RequestMethod.GET)
	 public String loga(HttpServletRequest request,
			 HttpServletResponse response,RedirectAttributes redirectAttributes) throws IOException {
		try {
			DAO dao = new DAO();
			usuario usuario = new usuario();
			usuario.setEmail(request.getParameter("email")); 
			usuario.setSenha(request.getParameter("senha")); 
			usuario = dao.loga(usuario);
			PrintWriter out = response.getWriter();
			
			if (usuario.getPrimeiroNome()==null) {
				System.out.println("TA AQUIII");
				return "usuario_invalido";
				
			}
			else {
//				response.sendRedirect("index.jsp?email="+usuario.getEmail()+"&senha="+usuario.getSenha());
				
				
			}
			

			dao.close();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "index";
			
	 }
	@RequestMapping(value = "/usuario", method = RequestMethod.POST)
	 public String registra(HttpServletRequest request,
			 HttpServletResponse response,RedirectAttributes redirectAttributes) throws IOException {
		try {
			DAO dao = new DAO();
			usuario usuario = new usuario();
			usuario.setPrimeiroNome(request.getParameter("primeironome")); 
			usuario.setUltimoNome(request.getParameter("ultimonome"));
			usuario.setEmail(request.getParameter("email")); 
			usuario.setSenha(request.getParameter("senha")); 
			if(dao.verifica_existe(usuario)==0) {
				dao.adiciona(usuario);
				dao.close();
				return "login";

			}else {
				
				dao.close();
				return "register_jaexistente";

			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	@RequestMapping(value = "/facebook")
	public String facebook(HttpServletRequest request,
			 HttpServletResponse response,RedirectAttributes redirectAttributes) throws IOException {
		try {
			DAO dao = new DAO();
			usuario usuario = new usuario();
			usuario.setPrimeiroNome(request.getParameter("primeironome")); 
			usuario.setUltimoNome(request.getParameter("ultimonome"));
			usuario.setEmail(request.getParameter("email")); 
			usuario.setSenha(request.getParameter("senha")); 
			if(dao.verifica_existe(usuario)==0) {
				dao.adiciona(usuario);
				dao.close();
				
				return "index";

			}else {
				if (dao.loga(usuario).getIdPessoa()!=null) {
					return "index";
					
				}else {
					return "email_em_uso";
				}
			
			}
		
				
				
				

			}
			 catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
	
}

