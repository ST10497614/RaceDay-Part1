# RaceDay Database System

##  Project Overview

The **RaceDay Database System** is a structured SQL Server database designed to manage running events, participants, categories, enrolments, and results. The system supports organisers in creating events and allows participants to enrol in race categories while tracking performance outcomes.

This project is based on a formal **Entity Relationship Diagram (ERD)** and aligned with a RESTful API design.

---

##  Objectives

* Design a normalized relational database
* Implement entity relationships using SQL Server
* Support event management and participant enrolment
* Ensure data integrity using constraints and keys
* Align database structure with API endpoints

---

##  Database Structure

### Core Entities

* **Organiser** – Manages events and system operations
* **Event** – Represents a race event
* **Participant** – Users who take part in events
* **Category** – Defines race distances and limits
* **RouteInformation** – Stores route details for events

### Relationship Tables

* **EventParticipant** – Many-to-many relationship between participants and events
* **Enrolment** – Links participants to categories
* **Result** – Stores race results per enrolment

---

## Entity Relationships

* One **Organiser** can create many **Events**
* One **Event** can have many **Categories**
* A **Participant** can join multiple **Events**
* A **Participant** enrols in a **Category**
* Each **Enrolment** can have one **Result**

---

##  Technologies Used

* **SQL Server**
* **T-SQL (Transact-SQL)**
* **Relational Database Design**
* **Git & GitHub**

---

##  Database Features

### Data Integrity

* Primary Keys & Foreign Keys
* Unique constraints (e.g., email)
* Default values (e.g., enrolment date)

###  Performance

* Indexed columns for faster queries
* Optimized relationships

### Validation

* CHECK constraints (e.g., valid status values)
* Controlled relationships via FK constraints

---

## API Alignment

The database is designed to support RESTful API endpoints such as:

* User authentication (register/login)
* Event creation and management
* Category assignment
* Event enrolment
* Result submission and retrieval

Example from API design:

---

## ERD Reference

The system structure is based on the ERD, including entities such as Organiser, Event, Category, and Enrolment.

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/raceday-db.git
cd raceday-db
```

### 2. Run the SQL Script

* Open **SQL Server Management Studio (SSMS)**
* Execute the provided `.sql` file

### 3. Verify Tables

```sql
SELECT * FROM Organiser;
SELECT * FROM Event;
SELECT * FROM Category;
SELECT * FROM Participant;
SELECT * FROM Enrolment;
```

---

## Sample Data

The database includes:

* 2 organisers
* 2 participants
* 3 events
* 6 categories
* Sample enrolments and results

This allows immediate testing and validation.

---

##  Version Control (GitHub Commits)

The project follows **Conventional Commits** for clear history:

* `feat(database): create schema`
* `feat(database): add enrolment system`
* `refactor(database): remove redundancy`
* `feat(database): add constraints and indexes`

---

##  Academic Justification

This database demonstrates:

* **3rd Normal Form (3NF)** compliance
* Proper use of **junction tables for M:N relationships**
* Strong **data integrity enforcement**
* Alignment between **ERD → Database → API**

---

##  Future Improvements

* Add stored procedures for enrolment and results
* Implement triggers for automatic updates
* Integrate with a full backend application (C# / ASP.NET)
* Add reporting queries (leaderboards, stats)

---

## 👨‍💻 Author

**Thandululo Ratshivhanda**

---

## 📄 License

This project is for academic purposes.
