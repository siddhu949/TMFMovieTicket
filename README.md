# TMFMovieTicket
from docx import Document

# Create the README document
doc = Document()
doc.add_heading("🎬 Movie Ticket Booking System", level=1)

doc.add_heading("📖 Overview", level=2)
doc.add_paragraph(
    "The Movie Ticket Booking System is a web-based application developed using Spring Boot, Hibernate, "
    "and MVC architecture. It allows users to browse available movies, view show timings, select seats, "
    "and book tickets online. Admins can manage movies, theatres, schedules, and bookings through an "
    "intuitive dashboard."
)

doc.add_heading("⚙️ Tech Stack", level=2)
table = doc.add_table(rows=1, cols=2)
hdr_cells = table.rows[0].cells
hdr_cells[0].text = "Layer"
hdr_cells[1].text = "Technology"
data = [
    ("Frontend", "HTML, CSS, Bootstrap, JSP"),
    ("Backend", "Java, Spring Boot, Spring MVC"),
    ("ORM", "Hibernate"),
    ("Database", "MySQL"),
    ("Server", "Apache Tomcat"),
    ("IDE", "Eclipse / IntelliJ IDEA"),
    ("Build Tool", "Maven"),
]
for layer, tech in data:
    row_cells = table.add_row().cells
    row_cells[0].text = layer
    row_cells[1].text = tech

doc.add_heading("🧩 Modules", level=2)
doc.add_heading("👤 User Module", level=3)
doc.add_paragraph(
    "- Register and log in securely\n"
    "- Browse movies, view show details\n"
    "- Select showtime, seats, and make a booking\n"
    "- View booking history and cancel tickets"
)
doc.add_heading("🎞️ Movie Management Module (Admin)", level=3)
doc.add_paragraph(
    "- Add, update, and delete movies\n"
    "- Manage theatres and show timings\n"
    "- View all user bookings"
)
doc.add_heading("💺 Booking Module", level=3)
doc.add_paragraph(
    "- Real-time seat selection\n"
    "- Automatic ticket generation\n"
    "- Payment gateway integration (optional)"
)

doc.add_heading("📊 ER Diagram", level=2)
doc.add_paragraph(
    "The Entity Relationship Model (ER Model) represents key entities:\n\n"
    "- User (user_id, name, email, password, role)\n"
    "- Movie (movie_id, title, genre, duration, language)\n"
    "- Theatre (theatre_id, name, location)\n"
    "- Show (show_id, movie_id, theatre_id, date, time, price)\n"
    "- Booking (booking_id, user_id, show_id, seats, total_amount)\n\n"
    "(Refer to the project document for the complete ER diagram.)"
)

doc.add_heading("🧠 UML Diagrams", level=2)
doc.add_paragraph(
    "- Use Case Diagram: Describes interactions between Admin, User, and the System.\n"
    "- Class Diagram: Represents entities such as User, Movie, Theatre, Show, and Booking with relationships.\n"
    "- Sequence Diagram: Illustrates the flow from movie selection to ticket confirmation."
)

doc.add_heading("📂 Project Structure", level=2)
doc.add_paragraph(
    "movie-ticket-booking/\n"
    "│\n"
    "├── src/main/java/com/moviebooking/\n"
    "│   ├── controller/\n"
    "│   │   ├── UserController.java\n"
    "│   │   ├── AdminController.java\n"
    "│   │   └── BookingController.java\n"
    "│   │\n"
    "│   ├── model/\n"
    "│   │   ├── User.java\n"
    "│   │   ├── Movie.java\n"
    "│   │   ├── Theatre.java\n"
    "│   │   ├── Show.java\n"
    "│   │   └── Booking.java\n"
    "│   │\n"
    "│   ├── service/\n"
    "│   │   ├── UserService.java\n"
    "│   │   ├── MovieService.java\n"
    "│   │   └── BookingService.java\n"
    "│   │\n"
    "│   ├── repository/\n"
    "│   │   ├── UserRepository.java\n"
    "│   │   ├── MovieRepository.java\n"
    "│   │   └── BookingRepository.java\n"
    "│   │\n"
    "│   └── MovieTicketBookingApplication.java\n"
    "│\n"
    "├── src/main/resources/\n"
    "│   ├── application.properties\n"
    "│   └── templates/\n"
    "│       ├── index.jsp\n"
    "│       ├── login.jsp\n"
    "│       ├── booking.jsp\n"
    "│       ├── admin_dashboard.jsp\n"
    "│\n"
    "└── pom.xml"
)

doc.add_heading("⚙️ Configuration", level=2)
doc.add_paragraph(
    "application.properties:\n"
    "spring.datasource.url=jdbc:mysql://localhost:3306/movie_db\n"
    "spring.datasource.username=root\n"
    "spring.datasource.password=yourpassword\n"
    "spring.jpa.hibernate.ddl-auto=update\n"
    "spring.jpa.show-sql=true\n"
    "server.port=8080"
)

doc.add_heading("🚀 How to Run", level=2)
doc.add_paragraph(
    "1. Clone the repository\n"
    "   git clone https://github.com/yourusername/movie-ticket-booking.git\n"
    "2. Import into your IDE (Eclipse/IntelliJ)\n"
    "3. Configure MySQL credentials in application.properties\n"
    "4. Run MovieTicketBookingApplication.java as a Spring Boot App\n"
    "5. Open browser → http://localhost:8080/"
)

doc.add_heading("🧾 Functional Requirements", level=2)
table2 = doc.add_table(rows=1, cols=2)
hdr2 = table2.rows[0].cells
hdr2[0].text = "User Role"
hdr2[1].text = "Functionality"
data2 = [
    ("User", "Register, login, search movies, book/cancel tickets"),
    ("Admin", "Manage movies, theatres, shows, and view bookings"),
]
for role, func in data2:
    row = table2.add_row().cells
    row[0].text = role
    row[1].text = func

doc.add_heading("🧰 Future Enhancements", level=2)
doc.add_paragraph(
    "- Online payment integration (Razorpay/Stripe)\n"
    "- Email/SMS booking confirmation\n"
    "- Recommendation system for movies\n"
    "- Enhanced analytics dashboard for admin"
)

doc.add_heading("👨‍💻 Author", level=2)
doc.add_paragraph("K. Aditya Satya Prakash\n Full Stack Developer (Spring Boot & ReactJS Enthusiast)")

# Save the document
output_path = "/mnt/data/Movie_Ticket_Booking_README.docx"
doc.save(output_path)

output_path
