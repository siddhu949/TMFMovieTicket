# 🎬 Movie Ticket Booking System

## 📖 Overview
The **Movie Ticket Booking System** is a web-based application developed using **Spring Boot**, **Hibernate**, and **MVC architecture**.  
It enables users to browse movies, view show timings, select seats, and book tickets online.  
Admins can manage movies, theatres, schedules, and bookings through an intuitive dashboard.

---

## ⚙️ Tech Stack

| Layer | Technology |
|-------|-------------|
| Frontend | HTML, CSS, Bootstrap, JSP |
| Backend | Java, Spring Boot, Spring MVC |
| ORM | Hibernate |
| Database | MySQL |
| Server | Apache Tomcat |
| IDE | Eclipse / IntelliJ IDEA |
| Build Tool | Maven |

---

## 🧩 Modules

### 👤 User Module
- Register and log in securely  
- Browse movies and show details  
- Select showtime, seats, and make a booking  
- View booking history and cancel tickets  

### 🎞️ Movie Management Module (Admin)
- Add, update, and delete movies  
- Manage theatres and show timings  
- View all user bookings  

### 💺 Booking Module
- Real-time seat selection  
- Automatic ticket generation  
- Payment gateway integration *(optional)*  

---

## 📊 ER Diagram
The **Entity Relationship Model (ER Model)** represents key entities:

- **User** (`user_id`, `name`, `email`, `password`, `role`)  
- **Movie** (`movie_id`, `title`, `genre`, `duration`, `language`)  
- **Theatre** (`theatre_id`, `name`, `location`)  
- **Show** (`show_id`, `movie_id`, `theatre_id`, `date`, `time`, `price`)  
- **Booking** (`booking_id`, `user_id`, `show_id`, `seats`, `total_amount`)  

📘 *Refer to the documentation for the complete ER model.*

---

## 🧠 UML Diagrams
- **Use Case Diagram** – Interaction between Admin, User, and System  
- **Class Diagram** – Shows classes like User, Movie, Theatre, Show, Booking  
- **Sequence Diagram** – Flow from movie selection → booking → confirmation  

---

## 📂 Project Structure
```movie-ticket-booking/
│
├── src/main/java/com/moviebooking/
│   ├── controller/
│   │   ├── UserController.java
│   │   ├── AdminController.java
│   │   └── BookingController.java
│   │
│   ├── model/
│   │   ├── User.java
│   │   ├── Movie.java
│   │   ├── Theatre.java
│   │   ├── Show.java
│   │   └── Booking.java
│   │
│   ├── service/
│   │   ├── UserService.java
│   │   ├── MovieService.java
│   │   └── BookingService.java
│   │
│   ├── repository/
│   │   ├── UserRepository.java
│   │   ├── MovieRepository.java
│   │   └── BookingRepository.java
│   │
│   └── MovieTicketBookingApplication.java
│
├── src/main/resources/
│   ├── application.properties
│   └── templates/
│       ├── index.jsp
│       ├── login.jsp
│       ├── booking.jsp
│       ├── admin_dashboard.jsp
│
└── pom.xml```


---

## ⚙️ Configuration

### `application.properties`
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/movie_db
spring.datasource.username=root
spring.datasource.password=yourpassword
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
server.port=8080
