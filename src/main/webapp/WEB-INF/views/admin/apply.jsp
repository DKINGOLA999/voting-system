<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List"%>
<html>

<head>

<title>Apply</title>

<style>

body{
font-family:Arial;
background:#f4f4f4;
padding:40px;
}

.form{
background:white;
padding:30px;
width:400px;
margin:auto;
border-radius:8px;
box-shadow:0 0 10px rgba(0,0,0,0.1);
}

input,select,textarea{
width:100%;
padding:10px;
margin-top:10px;
}

button{
margin-top:15px;
padding:10px;
background:#2563eb;
color:white;
border:none;
cursor:pointer;
}

</style>

</head>

<body>

<div class="form">

<h2>Apply To Contest</h2>

<form action="<%=request.getContextPath()%>/apply" method="post">

<select name="position">

<option value="PRESIDENT">President</option>

<option value="VICE_PRESIDENT">Vice President</option>

<option value="SECRETARY">Secretary</option>

<option value="TREASURER">Treasurer</option>

</select>

<textarea name="reason" placeholder="Why should people vote for you?"></textarea>

<button type="submit">

Submit Application

</button>

</form>

</div>

</body>

</html>