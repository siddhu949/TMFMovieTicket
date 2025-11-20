<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="container mt-4">

    <h2>My Bookings</h2>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Movie</th>
            <th>Show Time</th>
            <th>Status</th>
            <th>Amount</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="b" items="${bookings}">
            <tr>
                <td>${b.id}</td>
                <td>
                    <c:out value="${b.show != null && b.show.movie != null ? b.show.movie.title : 'N/A'}"/>
                </td>
                <td>
                    <c:out value="${b.show != null ? b.show.showTime : 'N/A'}"/>
                </td>
                <td><c:out value="${b.status}"/></td>
                <td>Rs. <c:out value="${b.amount}"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
