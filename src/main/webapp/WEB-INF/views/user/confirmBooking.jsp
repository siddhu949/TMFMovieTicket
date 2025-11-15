<div class="container mt-4">
    <c:if test="${empty booking}">
        <div class="alert alert-warning">
            <h4>Please log in to continue booking</h4>
            <p>You need to be logged in to confirm your booking.</p>
            <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary">Go to Login</a>
        </div>
    </c:if>
    
    <c:if test="${not empty booking}">
        <h2>Confirm Booking</h2>
        <p>Movie: <strong>${booking.show.movie.title}</strong></p>
        <p>Show Time: <strong>${booking.show.showTime}</strong></p>
        <p>Seats:
            <c:forEach var="seat" items="${booking.seats}">
                <span class="badge bg-primary">${seat.seatCode}</span>
            </c:forEach>
        </p>
        <p>Total Amount: Rs. ${booking.amount}</p>

        <form method="post" action="${pageContext.request.contextPath}/booking/confirm">
            <input type="hidden" name="bookingId" value="${booking.id}"/>
            <button class="btn btn-success">Confirm &amp; Pay</button>
            <a href="${pageContext.request.contextPath}/booking/select/${booking.show.id}" 
               class="btn btn-secondary">Cancel</a>
        </form>
    </c:if>
</div>