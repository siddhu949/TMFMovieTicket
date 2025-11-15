<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<div class="container mt-4">
    <h2>${pageTitle}</h2>
    
    <!-- Legend -->
    <div class="seat-legend mb-3">
        <span class="legend-item"><span class="legend-box available-regular"></span> Regular</span>
        <span class="legend-item"><span class="legend-box available-vip"></span> VIP</span>
        <span class="legend-item"><span class="legend-box selected"></span> Selected</span>
        <span class="legend-item"><span class="legend-box booked"></span> Booked</span>
    </div>
    
    <form id="bookingForm" method="post" action="${pageContext.request.contextPath}/booking/hold">
        <input type="hidden" name="showId" value="${show.id}" />
        
        <div class="seat-grid" style="display: grid; grid-template-columns: repeat(${show.seatTemplate.cols}, 40px); gap: 6px;">
            <c:forEach var="seat" items="${templateSeats}">
                <div class="seat ${seat.seatType.toLowerCase()} available" 
                     data-id="${seat.id}" 
                     data-price="${seat.price}"
                     data-type="${seat.seatType.toLowerCase()}">
                    ${seat.seatCode}
                </div>
            </c:forEach>
        </div>
        
        <div class="booking-summary mt-3">
            <p>Selected Seats: <span id="selectedCount">0</span></p>
            <p>Total Price: Rs<span id="totalPrice">0.00</span></p>
        </div>
        
        <input type="hidden" name="seatIds" id="seatIds"/>
        <button type="submit" class="btn btn-primary mt-3" id="submitBtn" disabled>Proceed to Confirm</button>
    </form>
</div>

<script>
    const selectedSeats = new Map(); // Store seat id and price
    
    // Get booked seat IDs from backend
    const bookedSeatIds = new Set([
        <c:forEach var="seatId" items="${bookedSeatIds}" varStatus="status">
            ${seatId}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ]);
    
    document.querySelectorAll('.seat').forEach(seat => {
        const id = parseInt(seat.dataset.id);
        
        // Mark booked seats
        if (bookedSeatIds.has(id)) {
            seat.classList.remove('available');
            seat.classList.add('booked');
            return; // Skip adding click listener
        }
        
        // Add click listener for available seats
        seat.addEventListener('click', () => {
            const price = parseFloat(seat.dataset.price);
            const seatIdStr = seat.dataset.id;
            
            if (selectedSeats.has(seatIdStr)) {
                selectedSeats.delete(seatIdStr);
                seat.classList.remove('selected');
            } else {
                selectedSeats.set(seatIdStr, price);
                seat.classList.add('selected');
            }
            
            updateBookingSummary();
        });
    });
    
    function updateBookingSummary() {
        const count = selectedSeats.size;
        const total = Array.from(selectedSeats.values()).reduce((sum, price) => sum + price, 0);
        
        document.getElementById('selectedCount').textContent = count;
        document.getElementById('totalPrice').textContent = total.toFixed(2);
        document.getElementById('seatIds').value = Array.from(selectedSeats.keys()).join(',');
        document.getElementById('submitBtn').disabled = count === 0;
    }
</script>

<style>
    .seat-legend {
        display: flex;
        gap: 20px;
        padding: 10px;
        background-color: #f8f9fa;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    
    .legend-item {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
    }
    
    .legend-box {
        width: 30px;
        height: 30px;
        border-radius: 4px;
        display: inline-block;
        border: 1px solid #ddd;
    }
    
    .seat {
        width: 40px;
        height: 40px;
        border-radius: 4px;
        text-align: center;
        line-height: 40px;
        font-size: 11px;
        font-weight: bold;
        border: 2px solid transparent;
        transition: all 0.2s ease;
    }
    
    /* Available seats */
    .seat.available {
        cursor: pointer;
    }
    
    .seat.available.regular {
        background-color: #6c757d;
        color: #fff;
    }
    
    .seat.available.vip {
        background-color: #ffc107;
        color: #000;
    }
    
    .seat.available:hover {
        transform: scale(1.15);
        border-color: #007bff;
        box-shadow: 0 2px 8px rgba(0,123,255,0.3);
    }
    
    /* Selected seats - higher specificity to override type colors */
    .seat.available.selected {
        background-color: #28a745 !important;
        color: #fff !important;
        border-color: #1e7e34;
        transform: scale(1.05);
        box-shadow: 0 2px 8px rgba(40,167,69,0.4);
    }
    
    /* Booked seats */
    .seat.booked {
        background-color: #dc3545 !important;
        color: #fff !important;
        cursor: not-allowed;
        opacity: 0.6;
        position: relative;
    }
    
    .seat.booked::after {
        content: '✕';
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-size: 18px;
        font-weight: bold;
    }
    
    /* Legend colors */
    .legend-box.available-regular {
        background-color: #6c757d;
    }
    
    .legend-box.available-vip {
        background-color: #ffc107;
    }
    
    .legend-box.selected {
        background-color: #28a745;
    }
    
    .legend-box.booked {
        background-color: #dc3545;
        opacity: 0.6;
    }
    
    .booking-summary {
        padding: 15px;
        background-color: #e9ecef;
        border-radius: 5px;
        font-size: 16px;
        font-weight: 500;
    }
    
    .booking-summary p {
        margin: 5px 0;
    }
    
    #submitBtn:disabled {
        opacity: 0.5;
        cursor: not-allowed;
    }
</style>