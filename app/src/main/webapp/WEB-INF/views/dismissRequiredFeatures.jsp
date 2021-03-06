<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>eCare</title>
    <link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet"></link>
    <link href="<c:url value='/resources/css/app.css' />" rel="stylesheet"></link>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css" />
</head>

<body>
<%@ include file="menu.jsp" %>
<%--<form:form method="POST" modelAttribute="selectedFeatures" class="form-horizontal">--%>
<div class="generic-container">
    <div class="panel panel-default">
        <div class="panel-heading"><span class="lead">List of Options </span></div>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>name</th>
                <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
                    <th width="100"></th>
                </sec:authorize>
                <sec:authorize access="hasRole('ADMIN')">
                    <th width="100"></th>
                </sec:authorize>
                <sec:authorize access="hasRole('USER')">
                    <th width="300"></th>
                </sec:authorize>

            </tr>
            </thead>
            <tbody>

            <c:forEach items="${features}" var="feature">
                <c:forEach items="${feature.requiredFeatures}" var="requiredFeature">
                    <tr>
                        <td>${feature.featureName}</td>
                        <td>${requiredFeature.featureName}</td>
                        <sec:authorize access="hasRole('ADMIN')">
                            <td><a href="<c:url value='/features/dismissRequiredFeatures/${requiredFeature.featureId}_${feature.featureId}' />" class="btn btn-success custom-width">Dismiss</a></td>
                        </sec:authorize>
                    </tr>
                </c:forEach>
            </c:forEach>
            </tbody>
        </table>
        <%--</form:form>--%>
    </div>

    <ul class="pagination">
        <c:url value="/features/listFeatures" var="prev">
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
                    <c:url value="/features/listFeatures" var="url">
                        <c:param name="page" value="${i.index}"/>
                    </c:url>
                    <li><a href='<c:out value="${url}" />'>${i.index}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:url value="/features/listFeatures" var="next">
            <c:param name="page" value="${page + 1}"/>
        </c:url>
        <c:if test="${page + 1 <= maxPages}">
            <li><a href='<c:out value="${next}" />' class="pn next">Next</a></li>
        </c:if>
    </ul>
</div>
</body>
</html>