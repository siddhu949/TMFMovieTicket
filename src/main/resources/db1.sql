use moviedb;
-- ================================================
-- MOVIE TICKET BOOKING SYSTEM - FULL DEMO DATA
-- ================================================

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE refunds;
TRUNCATE TABLE payments;
TRUNCATE TABLE booking_seats;
TRUNCATE TABLE bookings;
TRUNCATE TABLE movie_reviews;
TRUNCATE TABLE shows;
TRUNCATE TABLE template_seats;
TRUNCATE TABLE seat_templates;
TRUNCATE TABLE screens;
TRUNCATE TABLE theaters;
TRUNCATE TABLE movies;
TRUNCATE TABLE users;

SET FOREIGN_KEY_CHECKS = 1;

-- ================================================
-- 1. THEATERS
-- ================================================
INSERT INTO theaters (id, name, city, address) VALUES
(1, 'PVR Cinemas', 'Hyderabad', 'Hitech City, Madhapur'),
(2, 'INOX Megaplex', 'Bangalore', 'Whitefield Main Road');

-- ================================================
-- 2. SCREENS
-- ================================================
INSERT INTO screens (id, name, description, theater_id) VALUES
(1, 'Screen 1', 'Dolby Atmos Sound', 1),
(2, 'Screen 2', '4K Laser Projection', 1),
(3, 'Screen 1', 'Ultra HD Screen', 2),
(4, 'Screen 2', 'Dolby Surround 7.1', 2);

-- ================================================
-- 3. SEAT TEMPLATES
-- ================================================
CREATE TABLE seat_templates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    `rows`INT,
    cols INT,
    screen_id INT NOT NULL,
    CONSTRAINT fk_seat_template_screen
        FOREIGN KEY (screen_id)
        REFERENCES screens(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

 INSERT INTO seat_templates (`id`, `name`, `rows`, `cols`, `screen_id`) VALUES
 (1, 'Standard Layout', 5, 8, 1),
(2, 'Standard Layout', 5, 8, 2),
(3, 'Standard Layout', 5, 8, 3),
 (4, 'Standard Layout', 5, 8, 4);


-- ================================================
-- 4. TEMPLATE SEATS (160 seats)
-- ================================================
INSERT INTO template_seats (id, rowLabel, col, seatCode, seatType, price, seat_template_id) VALUES
(1,'A',1,'A1','REGULAR',150,1),(2,'A',2,'A2','REGULAR',150,1),(3,'A',3,'A3','REGULAR',150,1),(4,'A',4,'A4','REGULAR',150,1),
(5,'A',5,'A5','REGULAR',150,1),(6,'A',6,'A6','REGULAR',150,1),(7,'A',7,'A7','REGULAR',150,1),(8,'A',8,'A8','REGULAR',150,1),
(9,'B',1,'B1','REGULAR',150,1),(10,'B',2,'B2','REGULAR',150,1),(11,'B',3,'B3','REGULAR',150,1),(12,'B',4,'B4','REGULAR',150,1),
(13,'B',5,'B5','REGULAR',150,1),(14,'B',6,'B6','REGULAR',150,1),(15,'B',7,'B7','REGULAR',150,1),(16,'B',8,'B8','REGULAR',150,1),
(17,'C',1,'C1','REGULAR',150,1),(18,'C',2,'C2','REGULAR',150,1),(19,'C',3,'C3','REGULAR',150,1),(20,'C',4,'C4','REGULAR',150,1),
(21,'C',5,'C5','REGULAR',150,1),(22,'C',6,'C6','REGULAR',150,1),(23,'C',7,'C7','REGULAR',150,1),(24,'C',8,'C8','REGULAR',150,1),
(25,'D',1,'D1','REGULAR',150,1),(26,'D',2,'D2','REGULAR',150,1),(27,'D',3,'D3','REGULAR',150,1),(28,'D',4,'D4','REGULAR',150,1),
(29,'D',5,'D5','REGULAR',150,1),(30,'D',6,'D6','REGULAR',150,1),(31,'D',7,'D7','REGULAR',150,1),(32,'D',8,'D8','REGULAR',150,1),
(33,'E',1,'E1','REGULAR',150,1),(34,'E',2,'E2','REGULAR',150,1),(35,'E',3,'E3','REGULAR',150,1),(36,'E',4,'E4','REGULAR',150,1),
(37,'E',5,'E5','REGULAR',150,1),(38,'E',6,'E6','REGULAR',150,1),(39,'E',7,'E7','REGULAR',150,1),(40,'E',8,'E8','REGULAR',150,1),

(41,'A',1,'A1','REGULAR',150,2),(42,'A',2,'A2','REGULAR',150,2),(43,'A',3,'A3','REGULAR',150,2),(44,'A',4,'A4','REGULAR',150,2),
(45,'A',5,'A5','REGULAR',150,2),(46,'A',6,'A6','REGULAR',150,2),(47,'A',7,'A7','REGULAR',150,2),(48,'A',8,'A8','REGULAR',150,2),
(49,'B',1,'B1','REGULAR',150,2),(50,'B',2,'B2','REGULAR',150,2),(51,'B',3,'B3','REGULAR',150,2),(52,'B',4,'B4','REGULAR',150,2),
(53,'B',5,'B5','REGULAR',150,2),(54,'B',6,'B6','REGULAR',150,2),(55,'B',7,'B7','REGULAR',150,2),(56,'B',8,'B8','REGULAR',150,2),
(57,'C',1,'C1','REGULAR',150,2),(58,'C',2,'C2','REGULAR',150,2),(59,'C',3,'C3','REGULAR',150,2),(60,'C',4,'C4','REGULAR',150,2),
(61,'C',5,'C5','REGULAR',150,2),(62,'C',6,'C6','REGULAR',150,2),(63,'C',7,'C7','REGULAR',150,2),(64,'C',8,'C8','REGULAR',150,2),
(65,'D',1,'D1','REGULAR',150,2),(66,'D',2,'D2','REGULAR',150,2),(67,'D',3,'D3','REGULAR',150,2),(68,'D',4,'D4','REGULAR',150,2),
(69,'D',5,'D5','REGULAR',150,2),(70,'D',6,'D6','REGULAR',150,2),(71,'D',7,'D7','REGULAR',150,2),(72,'D',8,'D8','REGULAR',150,2),
(73,'E',1,'E1','REGULAR',150,2),(74,'E',2,'E2','REGULAR',150,2),(75,'E',3,'E3','REGULAR',150,2),(76,'E',4,'E4','REGULAR',150,2),
(77,'E',5,'E5','REGULAR',150,2),(78,'E',6,'E6','REGULAR',150,2),(79,'E',7,'E7','REGULAR',150,2),(80,'E',8,'E8','REGULAR',150,2),

(81,'A',1,'A1','REGULAR',150,3),(82,'A',2,'A2','REGULAR',150,3),(83,'A',3,'A3','REGULAR',150,3),(84,'A',4,'A4','REGULAR',150,3),
(85,'A',5,'A5','REGULAR',150,3),(86,'A',6,'A6','REGULAR',150,3),(87,'A',7,'A7','REGULAR',150,3),(88,'A',8,'A8','REGULAR',150,3),
(89,'B',1,'B1','REGULAR',150,3),(90,'B',2,'B2','REGULAR',150,3),(91,'B',3,'B3','REGULAR',150,3),(92,'B',4,'B4','REGULAR',150,3),
(93,'B',5,'B5','REGULAR',150,3),(94,'B',6,'B6','REGULAR',150,3),(95,'B',7,'B7','REGULAR',150,3),(96,'B',8,'B8','REGULAR',150,3),
(97,'C',1,'C1','REGULAR',150,3),(98,'C',2,'C2','REGULAR',150,3),(99,'C',3,'C3','REGULAR',150,3),(100,'C',4,'C4','REGULAR',150,3),
(101,'C',5,'C5','REGULAR',150,3),(102,'C',6,'C6','REGULAR',150,3),(103,'C',7,'C7','REGULAR',150,3),(104,'C',8,'C8','REGULAR',150,3),
(105,'D',1,'D1','REGULAR',150,3),(106,'D',2,'D2','REGULAR',150,3),(107,'D',3,'D3','REGULAR',150,3),(108,'D',4,'D4','REGULAR',150,3),
(109,'D',5,'D5','REGULAR',150,3),(110,'D',6,'D6','REGULAR',150,3),(111,'D',7,'D7','REGULAR',150,3),(112,'D',8,'D8','REGULAR',150,3),
(113,'E',1,'E1','REGULAR',150,3),(114,'E',2,'E2','REGULAR',150,3),(115,'E',3,'E3','REGULAR',150,3),(116,'E',4,'E4','REGULAR',150,3),
(117,'E',5,'E5','REGULAR',150,3),(118,'E',6,'E6','REGULAR',150,3),(119,'E',7,'E7','REGULAR',150,3),(120,'E',8,'E8','REGULAR',150,3),

(121,'A',1,'A1','REGULAR',150,4),(122,'A',2,'A2','REGULAR',150,4),(123,'A',3,'A3','REGULAR',150,4),(124,'A',4,'A4','REGULAR',150,4),
(125,'A',5,'A5','REGULAR',150,4),(126,'A',6,'A6','REGULAR',150,4),(127,'A',7,'A7','REGULAR',150,4),(128,'A',8,'A8','REGULAR',150,4),
(129,'B',1,'B1','REGULAR',150,4),(130,'B',2,'B2','REGULAR',150,4),(131,'B',3,'B3','REGULAR',150,4),(132,'B',4,'B4','REGULAR',150,4),
(133,'B',5,'B5','REGULAR',150,4),(134,'B',6,'B6','REGULAR',150,4),(135,'B',7,'B7','REGULAR',150,4),(136,'B',8,'B8','REGULAR',150,4),
(137,'C',1,'C1','REGULAR',150,4),(138,'C',2,'C2','REGULAR',150,4),(139,'C',3,'C3','REGULAR',150,4),(140,'C',4,'C4','REGULAR',150,4),
(141,'C',5,'C5','REGULAR',150,4),(142,'C',6,'C6','REGULAR',150,4),(143,'C',7,'C7','REGULAR',150,4),(144,'C',8,'C8','REGULAR',150,4),
(145,'D',1,'D1','REGULAR',150,4),(146,'D',2,'D2','REGULAR',150,4),(147,'D',3,'D3','REGULAR',150,4),(148,'D',4,'D4','REGULAR',150,4),
(149,'D',5,'D5','REGULAR',150,4),(150,'D',6,'D6','REGULAR',150,4),(151,'D',7,'D7','REGULAR',150,4),(152,'D',8,'D8','REGULAR',150,4),
(153,'E',1,'E1','REGULAR',150,4),(154,'E',2,'E2','REGULAR',150,4),(155,'E',3,'E3','REGULAR',150,4),(156,'E',4,'E4','REGULAR',150,4),
(157,'E',5,'E5','REGULAR',150,4),(158,'E',6,'E6','REGULAR',150,4),(159,'E',7,'E7','REGULAR',150,4),(160,'E',8,'E8','REGULAR',150,4);

-- ================================================
-- 5. MOVIES (10 Movies)
-- ================================================
INSERT INTO movies ( title, language, genre, duration, description, posterUrl) VALUES
('Dune: Part Two','English','Action, Sci-Fi',166,'The sequel to Dune where Paul Atreides unites with the Fremen to seek revenge and shape the fate of the universe.','https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=400&h=600&fit=crop'),
('The Batman Returns','English','Action, Crime',175,'Batman faces new threats in Gotham as corruption deepens and new villains rise.','https://images.unsplash.com/photo-1509347528160-9a9e33742cdb?w=400&h=600&fit=crop'),
('Interstellar Voyage','English','Adventure, Sci-Fi',169,'A team of explorers travels through a wormhole in space to ensure humanity’s survival.','https://images.unsplash.com/photo-1518676590629-3dcbd9c5a5c9?w=400&h=600&fit=crop'),
('The Last Kingdom','English','Drama, History',142,'A historical drama of war, loyalty, and leadership as kingdoms clash for power.','https://images.unsplash.com/photo-1485846234645-a62644f84728?w=400&h=600&fit=crop'),
('Avatar: Water Rise','English','Adventure, Fantasy',180,'Jake Sully and Neytiri protect their family as a new threat emerges from the oceans of Pandora.','https://images.unsplash.com/photo-1502134249126-9f3755a50d78?w=400&h=600&fit=crop'),
('Joker: Madness Within','English','Drama, Thriller',155,'A psychological deep dive into a man’s descent into madness and society’s role in shaping him.','https://images.unsplash.com/photo-1542204165-65bf26472b9b?w=400&h=600&fit=crop'),
('Fast Xtreme','English','Action, Thriller',148,'A high-octane story of underground racing, revenge, and global-level threats.','https://images.unsplash.com/photo-1502877338535-766e1452684a?w=400&h=600&fit=crop'),
('Guardians of Cosmos','English','Action, Fantasy',156,'A team of misfit heroes fights cosmic threats while protecting ancient secrets.','https://images.unsplash.com/photo-1517602302552-471fe67acf66?w=400&h=600&fit=crop'),
('Haunted Nights','English','Horror, Mystery',132,'A detective investigates a series of supernatural events connected to an abandoned mansion.','https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400&h=600&fit=crop'),
('Romance in Paris','English','Romance, Drama',130,'Two strangers meet in Paris and form a deep connection.','https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?w=400&h=600&fit=crop');

-- ================================================
-- 6. SHOWS (10 Shows)
-- ================================================
INSERT INTO shows (id, movie_id, screen_id, seat_template_id, showTime, totalSeats) VALUES
(1,1,1,1,'2025-11-15 10:00:00',40),
(2,1,2,2,'2025-11-15 18:00:00',40),
(3,2,1,1,'2025-11-16 11:00:00',40),
(4,2,2,2,'2025-11-16 20:00:00',40),
(5,3,1,1,'2025-11-17 09:30:00',40),
(6,3,2,2,'2025-11-17 19:00:00',40),
(7,4,1,1,'2025-11-18 12:00:00',40),
(8,4,2,2,'2025-11-18 21:00:00',40),
(9,5,1,1,'2025-11-19 10:30:00',40),
(10,5,2,2,'2025-11-19 19:30:00',40);

-- ================================================
-- 7. USERS (5 Users)
-- ================================================
INSERT INTO users (id, username, password, fullName, email, phone, role, createdAt) VALUES
(1,'john_doe','password123','John Doe','john@example.com','9876543210','USER',NOW()),
(2,'emma_watson','password123','Emma Watson','emma@example.com','9876543211','USER',NOW()),
(3,'michael_smith','password123','Michael Smith','mike@example.com','9876543212','USER',NOW()),
(4,'sophia_james','password123','Sophia James','sophia@example.com','9876543213','USER',NOW()),
(5,'admin_user','admin123','Admin Panel','admin@example.com','9876543214','ADMIN',NOW());

-- ================================================
-- 8. BOOKINGS (5 Bookings)
-- ================================================
INSERT INTO bookings (id, user_id, show_id, bookingTime, amount, status, holdExpiresAt) VALUES
(1,1,1,NOW(),300,'CONFIRMED',NULL),
(2,2,3,NOW(),150,'HOLD',DATE_ADD(NOW(), INTERVAL 10 MINUTE)),
(3,3,2,NOW(),450,'CONFIRMED',NULL),
(4,4,5,NOW(),150,'CANCELLED',NULL),
(5,5,4,NOW(),600,'CONFIRMED',NULL);

-- ================================================
-- 9. BOOKING SEATS (5 Random Seats)
-- ================================================
INSERT INTO booking_seats (id, booking_id, template_seat_id, seatCode, price) VALUES
(1,1,12,'B4',150),
(2,2,7,'A7',150),
(3,3,55,'C7',150),
(4,4,33,'D1',150),
(5,5,62,'D6',150);

-- ================================================
-- 10. PAYMENTS (3 Successful Payments)
-- ================================================
INSERT INTO payments (id, booking_id, user_id, amount, status, txnId, gateway, createdAt) VALUES
(1,1,1,300,'SUCCESS','TXN1001','RAZORPAY',NOW()),
(2,3,3,450,'SUCCESS','TXN1002','RAZORPAY',NOW()),
(3,5,5,600,'SUCCESS','TXN1003','STRIPE',NOW());

-- ================================================
-- 11. REFUNDS (1 Refund)
-- ================================================
INSERT INTO refunds (id, payment_id, booking_id, user_id, amount, status, refundTxnId, createdAt, processedAt) VALUES
(1,5265565,4,4,150,'SUCCESS','REF1001',NOW(),NOW());

-- ================================================
-- 12. MOVIE REVIEWS (5 Reviews)
-- ================================================
INSERT INTO movie_reviews (id, movie_id, user_id, rating, comment, createdAt) VALUES
(1,1,1,5,'Amazing visuals and storytelling!',NOW()),
(2,2,2,4,'Great action and cinematography.',NOW()),
(3,3,3,5,'Mind-blowing science and plot.',NOW()),
(4,4,4,3,'Good but a bit slow in the middle.',NOW()),
(5,5,5,4,'Beautiful world and great characters.',NOW());

-- ================================================
-- END OF FILE
-- ================================================

show tables;
select * from booking_seats;
select * from booking;
select * from screens;
select * from shows;
select * from theaters;
select * from template_seats;
select * from users;

INSERT INTO shows (id, movie_id, screen_id, seat_template_id, showTime, totalSeats) VALUES
(11, 1, 1, 1, '2025-11-17 14:00:00', 40),
(12, 2, 2, 2, '2025-11-17 16:30:00', 40),
(13, 3, 1, 1, '2025-11-17 18:00:00', 40),
(14, 4, 2, 2, '2025-11-17 20:30:00', 40);





