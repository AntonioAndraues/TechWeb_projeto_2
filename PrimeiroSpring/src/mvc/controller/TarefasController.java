package mvc.controller;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import mvc.model.usuario;
import mvc.model.DAO;

import org.json.JSONObject;
@Controller
public class TarefasController {
	@RequestMapping(value = "/notas", method = RequestMethod.GET)
	public void getnotas(HttpServletRequest request,
			 HttpServletResponse response,RedirectAttributes redirectAttributes) throws IOException {
//		System.out.println("FOIPROGET");
//		System.out.println("rodou");
			
	 }
	@RequestMapping(value = "/notas", method = RequestMethod.PUT)
	@ResponseBody
	 public String  mudanotas(@RequestBody String rawJson,HttpServletRequest request,
			 HttpServletResponse response,RedirectAttributes redirectAttributes) throws IOException {
		try {
			DAO dao = new DAO();
			usuario usuario = new usuario();
			JSONObject parsedJson = new JSONObject(rawJson);
			String email = parsedJson.getString("email");
			String senha = parsedJson.getString("senha");
			String texto = parsedJson.getString("texto");
			String tag = parsedJson.getString("tag");
			String cor = parsedJson.getString("cor");
			String id_nota = parsedJson.getString("id_nota");
			String group = parsedJson.getString("group");

			
			
			usuario.setEmail(email); 
			usuario.setSenha(senha); 
			usuario = dao.loga(usuario);

			
			redirectAttributes.addAttribute("email", request.getParameter("email"));
			redirectAttributes.addAttribute("senha", request.getParameter("senha"));
//			redirectAttributes.addFlashAttribute("email", request.getParameter("email"));
//			redirectAttributes.addFlashAttribute("senha", request.getParameter("senha"));
//			System.out.println(id_nota);
			
			dao.edita_nota(usuario,texto, tag,cor,id_nota);

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
//			System.out.println("rodou");
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
	
	
//	@RequestMapping(value="/notas", method = RequestMethod.DELETE)
//	 @ResponseBody
//	 public String test(@RequestBody String rawJson) {
//		 System.out.println("DELETE");
//		 JSONObject parsedJson = new JSONObject(rawJson);
//		 String email = parsedJson.getString("email");
//		 String senha = parsedJson.getString("senha");
//		 String id = parsedJson.getString("id");
//		 System.out.println("email recebido: " + email);
//		 System.out.println("senha recebido: " + senha);
//		 System.out.println("id recebido: " + id);
//		 return "redirect:/usuario";
//	 }
//	
//	 
//}
//	
	
	
	
	@RequestMapping(value = "/notas", method = RequestMethod.DELETE)
	@ResponseBody
	 public String  deletenotas(@RequestBody String rawJson,HttpServletRequest request,
			 HttpServletResponse response,RedirectAttributes redirectAttributes) throws IOException {
		try {
//			System.out.println("rodou");
			DAO dao = new DAO();
			usuario usuario = new usuario();
			JSONObject parsedJson = new JSONObject(rawJson);
			String email = parsedJson.getString("email");
			String senha = parsedJson.getString("senha");
			String idr = parsedJson.getString("id");
			
			usuario.setEmail(email); 
			usuario.setSenha(senha); 
			usuario = dao.loga(usuario);
			
			String texto=idr; 
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
		return "redirect:http://www.yahoo.com";
	
	}
	
}

