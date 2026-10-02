-- =========================================
-- WHOLESALE FURNITURE SALES ANALYSIS SYSTEM
-- =========================================

CREATE DATABASE IF NOT EXISTS WholesaleFurnitureDB;
USE WholesaleFurnitureDB;

-- 1. STATES
CREATE TABLE States (
    state_id INT AUTO_INCREMENT PRIMARY KEY,
    state_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. REGIONS
CREATE TABLE Regions (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL,
    state_id INT NOT NULL,
    FOREIGN KEY (state_id) REFERENCES States(state_id),
    UNIQUE (region_name, state_id)
);

-- 3. CITIES
CREATE TABLE Cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    region_id INT NOT NULL,
    FOREIGN KEY (region_id) REFERENCES Regions(region_id),
    UNIQUE (city_name, region_id)
);

-- 4. CUSTOMERS
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200),
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);

-- 5. FURNITURE TYPES
CREATE TABLE FurnitureTypes (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

-- 6. CATEGORIES
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

-- 7. MATERIALS
CREATE TABLE Materials (
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(50) NOT NULL UNIQUE
);

-- 8. FURNITURE
CREATE TABLE Furniture (
    furniture_id INT AUTO_INCREMENT PRIMARY KEY,
    furniture_name VARCHAR(100) NOT NULL,
    type_id INT NOT NULL,
    category_id INT NOT NULL,
    material_id INT NOT NULL,

    FOREIGN KEY (type_id) REFERENCES FurnitureTypes(type_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (material_id) REFERENCES Materials(material_id)
);

-- 9. TIME DIMENSION
CREATE TABLE TimeDimension (
    date_id INT AUTO_INCREMENT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day INT NOT NULL,
    month INT NOT NULL,
    quarter INT NOT NULL,
    year INT NOT NULL,

    CHECK (day BETWEEN 1 AND 31),
    CHECK (month BETWEEN 1 AND 12),
    CHECK (quarter BETWEEN 1 AND 4),
    CHECK (year BETWEEN 1900 AND 9999)
);

-- 10. SALES
CREATE TABLE Sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    furniture_id INT NOT NULL,
    date_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    discount_amount DECIMAL(12,2) NOT NULL DEFAULT 0,

    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (furniture_id) REFERENCES Furniture(furniture_id),
    FOREIGN KEY (date_id) REFERENCES TimeDimension(date_id),

    CHECK (quantity > 0),
    CHECK (unit_price >= 0),
    CHECK (discount_amount >= 0),
    CHECK (discount_amount <= quantity * unit_price)
);
USE WholesaleFurnitureDB;

-- STATES
INSERT INTO States (state_name) VALUES
('Madhya Pradesh'),
('Rajasthan');

-- REGIONS
INSERT INTO Regions (region_name, state_id) VALUES
('Malwa', 1),
('Jaipur Region', 2);

-- CITIES
INSERT INTO Cities (city_name, region_id) VALUES
('Indore', 1),
('Ujjain', 1),
('Jaipur', 2);

-- CUSTOMERS
INSERT INTO Customers
(customer_name, phone, address, city_id) VALUES
('Rahul Traders', '9000000001', 'MG Road', 1),
('Aman Furniture House', '9000000002', 'Freeganj', 2),
('Royal Interiors', '9000000003', 'MI Road', 3);

-- FURNITURE TYPES
INSERT INTO FurnitureTypes (type_name) VALUES
('Chair'), ('Table'), ('Wardrobe'), ('Cabinet');

-- CATEGORIES
INSERT INTO Categories (category_name) VALUES
('Office'), ('Kitchen'), ('Bedroom'), ('Living Room');

-- MATERIALS
INSERT INTO Materials (material_name) VALUES
('Wood'), ('Marble'), ('Metal');

-- FURNITURE
INSERT INTO Furniture
(furniture_name, type_id, category_id, material_id) VALUES
('Office Wooden Chair', 1, 1, 1),
('Marble Dining Table', 2, 4, 2),
('Bedroom Wardrobe', 3, 3, 1),
('Kitchen Cabinet', 4, 2, 1),
('Metal Office Chair', 1, 1, 3);

-- TIME DIMENSION
INSERT INTO TimeDimension
(full_date, day, month, quarter, year) VALUES
('2026-01-15', 15, 1, 1, 2026),
('2026-02-10', 10, 2, 1, 2026),
('2026-03-20', 20, 3, 1, 2026),
('2025-12-12', 12, 12, 4, 2025);

-- SALES
-- discount_amount is the total discount for the entire line.

INSERT INTO Sales
(customer_id, furniture_id, date_id,
 quantity, unit_price, discount_amount) VALUES
(1, 1, 1, 10, 1500.00, 1000.00),
(2, 2, 2, 3, 12000.00, 2000.00),
(3, 3, 3, 2, 18000.00, 1500.00),
(1, 4, 1, 5, 8000.00, 1000.00),
(2, 5, 4, 8, 2500.00, 500.00),
(3, 1, 2, 4, 1500.00, 200.00),
(1, 2, 3, 2, 12000.00, 1000.00);
SELECT * FROM States;
SELECT * FROM Customers;
SELECT * FROM Furniture;
SELECT * FROM TimeDimension;
SELECT * FROM Sales;
SELECT
    f.furniture_name,
    ft.type_name,
    c.category_name,
    m.material_name
FROM Furniture f
JOIN FurnitureTypes ft ON f.type_id = ft.type_id
JOIN Categories c ON f.category_id = c.category_id
JOIN Materials m ON f.material_id = m.material_id;