# Manufacturing Solution

A comprehensive **Manufacturing Management System** built with **Flutter** (frontend), **Node.js + Express** (backend), and **PostgreSQL** (database). This solution helps manufacturing businesses manage **Bill of Materials (BOM), Work Orders, Products, and Inventory**, all in a modern, cross-platform interface.

## Demo Video
Watch the demo video [here](https://drive.google.com/drive/folders/16m6N3rmCC1oXJp0uUImV088HuESv3G5r?usp=sharing).

---

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Setup Instructions](#setup-instructions)
  - [Backend](#backend)
  - [Frontend](#frontend)
- [API Endpoints](#api-endpoints)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

---

## Features

## Demo Video
Watch the demo video [here](https://drive.google.com/drive/folders/16m6N3rmCC1oXJp0uUImV088HuESv3G5r?usp=sharing).

- **Products Management**: Add, edit, delete, and view products.
- **Bill of Materials (BOM)**: Link raw materials to finished products with quantities and units.
- **Work Orders**: Create and manage work orders for production tasks.
- **Search & Filter**: Quickly search products, BOMs, or work orders.
- **Responsive Flutter UI**: Supports desktop, mobile, and tablet.
- **CRUD Operations**: Full Create, Read, Update, Delete functionality.
- **API-driven**: Backend APIs using Node.js and Express.
- **PostgreSQL Database**: Reliable relational database for production data.

---

## Tech Stack

| Layer        | Technology |
| ------------ | ---------- |
| Frontend     | Flutter, Dart |
| Backend      | Node.js, Express.js |
| Database     | PostgreSQL |
| HTTP Client  | `http` (Flutter) |
| State Mgmt   | setState / FutureBuilder (Flutter) |

---

## Architecture

```
Flutter App (UI/UX)
      │
      ▼
 HTTP Requests (APIService)
      │
      ▼
Node.js + Express Backend
      │
      ▼
PostgreSQL Database
```

- Flutter consumes APIs from Express.
- Express handles routing, database queries, and business logic.
- PostgreSQL stores all production data including products, BOMs, and work orders.

---

## Setup Instructions

### Backend

1. Clone the repo:

```bash
git clone https://github.com/yourusername/manufacturing-solution.git
cd manufacturing-solution/backend
```

2. Install dependencies:

```bash
npm install
```

3. Create a `.env` file:

```env
PORT=5000
DB_HOST=localhost
DB_PORT=5432
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_NAME=manufacturing_db
```

4. Run migrations / create tables:

```sql
-- Products table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    sku VARCHAR(100),
    product_type VARCHAR(100),
    unit VARCHAR(50)
);

-- BOM table
CREATE TABLE bill_of_materials (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    raw_material_id INT,
    quantity_required NUMERIC(10,2),
    unit VARCHAR(50)
);

-- Work Orders table
CREATE TABLE work_orders (
    id SERIAL PRIMARY KEY,
    manufacturing_order_id INT,
    task_name VARCHAR(255),
    assigned_to INT,
    status VARCHAR(50)
);
```

5. Start the backend server:

```bash
npx nodemon backend/src/server.js
```

---

### Frontend (Flutter)

1. Navigate to frontend:

```bash
cd ../frontend
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the Flutter app:

```bash
flutter run -d windows   # or -d chrome / -d android / -d ios
```

---

## API Endpoints

| Method | Endpoint                     | Description                     |
| ------ | ---------------------------- | ------------------------------- |
| GET    | `/products`                  | Get all products                |
| POST   | `/products`                  | Add a new product               |
| GET    | `/bom`                       | Get all BOMs                    |
| POST   | `/bom`                       | Add a new BOM                   |
| GET    | `/work_orders`               | Get all work orders             |
| POST   | `/work_orders`               | Create a new work order         |

> All endpoints return JSON responses.

---

## Screenshots

![Products Page](screenshots/products.png)  
![BOM Page](screenshots/bom.png)  
![Work Orders](screenshots/work_orders.png)

---

## Contributing

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Commit changes: `git commit -m "Add my feature"`
4. Push to the branch: `git push origin feature/my-feature`
5. Open a Pull Request.

---

## License

This project is licensed under the MIT License. See `LICENSE` for details.

---

Made with ❤️ by **TechMADS**