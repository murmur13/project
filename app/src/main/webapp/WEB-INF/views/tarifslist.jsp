<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Tarifs List</title>
    <link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet"></link>
    <link href="<c:url value='/resources/css/app.css' />" rel="stylesheet"></link>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css" />
</head>

<body>
<%@ include file="menu.jsp" %>
<div class="generic-container">
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading"><span class="lead">List of Tarifs </span></div>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>name</th>
                <th>price (&#8381)</th>
                <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
                    <th width="100"></th>
                </sec:authorize>
                <sec:authorize access="hasRole('USER')">
                    <th width="200"></th>
                </sec:authorize>
                <sec:authorize access="hasRole('ADMIN')">
                    <th width="100"></th>
                </sec:authorize>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${tarifs}" var="tarif">
                <tr>
                    <td>${tarif.name}</td>
                    <td>${tarif.price}</td>
                    <sec:authorize access="hasRole('USER')">
                        <td><a href="<c:url value='/cart/${tarif.tarifId}/addTarifToCart' />" class="btn btn-success custom-width">Add tarif to cart</a></td>
                    </sec:authorize>
                    <sec:authorize access="hasRole('USER')">
                        <td><a href="<c:url value='/contracts/changeTarif-${tarif.tarifId}' />" class="btn btn-success custom-width">Change tarif</a></td>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
                        <td><a href="<c:url value='/tarifs/edit-tarif-${tarif.tarifId}' />" class="btn btn-success custom-width">edit</a></td>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ADMIN')">
                        <td><a href="<c:url value='/tarifs/delete-tarif-${tarif.tarifId}' />" class="btn btn-danger custom-width">delete</a></td>
                    </sec:authorize>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <sec:authorize access="hasRole('ADMIN')">
        <div class="well">
            <a href="<c:url value='/tarifs/newtarif' />">Add New Tarif</a>
        </div>
    </sec:authorize>

    <ul class="pagination">
        <c:url value="/tarifs/listTarifs" var="prev">
            <c:param name="page" value="${page-1}"/>
        </c:url>
        <c:if test="${page > 1}">
            <li> <a href="<c:out value="${prev}" />" class="pn prev">Prev</a></li>
        </c:if>

        <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
            <c:choose>
                <c:when test="${page == i.index}">
                    <li class="active"><span>${i.index}</span><li>
                </c:when>
                <c:otherwise>
                    <c:url value="/tarifs/listTarifs" var="url">
                        <c:param name="page" value="${i.index}"/>
                    </c:url>
                    <li><a href='<c:out value="${url}" />'>${i.index}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:url value="/tarifs/listTarifs" var="next">
            <c:param name="page" value="${page + 1}"/>
        </c:url>
        <c:if test="${page + 1 <= maxPages}">
            <li><a href='<c:out value="${next}" />' class="pn next">Next</a></li>
        </c:if>
    </ul>
</div>
</body>
</html>