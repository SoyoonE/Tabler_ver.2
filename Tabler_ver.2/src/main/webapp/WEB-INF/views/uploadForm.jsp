<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="uploadFormAction" method="post" enctype="multipart/form-data">
		<label class="form-label">FILE</label>
		<input type="file" class="form-control" name="uploadFile" multiple>
		<button>Submit</button>
	</form>
</body>
</html>