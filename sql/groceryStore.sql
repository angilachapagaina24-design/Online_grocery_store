-- ============================================================
--  FreshMart Grocery Store – Complete Database Schema
-- ============================================================

CREATE DATABASE IF NOT EXISTS grocery_store;
USE grocery_store;

-- ── USERS ────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
    user_id    INT AUTO_INCREMENT PRIMARY KEY,
    full_name  VARCHAR(100) NOT NULL,
    email      VARCHAR(150) NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    phone      VARCHAR(20),
    address    VARCHAR(255),
    role       ENUM('admin','customer') DEFAULT 'customer',
    status     ENUM('active','inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ── CATEGORIES ───────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS category (
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description   VARCHAR(255),
    image_url     VARCHAR(255),
    status        ENUM('active','inactive') DEFAULT 'active'
);

-- ── PRODUCTS ─────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS product (
    product_id     INT AUTO_INCREMENT PRIMARY KEY,
    category_id    INT NOT NULL,
    name           VARCHAR(150) NOT NULL,
    description    TEXT,
    price          DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    unit           VARCHAR(30),
    image_url      VARCHAR(255),
    brand          VARCHAR(100),
    expiry_date    DATE,
    status         VARCHAR(20) DEFAULT 'available',
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- ── CART ITEMS (persisted cart, optional) ────────────────────
CREATE TABLE IF NOT EXISTS cart_items (
    cart_id    INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT DEFAULT 1,
    added_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)    REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- ── ORDERS ───────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS orders (
    order_id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id          INT NOT NULL,
    total_amount     DECIMAL(10,2) NOT NULL,
    order_status     ENUM('pending','confirmed','processing','shipped','delivered','cancelled')
                     DEFAULT 'pending',
    payment_method   VARCHAR(50),
    payment_status   ENUM('unpaid','paid') DEFAULT 'unpaid',
    shipping_address VARCHAR(500),
    delivery_address VARCHAR(500),
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ── ORDER ITEMS ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS order_items (
    item_id      INT AUTO_INCREMENT PRIMARY KEY,
    order_id     INT NOT NULL,
    product_id   INT NOT NULL,
    product_name VARCHAR(150),
    quantity     INT NOT NULL,
    price        DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);
