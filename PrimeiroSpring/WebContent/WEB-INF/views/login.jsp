<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
 <%@ page import="java.util.*,mvc.controller.*" %>
     <%@ page import="java.util.*,mvc.model.*" %>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin - Login</title>

<!-- Bootstrap core CSS-->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">

<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet">

</head>

<body class="bg-dark">
<!-- function para post redirect -->
<script>
function redirectPost(url, data) {
    var form = document.createElement('form');
    document.body.appendChild(form);
    form.method = 'get';
    form.action = url;
    for (var name in data) {
        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = name;
        input.value = data[name];
        form.appendChild(input);
    }
    form.submit();
}
</script>

<!-- FACEBOOK LOGIN API CONNECT  -->


<!-- script para redirect facebook End  -->
<script>
<!-- script para redirect facebook -->



	/*  */
function statusChangeCallback(response) {
	 console.log('statusChangeCallback');
	 console.log(response);

	 if (response.status === 'connected') {
	
	 LOGIN();
	 } else if (response.status === 'not_authorized') {
	
	 document.getElementById('status').innerHTML = 'Erro: not_authorized  ';
	 } else {
		 document.getElementById('status').innerHTML = 'Erro: Nao identificado  ';
	 }
	 }
	 /*  */
function checkLoginState() {
	 FB.getLoginStatus(function(response) {
	 statusChangeCallback(response);
	 });
	 }
	 /*  */
window.fbAsyncInit = function() {
 FB.init({ 
 appId : '421031825096376',
 cookie : true, 

 xfbml : true, 
 version : 'v3.1' 
 });


 FB.getLoginStatus(function(response) {
 statusChangeCallback(response);
 });
 };
 	/*  */
 (function(d, s, id) {
	 var js, fjs = d.getElementsByTagName(s)[0];
	 if (d.getElementById(id)) return;
	 js = d.createElement(s); js.id = id;
	 js.src = "//connect.facebook.net/en_US/sdk.js";
	 fjs.parentNode.insertBefore(js, fjs);
	 }(document, 'script', 'facebook-jssdk')); 
 	/*  */
 	function LOGIN() { 
 		
 		console.log('Welcome! Fetching your information.... ');
 		FB.api('/me?fields=name,email', function(response) {
 		
 			
 		console.log('Successful login for: ' + response.name); 
 		email=response.email;
 		senha=response.name.replace(" ", "_");
 		primeironome=response.name.replace(/ .*/,'');
 		sobrenome=response.name.replace(primeironome,'');
 		redirectPost('http://localhost:8080/PrimeiroSpring/facebook', { email: email, senha: senha, primeironome: primeironome, ultimonome: sobrenome });
 		/* window.location.assign("http://localhost:8080/PrimeiroSpring/facebook?email="+email +"&senha=" + senha+ "&primeironome=" + primeironome + "&ultimonome=" +sobrenome); */
 
 
 });	
 		
 } 
 	/*  */
 	
 
  </script>
  
  

<!-- END OF FACEBOOK LOGIN API CONNECT -->
	<div class="container">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">Login</div>
			<div class="card-body">
				<form action="login" method="get">
					<div class="form-group">
						<div class="form-label-group">
							<input type="email" name="email" id="inputEmail"
								class="form-control" placeholder="Email address"
								required="required" autofocus="autofocus"> <label
								for="Email">Email</label>
						</div>
					</div>
					<div class="form-group">
						<div class="form-label-group">
							<input type="password" name="senha" id="inputPassword"
								class="form-control" placeholder="Password" required="required"
								onerror="Senha incorreta"> <label for="inputPassword">Senha</label>
						</div>
					</div>
					<div class="form-group">
						<div class="checkbox">
							<label> <input type="checkbox" value="remember-me">
								Remember Password
							</label>
						</div>
					</div>
					<input type="submit" value='Login'
						class="btn btn-primary btn-block" href=""></input>

<div style="padding-top: 10px;width: 100%; " class="fb-login-button" data-max-rows="1" data-size="large" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="true" onlogin="checkLoginState();"></div>				
				</form>
				<div class="text-center">
					<a class="d-block small mt-3" href="register">Register an
						Account</a> <a class="d-block small" href="forgotpassword">Forgot
						Password?</a>
				</div>
				
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>


</body>

</html>
