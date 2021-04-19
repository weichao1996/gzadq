<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息跳转</title>

	<script type="text/javascript">
           <c:if test="${msg!=null}">
               alert("${msg}");
           </c:if>
           
           <c:if test="${path!=null}">
           document.location.href="<%=path%>/${path}";
           </c:if>
       </script>
   
</head>

</html>