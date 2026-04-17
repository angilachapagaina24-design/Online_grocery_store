CREATE DATABASE grocery_store;
USE grocery_store;

-- =========================
-- USER TABLE
-- =========================
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(50) NOT NULL,
    role ENUM('admin', 'customer') DEFAULT 'customer',
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- CATEGORY TABLE
-- =========================
CREATE TABLE category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    image_url VARCHAR(255),
    description TEXT,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- PRODUCT TABLE
-- =========================
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    unit VARCHAR(50), -- kg, litre, piece
    image_url VARCHAR(255),
    brand VARCHAR(100),
    expiry_date DATE,
    status ENUM('available', 'out_of_stock') DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (category_id) REFERENCES category(category_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- =========================
-- CART TABLE (optional but useful)
-- =========================
CREATE TABLE cart_items (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
        ON DELETE CASCADE
);

-- =========================
-- ORDERS TABLE
-- =========================
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    total_amount DECIMAL(10,2),
    order_status ENUM('pending', 'confirmed', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    payment_method ENUM('cash_on_delivery', 'online'),
    payment_status ENUM('paid', 'unpaid') DEFAULT 'unpaid',
    delivery_address TEXT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
);

-- =========================
-- ORDER ITEMS TABLE
-- =========================
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),

    FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
        ON DELETE CASCADE
);