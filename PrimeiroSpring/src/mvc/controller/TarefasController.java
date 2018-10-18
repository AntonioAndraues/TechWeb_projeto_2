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
public class TarefasController {
	@RequestMapping(value = "/notas", method = RequestMethod.PUT)
	 public String getnotas(HttpServletRequest request,
			 HttpServletResponse response,RedirectAttributes redirectAttributes) throws IOException {
		try {
			DAO dao = new DAO();
			usuario usuario = new usuario();
			usuario.setEmail(request.getParameter("email")); 
			usuario.setSenha(request.getParameter("senha")); 
			usuario = dao.loga(usuario);
			
			String texto=request.getParameter("texto"); 
			String tag=request.getParameter("tag"); 
			String cor=request.getParameter("cor");
			String id_nota=request.getParameter("id_nota");
			String group=request.getParameter("group");
			redirectAttributes.addAttribute("email", request.getParameter("email"));
			redirectAttributes.addAttribute("senha", request.getParameter("senha"));
//			redirectAttributes.addFlashAttribute("email", request.getParameter("email"));
//			redirectAttributes.addFlashAttribute("senha", request.getParameter("senha"));
			
			
			dao.edita_nota(usuario,texto,tag,cor,id_nota);

			dao.close();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/usuario";
			
	 }
	@RequestMapping(value = "/notas", method = RequestMethod.POST)
	 public String postnotas(HttpServletRequest request,
			 HttpServletResponse response,RedirectAttributes redirectAttributes) throws IOException {
		try {
			DAO dao = new DAO();
			usuario usuario = new usuario();
			usuario.setEmail(request.getParameter("email")); 
			usuario.setSenha(request.getParameter("senha")); 
			usuario = dao.loga(usuario);
			String texto=request.getParameter("texto"); 
			String tag=request.getParameter("tag"); 
			String cor=request.getParameter("cor");
			String grupo=request.getParameter("group");
			dao.criatask(usuario, texto, tag, cor,grupo);
			dao.close();
			redirectAttributes.addAttribute("email", request.getParameter("email"));
			redirectAttributes.addAttribute("senha", request.getParameter("senha"));
//			redirectAttributes.addFlashAttribute("email", request.getParameter("email"));
//			redirectAttributes.addFlashAttribute("senha", request.getParameter("senha"));

			}
			catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/usuario";
		
	}
	@RequestMapping(value = "/notas", method = RequestMethod.DELETE)
	 public String deletenotas(HttpServletRequest request,
			 HttpServletResponse response,RedirectAttributes redirectAttributes) throws IOException {
		try {
			DAO dao = new DAO();
			usuario usuario = new usuario();
			usuario.setEmail(request.getParameter("email")); 
			usuario.setSenha(request.getParameter("senha")); 
			usuario = dao.loga(usuario);
			
			String texto=request.getParameter("id"); 
//			System.out.println(texto);
			int id = Integer.parseInt(texto); 
//			System.out.println(id);
			dao.deleta_nota(id);
			dao.close();
			redirectAttributes.addAttribute("email", request.getParameter("email"));
			redirectAttributes.addAttribute("senha", request.getParameter("senha"));

			}
			catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/usuario";
	
	}
	
}

