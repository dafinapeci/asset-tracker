# IT Asset Tracker - Full Stack MVP

A full-stack IT Asset Management solution built to allow employees to request hardware and administrators to manage inventory lifecycle.

## 🚀 Tech Stack
* **Backend:** Java 17, Spring Boot, Spring Data JPA, Hibernate
* **Database:** PostgreSQL
* **Frontend:** Flutter (Dart) - https://github.com/dafinapeci/asset-tracker/tree/master/asset_tracker_app
* **Tools:** Postman, pgAdmin

## ✨ Key Features
* **Inventory View:** Real-time visibility of all `AVAILABLE` IT assets.
* **Checkout Lifecycle:** Users can request to borrow an asset, putting it in a `PENDING` state.
* **Admin Dashboard:** IT Administrators can view pending requests and securely `APPROVE` or `REJECT` them.
* **State Management:** Automatic status resolution handling (e.g., locking an asset to `CHECKED_OUT` upon approval).
* **User History:** Personalized "My Items" dashboard for employees to track their request statuses.

## 🗄️ Database Schema
The relational database is structured with three core entities:
1. `users` - Employees and Administrators.
2. `assets` - Physical hardware (Laptops, Phones) with unique tag numbers.
3. `checkout_logs` - Transactional audit table linking Users to Assets with timestamps and approval statuses.

## 🛠️ Local Setup Instructions

### Prerequisites
* Java 17+
* PostgreSQL running on port 5432
* Flutter SDK (for mobile app)

### Backend (Spring Boot)
1. Clone this repository.
2. Update the `src/main/resources/application.properties` with your local PostgreSQL credentials:
   ```properties
   spring.datasource.url=jdbc:postgresql://localhost:5432/asset_tracker
   spring.datasource.username=YOUR_USERNAME
   spring.datasource.password=YOUR_PASSWORD