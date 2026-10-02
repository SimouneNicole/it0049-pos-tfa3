# IT0049 — POS: Forms, Validation, File Upload, and CRUD (TFA3)

A Point of Sale (POS) application built on CodeIgniter 4. This repository builds upon the database-driven architecture established in TFA2 by adding validated create and edit workflows for customer and user records, along with user avatar uploading and image preparation.

## Features & Improvements in TFA3

- **Customer Create and Edit Forms**: Added forms for creating new customer records and updating existing customer information.
- **User Create and Edit Forms**: Added forms for creating new user accounts and updating existing user information.
- **Server-Side Validation**: Validates required fields, valid email addresses, unique usernames, field lengths, and uploaded files before saving data.
- **Old Input Retention**: Rejected form submissions retain previously entered values using CodeIgniter's `old()` helper.
- **Field-Level Error Messages**: Validation feedback is displayed beside the relevant form fields.
- **User Avatar Upload**: Supports optional JPG and PNG avatar uploads with a maximum file size of 2 MB.
- **Image Preparation**: Uploaded avatars are assigned random filenames and prepared as 300 × 300 pixel images.
- **Avatar Fallback**: Users without an uploaded avatar are shown a default placeholder image.
- **CodeIgniter CRUD Workflow**: Uses Model methods such as `insert()`, `findAll()`, `find()`, and `update()` instead of raw SQL queries inside controllers.
- **CSRF Protection**: Forms include CodeIgniter's CSRF field for safer form submission.
- **Database Export Included**: The complete fresh database schema and fictional sample data are provided in `db_export/database.sql`.
- **Preserved Design Language**: The liquid-glass responsive layout, floating capsule navigation, tables, and existing TFA2 visual style remain consistent.

---

## System Requirements

- **PHP**: 8.2 or higher (`intl`, `mbstring`, `json`, `mysqli`, and `gd` extensions enabled)
- **Composer**: 2.0 or higher
- **Database**: MySQL 5.7+ or MariaDB 10.3+ (for example, through XAMPP)
- **Web Server**: CodeIgniter's built-in development server (`spark serve`) or Apache

---

## Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/SimouneNicole/it0049-pos-tfa2.git
cd it0049-pos-tfa2
```

### 2. Install Dependencies

```bash
composer install
```

### 3. Database Setup (MySQL / XAMPP)

1. Start **Apache** and **MySQL** in the XAMPP Control Panel.
2. Open **phpMyAdmin** at `http://localhost/phpmyadmin`.
3. Select **Import** and choose [`db_export/database.sql`](db_export/database.sql).
4. Click **Import** or **Go**.

The SQL export automatically creates the `it0049_pos` database, the `customers` and `users` tables, the user avatar column, and the fictional sample records.

Alternatively, import the database through the MySQL terminal:

```bash
mysql -u root -p < db_export/database.sql
```

> For a fresh setup, import only `db_export/database.sql`. The optional `db_export/tfa3_upgrade.sql` file is intended only for an existing TFA2 database whose records must be preserved.

### 4. Configure the Environment

Copy the `env` template file and rename the copy to `.env`:

```bash
cp env .env
```

Windows users may also copy and rename the file manually in File Explorer. Ensure that the new filename is `.env`, not `.env.txt`.

Confirm that the database settings in `.env` match the local MySQL configuration:

```ini
CI_ENVIRONMENT = development
app.baseURL = 'http://localhost:8080/'

database.default.hostname = localhost
database.default.database = it0049_pos
database.default.username = root
database.default.password = ''
database.default.DBDriver = MySQLi
database.default.port = 3306
```

### 5. Enable the GD Extension

The PHP GD extension is required to prepare uploaded avatar images.

1. In XAMPP, open Apache's `php.ini` file.
2. Find `;extension=gd`.
3. Remove the semicolon so the setting becomes `extension=gd`.
4. Save the file and restart Apache.

Verify that GD is enabled:

```bash
php -m
```

### 6. Start the Application

Run the CodeIgniter development server from the folder containing the `spark` file:

```bash
php spark serve --port 8080
```

Open `http://localhost:8080/` in a browser.

---

## Database Schema

### `customers` Table

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | `INT` | `AUTO_INCREMENT`, `PRIMARY KEY` | Unique customer identifier |
| `full_name` | `VARCHAR(100)` | `NOT NULL` | Customer's full name |
| `email` | `VARCHAR(100)` | `NOT NULL` | Customer's email address |
| `phone` | `VARCHAR(20)` | `NULL` | Customer's contact number |
| `created_at` | `DATETIME` | `NOT NULL` | Timestamp of record creation |

### `users` Table

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | `INT` | `AUTO_INCREMENT`, `PRIMARY KEY` | Unique user identifier |
| `username` | `VARCHAR(50)` | `NOT NULL`, `UNIQUE` | Unique user login name |
| `full_name` | `VARCHAR(100)` | `NOT NULL` | Staff member's full name |
| `avatar` | `VARCHAR(255)` | `NULL` | Randomized avatar filename only |
| `created_at` | `DATETIME` | `NOT NULL` | Timestamp of record creation |

---

## Validation Rules

### Customer Records

- `full_name`: required, minimum of 3 characters, maximum of 100 characters
- `email`: required, valid email format, maximum of 100 characters
- `phone`: optional, maximum of 20 characters

### User Records

- `username`: required, minimum of 3 characters, maximum of 50 characters, and unique
- `full_name`: required, minimum of 3 characters, maximum of 100 characters

### Avatar Upload

- Optional upload
- JPG or PNG images only
- Maximum file size of 2 MB
- Random server-side filename
- Prepared as a 300 × 300 pixel image
- Stored in `public/uploads/`
- Only the generated filename is stored in the database

---

## Application Routes

| Method | Route | Controller Handler | Purpose |
|---|---|---|---|
| `GET` | `/` | `Pages::home` | Display the home page |
| `GET` | `/about` | `Pages::about` | Display the project information page |
| `GET` | `/customers` | `Customers::index` | Display all customer records |
| `GET` | `/customers/new` | `Customers::new` | Display the Add Customer form |
| `POST` | `/customers` | `Customers::create` | Validate and insert a customer |
| `GET` | `/customers/{id}/edit` | `Customers::edit` | Display a pre-filled Edit Customer form |
| `POST` | `/customers/{id}` | `Customers::update` | Validate and update a customer |
| `GET` | `/users` | `Users::index` | Display all user accounts and avatars |
| `GET` | `/users/new` | `Users::new` | Display the Add User form |
| `POST` | `/users` | `Users::create` | Validate and insert a user |
| `GET` | `/users/{id}/edit` | `Users::edit` | Display the Edit User and avatar form |
| `POST` | `/users/{id}` | `Users::update` | Validate and update a user and avatar |

---

## Project Structure

```text
it0049-pos-tfa3/
├── app/
│   ├── Config/
│   │   ├── Database.php       # Database connection groups
│   │   ├── Filters.php        # CSRF filter configuration
│   │   └── Routes.php         # Customer and user GET/POST routes
│   ├── Controllers/
│   │   ├── BaseController.php # Core controller and shared helpers
│   │   ├── Customers.php      # Customer create and edit workflow
│   │   ├── Pages.php          # Home and About page controller
│   │   └── Users.php          # User CRUD and avatar upload workflow
│   ├── Database/
│   │   └── Migrations/
│   │       └── 2026-10-02-000001_AddAvatarToUsers.php
│   ├── Models/
│   │   ├── CustomerModel.php  # Model for the customers table
│   │   └── UserModel.php      # Model for the users table and avatar field
│   └── Views/
│       ├── layouts/
│       │   └── main.php       # Shared layout, navigation, and messages
│       ├── pages/
│       │   ├── home.php       # Landing overview view
│       │   └── about.php      # Platform information view
│       ├── customers/
│       │   ├── index.php      # Customer records table
│       │   ├── new.php        # Add Customer form
│       │   └── edit.php       # Edit Customer form
│       └── users/
│           ├── index.php      # User accounts and avatar listing
│           ├── new.php        # Add User form
│           └── edit.php       # Edit User and avatar form
├── db_export/
│   ├── database.sql           # Complete fresh schema and sample data
│   └── tfa3_upgrade.sql       # Optional upgrade for an existing TFA2 database
├── public/
│   ├── css/
│   │   └── style.css          # Liquid-glass responsive stylesheet
│   ├── images/
│   │   └── avatar-placeholder.svg
│   ├── uploads/
│   │   └── .gitkeep           # Keeps the empty upload folder in Git
│   └── index.php              # Application front controller
├── writable/                  # CodeIgniter cache, log, and session directories
├── .env                       # Local configuration (ignored by Git)
├── .gitignore                 # Excludes secrets and generated files
├── env                        # Safe environment configuration template
├── composer.json              # Project dependencies and autoload settings
├── README.md                  # Project documentation
└── spark                      # CodeIgniter command-line entry point
```

---

## Testing & Verification

List all registered application routes:

```bash
php spark routes
```

Run the available test suite:

```bash
vendor/bin/phpunit --no-coverage
```

Perform the following browser checks:

1. Submit `/customers/new` with empty fields and confirm that validation messages appear.
2. Enter a valid customer and confirm that the new record appears on `/customers`.
3. Open a customer's Edit page, change its information, and confirm the update.
4. Submit `/users/new` with an existing username and confirm that the unique-username error appears.
5. Add a valid user and confirm that the account appears on `/users`.
6. Open a user's Edit page and upload a valid JPG or PNG avatar below 2 MB.
7. Confirm that the prepared avatar appears on `/users`.
8. Upload an invalid file type or a file larger than 2 MB and confirm that it is rejected.
9. Confirm that users without uploaded avatars display the placeholder image.

---

## Security and Repository Notes

- Do not upload the local `.env` file because it may contain database credentials.
- Do not upload the `vendor/` folder; restore dependencies using `composer install`.
- Uploaded user avatars and runtime files should not contain confidential information.
- Keep the provided `.gitignore` file in the repository.

---

## License

This project is open-source software licensed under the [MIT License](LICENSE).
