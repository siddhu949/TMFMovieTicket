package com.sat.tmf.movietkt.dao;

import java.time.LocalDateTime;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import com.sat.tmf.movietkt.entities.Booking;
import com.sat.tmf.movietkt.entities.Show;
import com.sat.tmf.movietkt.entities.User;

@Repository
public class BookingDao extends GenericDao<Booking, Integer> {

    public BookingDao() {
        super(Booking.class);
    }

    /**
     * Find bookings for a user.
     */
    public List<Booking> findByUser(User user) {
        Session session = getSession();
        Query<Booking> query = session.createQuery(
                "from Booking where user.id = :uid order by bookingTime desc", Booking.class);
        query.setParameter("uid", user.getId());
        return query.list();
    }

    /**
     * Find active bookings for a show (for seat blocking checks).
     */
    public List<Booking> findActiveByShow(Show show) {
        Session session = getSession();
        Query<Booking> query = session.createQuery(
                "from Booking where show.id = :sid and status in ('HOLD', 'CONFIRMED')", Booking.class);
        query.setParameter("sid", show.getId());
        return query.list();
    }

    /**
     * Expire old HOLD bookings.
     */
    public void expireHoldBookings() {
        Session session = getSession();
        session.createQuery("update Booking set status='EXPIRED' where status='HOLD' and holdExpiresAt < :now")
                .setParameter("now", LocalDateTime.now())
                .executeUpdate();
    }
    /**
     * Find booked seat IDs for a show (seats that are HOLD or CONFIRMED).
     */
    public List<Integer> findBookedSeatIdsByShowId(Integer showId) {
        Session session = getSession();
        Query<Integer> query = session.createQuery(
            "SELECT bs.templateSeat.id FROM BookingSeat bs " +
            "WHERE bs.booking.show.id = :showId " +
            "AND bs.booking.status IN ('HOLD', 'CONFIRMED')", 
            Integer.class);
        query.setParameter("showId", showId);
        return query.list();
    }
}

