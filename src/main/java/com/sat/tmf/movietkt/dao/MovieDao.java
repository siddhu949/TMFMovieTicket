package com.sat.tmf.movietkt.dao;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import com.sat.tmf.movietkt.entities.Movie;

@Repository
public class MovieDao extends GenericDao<Movie, Integer> {

    public MovieDao() {
        super(Movie.class);
    }

    /**
     * Search movies by title or genre.
     */
    public List<Movie> searchMovies(String keyword) {
        Session session = getSession();
        Query<Movie> query = session.createQuery(
            "from Movie where lower(title) like :kw or lower(genre) like :kw order by title", Movie.class);
        query.setParameter("kw", "%" + keyword.toLowerCase() + "%");
        return query.list();
    }

    /**
     * Find all distinct languages available.
     */
    public List<String> findAllLanguages() {
        return getSession().createQuery(
                "select distinct language from Movie where language is not null", String.class)
                .list();
    }
    public List<Movie> findMoviesByCityDateLanguage(String city, LocalDate date, String language) {
        Session session = getSession();

        // Query movies via Show join to avoid "m.shows" problem
        String hql = "select distinct s.movie from Show s " +
                     "join s.screen sc " +
                     "join sc.theater t " +
                     "where t.city = :city " +
                     "and s.showTime >= :startOfDay " +
                     "and s.showTime < :endOfDay";

        if (language != null && !language.isEmpty()) {
            hql += " and s.movie.language = :language";
        }

        Query<Movie> query = session.createQuery(hql, Movie.class);

        query.setParameter("city", city);

        // Filter shows within the selected date
        LocalDateTime startOfDay = date.atStartOfDay();
        LocalDateTime endOfDay = date.plusDays(1).atStartOfDay();

        query.setParameter("startOfDay", startOfDay);
        query.setParameter("endOfDay", endOfDay);

        if (language != null && !language.isEmpty()) {
            query.setParameter("language", language);
        }

        return query.list();
    }


}

