<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 				prefix="c" 			%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" 				prefix="fmt" 		%>
	<jsp:include page="../views/includes/header.jsp"/>
	
	<div class="container-xl">		
		<div class="page-body">
			<div class="container-xl">
				<div class="row row-cards">
					<div class="col-md-6">
              <div class="card">
                <div class="card-header">
                  <h3 class="card-title">Sign in</h3>
                </div>
                <div class="card-body">
                  <form>
                    <div class="form-group mb-3 row">
                      <label class="form-label col-3 col-form-label">Email address</label>
                      <div class="col">
                        <input type="email" class="form-control" aria-describedby="emailHelp" placeholder="Enter email">
                        <small class="form-hint">We'll never share your email with anyone else.</small>
                      </div>
                    </div>
                    <div class="form-group mb-3 row">
                      <label class="form-label col-3 col-form-label">Password</label>
                      <div class="col">
                        <input type="password" class="form-control" placeholder="Password">
                        <small class="form-hint">
                          Your password must be 8-20 characters long, contain letters and numbers, and must not contain
                          spaces, special characters, or emoji.
                        </small>
                      </div>
                    </div>
                    
                    
                    <div class="form-footer">
	                    <div class="form-group row">
	                      <label class="form-label col-3 col-form-label pt-0">remember me</label>
	                      <div class="col">
	                        <label class="form-check">
	                          <input class="form-check-input" type="checkbox" checked="">
	                          <span class="form-check-label">Option 1</span>
	                        </label>
	                      </div>
	                    </div>
                      	<button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
				</div>
			</div>
		</div>
		
		
			
		
		
		
		
		
		
		
		
		
		
	</div>
		
		
		
		<%-- 
	  	<h1>Custom Login Page</h1>
	  	<h2><c:out value="${error}"/></h2>
	  	<h2><c:out value="${logout}"/></h2>
		
		<form method='post' action="/login">
	  
		  <div>
		    <input type='text' name='username' value='admin'>
		  </div>
		  <div>
		    <input type='password' name='password' value='admin'>
		  </div>
		  <div>
		  <div>
		    <input type='checkbox' name='remember-me'> Remember Me
		  </div>
		
		  <div>
		    <input type='submit'>
		  </div>
		    <input type="hidden" name="${_csrf.parameterName}"
		    value="${_csrf.token}" />
		  
	  </form> --%>
	<jsp:include page="../views/includes/footer.jsp"/>