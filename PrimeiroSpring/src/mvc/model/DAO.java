package mvc.model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mvc.model.usuario;



public class DAO {
	private Connection connection = null;
	public DAO() throws ClassNotFoundException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost/meus_dados", "root", "root");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
public List<usuario> getLista() {
	List<usuario> listausuarios = new ArrayList<usuario>();
	try {
		PreparedStatement stmt = connection
				.prepareStatement("SELECT * FROM usuario");
		stmt.execute();
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			try {
				usuario usuario = new usuario();
				usuario.setIdPessoa(rs.getInt("id_pessoa"));
				usuario.setPrimeiroNome(rs.getString("primeiro_nome"));
				usuario.setUltimoNome(rs.getString("ultimo_nome"));
				usuario.setEmail(rs.getString("email"));
				usuario.setSenha(rs.getString("senha"));
				listausuarios.add(usuario);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	} catch (SQLException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	return listausuarios;
	
}
public void close() {
try {
	connection.close();
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
}
public void adiciona(usuario usuario) {
	String sql = "INSERT INTO usuario" +
			"(primeiro_nome,ultimo_nome,email,senha) values(?,?,?,?)";
	try {
		PreparedStatement stmt = connection.prepareStatement(sql);
		stmt.setString(1,usuario.getPrimeiroNome());
		stmt.setString(2,usuario.getUltimoNome());
		stmt.setString(3,usuario.getEmail());
		stmt.setString(4,usuario.getSenha());
		stmt.execute();
		stmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}

public void altera(usuario usuario) {
	try {
		String sql = "UPDATE usuario SET " +
				 "primeiro_nome=?,ultimo_nome=?, email=?, senha=? WHERE id_pessoa=?";
		PreparedStatement stmt = connection.prepareStatement(sql);
		stmt.setString(1, usuario.getPrimeiroNome());
		stmt.setString(2, usuario.getUltimoNome());
		stmt.setString(3, usuario.getEmail());
		stmt.setString(4, usuario.getSenha());
		stmt.setInt(5, usuario.getIdPessoa());
		stmt.execute();
		stmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}
public void remove(Integer id) {
	try {
		PreparedStatement stmt = connection
				.prepareStatement("DELETE FROM usuario WHERE id_pessoa=?");
		stmt.setLong(1, id);
		stmt.execute();
		stmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
}
public usuario loga(usuario usuario) {
	try {
		PreparedStatement stmt = connection
				.prepareStatement("SELECT * FROM usuario WHERE email=? AND senha=?");
		stmt.setString(1,usuario.getEmail());
		stmt.setString(2,usuario.getSenha());
		stmt.execute();
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {	
			usuario.setIdPessoa(rs.getInt("id_pessoa"));
			usuario.setPrimeiroNome(rs.getString("primeiro_nome"));
			usuario.setUltimoNome(rs.getString("ultimo_nome"));
		}
//		
		stmt.close();
		rs.close();
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return usuario;
			}
public void criatask(usuario usuario, String texto, String tag,String cor,String grupo) {
	try {
		PreparedStatement stmt = connection
				.prepareStatement("INSERT nota(id_pessoa,cor,tag,texto,id_grupo) VALUES (?,?,?,?,?)");
		stmt.setInt(1,usuario.getIdPessoa());
		stmt.setString(2,cor);
		stmt.setString(3,tag);
		stmt.setString(4,texto);
		if(grupo.equals("null")) {
			stmt.setString(5,"0");
			
			
		}else {
			System.out.println(grupo);
			stmt.setString(5,grupo);
		}
		
		stmt.execute();		
		stmt.close();
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
			}

public ArrayList<ArrayList<String>> checktasks(usuario usuario) {
	ArrayList<ArrayList<String>> lista = new ArrayList<ArrayList<String>>();
	try {
		PreparedStatement stmt = connection
				.prepareStatement("SELECT * FROM nota WHERE id_pessoa=?");
			stmt.setInt(1,usuario.getIdPessoa());
			stmt.execute();		
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {	
				ArrayList<String> singlelist = new ArrayList<String>();
				singlelist.add(rs.getString("cor"));
				singlelist.add(rs.getString("tag"));
				singlelist.add(rs.getString("texto"));
				singlelist.add(Integer.toString(rs.getInt("id_nota")));
				singlelist.add(Integer.toString(rs.getInt("id_grupo")));
				singlelist.add(Integer.toString(rs.getInt("id_pessoa")));
				lista.add(singlelist);
				
			}
			rs.close();
			stmt.close();
		} 
	catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();	
			usuario.setIdPessoa(null);
		}
	return lista;
			}

public ArrayList<ArrayList<String>> checktasks_all() {
	ArrayList<ArrayList<String>> lista = new ArrayList<ArrayList<String>>();
	try {
		PreparedStatement stmt = connection
				.prepareStatement("SELECT * FROM nota ");
			stmt.execute();		
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {	
				ArrayList<String> singlelist = new ArrayList<String>();
				singlelist.add(rs.getString("cor"));
				singlelist.add(rs.getString("tag"));
				singlelist.add(rs.getString("texto"));
				singlelist.add(Integer.toString(rs.getInt("id_nota")));
				singlelist.add(Integer.toString(rs.getInt("id_grupo")));
				singlelist.add(Integer.toString(rs.getInt("id_pessoa")));

				
				
				PreparedStatement stmt2 = connection
						.prepareStatement("SELECT * FROM usuario WHERE id_pessoa=?");
				
					stmt2.setInt(1,rs.getInt("id_pessoa"));
					stmt2.execute();		
					ResultSet rs2 = stmt2.executeQuery();
					
					while (rs2.next()) {
						singlelist.add(rs2.getString("primeiro_nome"));
					}
					rs2.close();
					stmt2.close();
					
				
				lista.add(singlelist);
				
			}
			rs.close();
			stmt.close();
		} 
	catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();	
		
		}
	return lista;
			}


public ArrayList<ArrayList<String>> getGrupos() {
	ArrayList<ArrayList<String>> lista_grupos = new ArrayList<ArrayList<String>>();
	try {
		PreparedStatement stmt = connection
				.prepareStatement("SELECT * FROM grupos");
		try {			
		} catch (Exception e) {
			// TODO: handle exception			
		}
		
		stmt.execute();		
		
		ResultSet rs = stmt.executeQuery();
		
		while (rs.next()) {	
			ArrayList<String> singlelist = new ArrayList<String>();
			singlelist.add(Integer.toString(rs.getInt("id")));
			singlelist.add(rs.getString("nome"));			
			lista_grupos.add(singlelist);
			
		}
		
		rs.close();
		stmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		System.out.println("feifjiejie");
	}
	
	return lista_grupos;
			}


public void deleta_nota(Integer id) {
	try {
		PreparedStatement stmt = connection
				.prepareStatement("DELETE FROM nota WHERE id_nota=?");
		System.out.println(id);
		stmt.setLong(1, id);
		stmt.execute();
		stmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
}
public int verifica_existe(usuario usuario) {
	try {
		PreparedStatement stmt = connection
				.prepareStatement("SELECT email FROM usuario WHERE email = ?;");
		
		//stmt.set(1, id);
		stmt.setString(1,usuario.getEmail());
		stmt.execute();
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			stmt.close();
			return 1;
		}else {
			stmt.close();
			return 0;
		}
		
		
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return 0;
	
}


public void edita_nota(usuario usuario, String texto, String tag,String cor, String id) {
	try {
		PreparedStatement stmt = connection
				.prepareStatement("UPDATE nota SET id_pessoa = ? , cor = ?, tag = ? ,texto = ? WHERE id_nota=?");
	
		stmt.setInt(1,usuario.getIdPessoa());
		stmt.setString(2,cor);
		stmt.setString(3,tag);
		stmt.setString(4,texto);
		stmt.setInt(5, Integer.parseInt(id));
		
		stmt.execute();
		stmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
}
public usuario recupera_senha(usuario usuario) {
	try {
		PreparedStatement stmt = connection
				.prepareStatement("SELECT * FROM usuario WHERE email=?");
		stmt.setString(1,usuario.getEmail());
		stmt.execute();
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {	
			usuario.setPrimeiroNome(rs.getString("primeiro_nome"));
			usuario.setUltimoNome(rs.getString("ultimo_nome"));
			usuario.setSenha(rs.getString("senha"));
		}
//		
		stmt.close();
		rs.close();
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return usuario;
			}
}

