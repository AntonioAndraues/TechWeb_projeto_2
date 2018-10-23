

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*,mvc.controller.*" %>
     <%@ page import="java.util.*,mvc.model.*" %>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">	

    <title>SB Admin - Dashboard</title>

    <!-- Bootstrap core CSS-->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin.css" rel="stylesheet">

  </head>

  <body id="page-top">

    <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

      <a class="navbar-brand mr-1" href="/%>">Board</a>

      <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
        <i class="fas fa-bars"></i>
      </button>

      <!-- Navbar Search -->
      <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
        <div  class="dropdown">
          <textarea class="form-control" placeholder="Search.." onkeyup="filterFunction()" rows="1" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" id="search_text"  onkeydown="if (event.keyCode == 13) { search_enter(); }"></textarea>
			<div class="input-group-append" >
	   			<button class="btn btn-primary" type="button" id="search_button" onclick="search_enter()">
	   				<i class="fas fa-search"></i>
	   			</button>           
 			</div>
			  <div id="myDropdown" class="dropdown-content" >

			  </div>

        </div>
        
       
      </form>
       <%String email = null;
      	String senha = null;
    	Cookie[] cookies = request.getCookies();
       	if(cookies !=null){
       	for(Cookie cookie : cookies){
       		if(cookie.getName().equals("email")) email = cookie.getValue();
       		if(cookie.getName().equals("senha")) senha = cookie.getValue();
       		
       	}
       	}
       	DAO dao = new DAO(); 
		usuario usuario = new usuario();
	
       	usuario.setEmail(email); 
       	usuario.setSenha(senha);

       	usuario = dao.loga(usuario);
       	List<usuario> lista_usuario = dao.getLista();
       	if(email == null) response.sendRedirect("/PrimeiroSpring/");
       %>
       

      <!-- Navbar -->
      <ul class="navbar-nav ml-auto ml-md-0">
        <li class="nav-item dropdown no-arrow mx-1">
          <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-bell fa-fw"></i>
            <span class="badge badge-danger"><%=dao.checktasks(usuario).size() %></span>
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="alertsDropdown">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </li>
        <li class="nav-item dropdown no-arrow mx-1">
          <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-envelope fa-fw"></i>
            <span class="badge badge-danger"><%= lista_usuario.size()%></span>
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="messagesDropdown">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </li>
        <li class="nav-item dropdown no-arrow">
          <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-user-circle fa-fw"></i>
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
            <a class="dropdown-item" href="#">Settings</a>
            <a class="dropdown-item" href="#">Activity Log</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="/PrimeiroSpring/">Logout</a>
          </div>
        </li>
      </ul>

    </nav>

    <div id="wrapper">

      <!-- Sidebar -->
      <ul class="sidebar navbar-nav">
        <li class="nav-item active">
          <a class="nav-link" href="/PrimeiroSpring/usuario">
            <i class="far fa-calendar-alt"></i>
            <span>Dashboard</span>
          </a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-users"></i>
            <span>Grupos</span>
          </a>
          <div class="dropdown-menu" aria-labelledby="pagesDropdown">
            <h6 class="dropdown-header">Tag:</h6>
            <%
            
			
			Integer usuario_id = usuario.getIdPessoa();
			ArrayList<ArrayList<String>> lista = dao.checktasks(usuario);
			ArrayList<ArrayList<String>> lista_search = new ArrayList<ArrayList<String>>();
			ArrayList<ArrayList<String>> lista_tag = new ArrayList<ArrayList<String>>();
			ArrayList<String> lista_tag_unique = new ArrayList<String>();
			
			for (int i = 0 ; i < lista.size() ; i++) {
				//System.out.println(lista.get(i).get(1));
				String toadd = lista.get(i).get(1).toLowerCase();
				toadd = toadd.substring(0, 1).toUpperCase() + toadd.substring(1); 
				if(!lista_tag_unique.contains(toadd)){
					lista_tag_unique.add(toadd);
				}	
			}
			

			for (String nota : lista_tag_unique ) {%>
            <a class="dropdown-item" style="cursor:pointer;" onclick="tagopen('<%=nota%>')"><%=nota%></a><%}%>
            <div class="dropdown-divider"></div>
            <h6 class="dropdown-header">Mundo:</h6>
            <%
            ArrayList<ArrayList<String>> lista_grupo = dao.getGrupos();
            for(ArrayList<String> grupo : lista_grupo){%>
            	<a class="dropdown-item" style="cursor:pointer;" onclick="group_redirect('<%=grupo.get(0) %>')" ><%=grupo.get(1)%></a>
            <%} %>
            

          </div>
      
        </li>
      </ul>

      <div id="content-wrapper">

        <div class="container-fluid">

          <!-- Breadcrumbs-->
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a href="#">Dashboard</a>
            </li>
            <li class="breadcrumb-item active">Overview</li>
          </ol>
          </div>
          
           <!-- Icon Cards-->
			<div class="row">
			<!-- 	 <a class="nav-link" href="criatask/?texto=OLA TESTE&tag=INSPER&cor=vermelho&email=a@ads&senha=123"> -->
<!-- 				<a class="nav-link" href="criatask?texto=OLA TESTE&tag=INSPER&cor=vermelho&email=a@ads&senha=123">
 -->            <i class="fas fa-plus"></i>
 
 		<!-- CRIANDO FORM PARA TASK  -->
 		 
 
            <input id="myBtn" type="image" src="plus-square-regular.png" alt="Submit" width="30" height="30" style="margin-left:16px;" >
            </div>
            	<div id="myModal" class="modal" >
            		<div class="modal-content">
            			<div class="modal-header" id="NotaDiv" >
            				<span class="close" >&times; </span>
            				<h2 onclick="close_onNota()" role="button" style="cursor:pointer;" >Nota</h2>
            				</div>
            				<div class="modal-body">
            					<div id="formservlet">
            						<div class="form-group">
            							<div class="form-label-group">
            								<input type="text" name="tag" id="inputtag"  placeholder="Insira a tag" class="form-control" placeholder="Tag da sua task" required="required" autofocus="autofocus">
            								</div></div>
            					 	<div class="form-group">
            					 		<div class="form-label-group">
            					 			<input type="text" name="texto" id="inputText" placeholder="Insira o texto" class="form-control" placeholder="Texto" required="required" onerror="Texto invalido">
            					 	</div></div>
            					 	<div class="form-group">
            					 		<div >
            					 			<p style="position: absolute; cursor:pointer; margin-left: 40%; margin-right:40%;width:100%;margin-top: 5px" onclick="riseColor()">Clique aqui para mudar a cor</p>
            					 			<input type="color" name="cor" style="cursor:pointer;" onchange="MudaCor(this.value)"  id="inputCor" class="form-control" placeholder="Cor" required="required" onerror="Cor invalida"  >
            					 	</div></div>
            <input type="hidden" name="email" value="<%=email%>"/>	
            <input type="hidden" name="senha" value="<%=senha%>"/>
            <input type="hidden" name="group" value="<%=request.getParameter("group")%>"/>
             <input type="hidden" name="_method" value="put"/>
            <input id="inputId" type="hidden" name="id_nota" value=""/>			 	 	
            
            <input id="submit_name" type="submit" value='Crie a Nota' class="btn btn-primary btn-block" href=""></input> </div>
			</div></div></div>
			
			
			
		<!-- AREA PARA USO DOS POSTITIS	-->
		  <div class="row">
			
		  	<%  
		  
			 
			if (usuario.getIdPessoa() == null){
				response.sendRedirect("usuario_invalido.jsp");
			}
			if(request.getParameter("search")!=null){
				if(request.getParameter("group")!=null){
					lista = dao.checktasks_all();
				}
				String search_str = request.getParameter("search");
				System.out.println(search_str);
				//System.out.println(Arrays.asList(lista).contains(search_str));
				//System.out.println(search_str);	
			
				for (ArrayList<String> nota : lista ){
					
					if(nota.get(1).toLowerCase().contains(search_str.toLowerCase())){
						lista_search.add(nota);
					
					}else{
						if(nota.get(2).toLowerCase().contains(search_str.toLowerCase())){
							lista_search.add(nota);
							
						}
					}
				}
				lista = lista_search;
			}
			if(request.getParameter("tag")!=null){
				String tag_str = request.getParameter("tag");
				//System.out.println(Arrays.asList(lista).contains(tag_str));
				//System.out.println(tag_str);	
			
				for (ArrayList<String> nota : lista ){
					//System.out.println(nota);	
					if(nota.get(1).toLowerCase().contains(tag_str.toLowerCase())){
						lista_tag.add(nota);
					}else{
						if(nota.get(1).toLowerCase().contains(tag_str.toLowerCase())){
							lista_tag.add(nota);
						}
					}
				}
				lista = lista_tag;
			}else{
				
				if(request.getParameter("group")!=null  && !request.getParameter("group").equals("null")){
					System.out.println("eitcha");
					if(request.getParameter("search")==null){
						lista = dao.checktasks_all();
					}
					ArrayList<ArrayList<String>> notas_grupo = new ArrayList<ArrayList<String>>();
					String grupo_id = request.getParameter("group");
					
					for (ArrayList<String> nota : lista ){
						
						
						
						if(nota.get(4).equals(grupo_id)){
							notas_grupo.add(nota);
						}
					}
					lista = notas_grupo;
				}
				
				
				
			}
			
			
			
			int i = 0;
			for (ArrayList<String> nota : lista ) {%>
				
			  	<div class="col-xl-3 col-sm-6 mb-3" style="margin-left:16px;" >
					<div class="card text-white  o-hidden h-100" style="background-color:<%=nota.get(0)%>">
						<%if(request.getParameter("group")!=null  && !request.getParameter("group").equals("null")){%>
							<span class="float-left2" style="font-size: 20px; font-weight: bold; text-align: center;"><%=nota.get(6) %></span>
							
						<%} %>
						
						
												<span class="float-left"><%=nota.get(1) %></span>							
						<span class="align-content-lg-center"><%=nota.get(2)%></span>
						<div>
							<div id="editaform" ><input type="hidden" name="_method" value="put"/><input id="myBtn-<%=Integer.toString(i)%>" type="image" src="edit-regular.png" 
								data-id="<%=nota.get(3)%>" data-cor="<%=nota.get(0)%>" data-tag="<%=nota.get(1)%>"  data-id_pessoa_nota = "<%=nota.get(5)%>"  data-id_pessoa = "<%=usuario_id%>"  data-text="<%=nota.get(2)%>" data-id="<%=nota.get(3)%>" data-submitname class="BtnEditar"
								width="20" height="20" style="float:right; margin-right:5px;"></div>
						</div>
						<div>
							<input type="hidden" name="email" value="<%=email%>"/>	
           					<input type="hidden" name="senha" value="<%=senha%>"/>
           					<input type="hidden" name="id" value="<%=nota.get(3)%>"/>
           					<input type="image" src="trash.png"  width="20" height="25" style="float:right; margin-right:1px;" data-submitname class="BtnDelete" href="/usuario" data-id_nota="<%=nota.get(3)%>"  data-id_pessoa_nota = "<%=nota.get(5)%>"  data-id_pessoa = "<%=usuario_id%>" >
   						</div>
							
						

							</div>				
			 	</div><%i++;} %>

          	   
			
			</div>

		<!-- FIM AREA PARA USO DOS POSTITIS-->

        <!-- Area Chart Example--><!-- DataTables Example --></div>
		
        <!-- /.container-fluid -->

        <!-- Sticky Footer -->
        <footer class="sticky-footer">
          <div class="container my-auto">
            <div class="copyright text-center my-auto">
              <span>Copyright © TONHO E SAMUCA 2018</span>
            </div>
          </div>
        </footer>

      </div>
      <!-- /.content-wrapper -->

    <!-- /#wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" href="login.jsp" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">Select "Logout" bcccccelow if you are ready to end your current session.</div>
          <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
            <a class="btn btn-primary" href="login.jsp">Logout</a>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<script src="//fast.wistia.net/labs/fresh-url/v1.js" async></script>
    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
	

    <!-- Page level plugin JavaScript-->
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="vendor/datatables/jquery.dataTables.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin.min.js"></script>

    <!-- Demo scripts for this page-->
    <script src="js/demo/datatables-demo.js"></script>
    <script src="js/demo/chart-area-demo.js"></script>
	<!-- Scirpt para task create  -->
	
	<script>

	
	
	
	
// Get the modal
// history.replaceState({}, null, "/index.jsp");
var modal = document.getElementById('myModal');
var edita;

// Get the button that opens the modal
var btn = document.getElementById("myBtn");
var btnArr = document.getElementsByClassName("BtnEditar");
var btn_del_Arr = document.getElementsByClassName("BtnDelete");



// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

var inputCor = document.getElementById('inputCor');
var inputTag = document.getElementById('inputtag');
var inputText = document.getElementById('inputText');
var inputId = document.getElementById('inputId');
var submit_name = document.getElementById('submit_name');
var formservlet = document.getElementById('formservlet');
var cor_atual = document.getElementById("submit_name");
var notadiv = document.getElementById("NotaDiv");
var search_button = document.getElementById("search_button");
var search_text = document.getElementById("search_text");
var search_dropdown = document.getElementById('myDropdown');


// When the user clicks the button, open the modal 
for (var i = 0; i < btnArr.length; i++) {
var btnEdit = btnArr[i];
var id = btnEdit.getAttribute("id").split('-')[1];
id_pessoa_nota = btnEdit.dataset.id_pessoa_nota;
id_pessoa = btnEdit.dataset.id_pessoa;

if(id_pessoa_nota !== id_pessoa){
	
	btnEdit.style.display = "none";
}




	btnEdit.onclick = function(e) {
		

		inputCor.value = e.target.dataset.cor;
		inputTag.value = e.target.dataset.tag;
		inputText.value = e.target.dataset.text;
		inputId.value = e.target.dataset.id;
		
		submit_name.value = "Editar a nota"
		submit_name.style.backgroundColor =  e.target.dataset.cor;
		notadiv.style.backgroundColor = e.target.dataset.cor;

		
		formservlet.action = "notas";
		modal.style.display = "block";
		
		edita = 1;
		
		
			
		
		}
	}




for (var k = 0; k < btn_del_Arr.length; k++) {

	var btnDelete = btn_del_Arr[k];
	
		id_pessoa_nota =btnDelete.dataset.id_pessoa_nota;
		id_pessoa =btnDelete.dataset.id_pessoa;
			
		if(id_pessoa_nota !== id_pessoa){
			
			btnDelete.style.display = "none";
		}

		
		btnDelete.onclick = function(e) {
		
			
			
			
			let email = "<%=email%>"
			let senha = "<%=senha%>"
			let id = e.target.dataset.id_nota

			data = {
				'email': email,
				'senha': senha,
				'id' : id
			}
			
			fetch('/PrimeiroSpring/notas', {
				method: 'DELETE',
				body: JSON.stringify(data)
			})
			
			window.location = "http://localhost:8080/PrimeiroSpring/usuario";
		}
		

		
	}







btn.onclick = function(e) {
    modal.style.display = "block";
    formservlet.action = "notas"
    
   	
    inputTag.value = "";
	inputText.value = "";
	inputId.value = "";
	submit_name.value = "Crie a nota"
	submit_name.style.backgroundColor =  "#2494d7"
	notadiv.style.backgroundColor = "#2494d7"
	inputCor.value = "#2494d7";
	edita=0;
	modal.style.display = "block";
	
	
}

function MudaCor(val) {
    submit_name.style.backgroundColor = val
    notadiv.style.backgroundColor = val
}
function close_onNota(){
	modal.style.display = "none";
}



submit_name.onclick = function(e) {
	if(edita=1){
		let email = "<%=email%>"
			let senha = "<%=senha%>"
			let texto = inputText.value
			let tag = inputTag.value
			let cor = inputCor.value
			let id = inputId.value
			let id_pessoa = e.target.dataset.id_pessoa
			let group = "<%=request.getParameter("group")%>"
			

			data = {
				'email': email,
				'senha': senha,
				'id_pessoa' : id_pessoa,
				'texto' : texto,
				'tag' : tag,
				'cor' : cor,
				'id_nota' : id,
				'group' : group
			}
			
			fetch('/PrimeiroSpring/notas', {
				method: 'PUT',
				body: JSON.stringify(data)
			})
			edita=0
			window.location = "http://localhost:8080/PrimeiroSpring/usuario";
	}
	
	
	
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}




function search_enter(urltoadd){

	var urlParams = new URLSearchParams(window.location.search);
	if(urlParams.has('search')){
		
		var url = window.location.href
	
		
	
		
		urlParams.set("search",search_text.value);
		window.location ="index.jsp?"+urlParams;
		
	}else{
		window.location = window.location.href +"&search="+""+search_text.value+"";
	}
	
	
}

function group_redirect(group){

	window.location = 'http://localhost:8080/PrimeiroSpring/usuario?group='+group;
	
	
}


// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";   
  
    }
    if (document.getElementById('search_text').contains(event.target)){
    	 var toggle = document.getElementById("myDropdown").classList.add("show");

      } else{
    	  var toggle = document.getElementById("myDropdown").classList.remove("show");

      }
    
    
}


function myFunction() {
    var toggle = document.getElementById("myDropdown").classList.toggle("show");
    
}

function fillInput(title) {
	search_text.value=(title);
}
function tagopen(tag) {
	window.location = 'http://localhost:8080/PrimeiroSpring/usuario?tag='+tag;
		
}

function riseColor(){
	inputCor.click();
	
}


function filterFunction() {
	
    var input, filter, ul, li, a, i;
    input = document.getElementById("search_text");
    filter = input.value.toUpperCase();
    div = document.getElementById("myDropdown");
 
    var notetxt = [];
    var txtaux = "";
   
    <%
    String group_id;
    if(request.getParameter("group")!=null){
    	lista = dao.checktasks_all();

    	
    }else{
    	lista = dao.checktasks(usuario);
    }
    
    for (int q = 0; q < lista.size(); q++) {
    	for (int p= 1; p < 3; p++) {
    		
    			
	    		if(lista.get(q).get(4).equals(request.getParameter("group"))){
	    			System.out.println("uai");
	    			
	    			%>
	    			
		    		txtaux = "<%= lista.get(q).get(p)%>";
		    		notetxt.push(txtaux);
		    		
    	<%
    	}else{
    		
    		if(request.getParameter("group")==null  || request.getParameter("group").equals("null")){
    		%>
    		
    		txtaux = "<%= lista.get(q).get(p)%>";
    		notetxt.push(txtaux);
    		
    		<%}
    	}
    		}
    	}
    
    %>
    debugger
    while (div.firstChild) {
        div.removeChild(div.firstChild);
    }
	var lista_str2 = [];
    var nodes = [];
    
   
    
    
    for (i = 0; i < notetxt.length; i++) {
    	 var toadd = notetxt[i].toLowerCase();
    	toadd = toadd.substring(0, 1).toUpperCase() + toadd.substring(1); 
    	if(notetxt[i].toLowerCase().includes(filter.toLowerCase()) && filter!="" && lista_str2.indexOf(toadd)==-1){
	    	var a = document.createElement('a');
	    	var linkText = document.createTextNode(toadd);
	    	a.appendChild(linkText);
	    	lista_str2.push(toadd);
	    	a.title = notetxt[i];
	    	a.href = 'http://localhost:8080/PrimeiroSpring/usuario?group=<%=request.getParameter("group")%>&search='+notetxt[i];
	    	
	    	a.setAttribute("onclick", "fillInput(this.title)");
	    	nodes.push(a);
	    	div.appendChild(a);
    	}
    }
}

</script>
  </body>

</html>


