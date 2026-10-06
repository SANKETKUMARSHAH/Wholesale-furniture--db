Wholesale Furniture Sales Management System 

A comprehensive Database Management System (DBMS) designed to manage, analyze, and streamline sales operations, customer relationships, and inventory categorization for a wholesale furniture business.

Project Overview
The Wholesale Furniture Sales Management System is built using MySQL. It models complex analytical dimensions including geographical regions, furniture attributes, time dimensions, and transactional sales metrics.

 Key Features
- Geographical Breakdown: Tracks performance across States, Regions, and Cities (e.g., Madhya Pradesh, Malwa, Indore).
- Product Classification: Categorizes products by Furniture Type, Category, and Material (e.g., Wood, Marble, Metal).
- Time Dimension Analytics: Analyzes sales trends on a daily, monthly, quarterly, and yearly basis.
- Analytical Reporting: Calculates gross sales, total discounts, and net sales income.
- Centralized View: Includes a pre-configured Database View (`SalesAnalysisView`) for reporting.


 Entity-Relationship (ER) Diagram
The entity-relationship model depicts key business entities and their relationships:

- State `(1)` ── Has ── `(N)` Region
- Region `(1)` ── Has ── `(N)` City
- City `(1)` ── Located_in ── `(N)` Customer
- Customer `(1)` ── Makes ── `(N)` Sales
- FurnitureType `(1)` ── Belongs_to ── `(N)` Furniture
- Furniture `(1)` ── Contains ── `(N)` Sales
- Time `(1)` ── Occurs_on ── `(N)` Sales



 Database Schema & Relational Model

 Tables Structure
1. States: `state_id (PK)`, `state_name`
2. Regions: `region_id (PK)`, `region_name`, `state_id (FK)`
3. Cities: `city_id (PK)`, `city_name`, `region_id (FK)`
4. Customers: `customer_id (PK)`, `customer_name`, `phone`, `address`, `city_id (FK)`
5. FurnitureTypes: `type_id (PK)`, `type_name`
6. Categories: `category_id (PK)`, `category_name`
7. Materials: `material_id (PK)`, `material_name`
8. Furniture: `furniture_id (PK)`, `furniture_name`, `type_id (FK)`, `category_id (FK)`, `material_id (FK)`
9. TimeDimension: `date_id (PK)`, `full_date`, `day`, `month`, `quarter`, `year`
10. Sales: `sale_id (PK)`, `customer_id (FK)`, `furniture_id (FK)`, `date_id (FK)`, `quantity`, `unit_price`, `discount_amount`

 Getting Started

 Prerequisites
- MySQL Server (v8.0 or higher)
- MySQL Workbench or any SQL client interface

Installation & Setup
1. Clone or download the project files to your local system.
2. Open MySQL Workbench and connect to your database instance.
3. Run the complete SQL script:
   
