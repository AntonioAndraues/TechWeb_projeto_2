package mvc.model;
public class usuario {
	private Integer id_pessoa;
	private String primeiro_nome;
	private String ultimo_nome;
	private String email;
	private String senha;
	
	public Integer getIdPessoa() {
		return this.id_pessoa;}
	
	public void setIdPessoa(Integer id_pessoa) {
		try {
			this.id_pessoa = id_pessoa;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("kfjeejfk");
		}
		}
		
	
	public String getPrimeiroNome() {
		return this.primeiro_nome;}
	
	public void setPrimeiroNome(String primeiro_nome) {
		this.primeiro_nome = primeiro_nome;}
	
	public String getUltimoNome() {
		return this.ultimo_nome;}
	
	public void setUltimoNome(String ultimo_nome) {
		this.ultimo_nome = ultimo_nome;}
	
	public String getEmail() {
		return this.email;}
	
	public void setEmail(String email) {
		this.email = email;}
	
	public String getSenha() {
		return this.senha;}
	
	public void setSenha(String senha) {
		this.senha = senha;}
}
