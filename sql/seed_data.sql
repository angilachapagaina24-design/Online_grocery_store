USE grocery_store;

-- =========================
-- USERS
-- =========================
INSERT INTO users (full_name, email, password, phone, address, role)
VALUES
('Admin User', 'admin@grocery.com', 'admin123', '9800000000', 'Pokhara', 'admin'),
('John Doe', 'john@gmail.com', '123456', '9811111111', 'Kathmandu', 'customer'),
('Jane Smith', 'jane@gmail.com', '123456', '9822222222', 'Lalitpur', 'customer');

-- =========================
-- CATEGORIES
-- =========================


INSERT INTO category (category_name, description, image_url)
VALUES 
('Bakery', 'Freshly baked bread and buns', 'Images/bakery.png'),
('Grains', 'Rice, lentils, and flour', 'Images/grains.jpg');
('Fruits', 'Apple, Banana, and Mango', 'Images/grains.png');

-- =========================
-- PRODUCTS
-- =========================
INSERT INTO product 
(category_id, name, description, price, stock_quantity, unit, brand, image_url)
VALUES
(1, 'Apple', 'Fresh red apples', 200.00, 50, 'kg', 'Local Farm', 'Images/apple.png'),
(1, 'Banana', 'Sweet bananas', 120.00, 100, 'dozen', 'Organic', 'Images/banana.jpg'),
(2, 'Potato', 'Fresh potatoes', 60.00, 200, 'kg', 'Local Farm', 'Images/potato.jpg'),
(2, 'Milk', 'Fresh cow milk', 90.00, 80, 'litre', 'DairyBest', 'Images/milk.jpg'),
(2, 'Coca Cola', 'Soft drink', 50.00, 150, 'bottle', 'Coca Cola', 'Images/coke.jpg');

-- =========================
-- CART ITEMS
-- =========================
INSERT INTO cart_items (user_id, product_id, quantity)
VALUES
(2, 1, 2),
(2, 3, 1),
(3, 2, 5);

-- =========================
-- ORDERS
-- =========================
INSERT INTO orders (user_id, total_amount, order_status, payment_method, payment_status, delivery_address)
VALUES
(2, 460.00, 'confirmed', 'cash_on_delivery', 'unpaid', 'Kathmandu'),
(3, 600.00, 'pending', 'online', 'paid', 'Lalitpur');

-- =========================
-- ORDER ITEMS
-- =========================
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
(1, 1, 2, 200.00),
(1, 3, 1, 60.00),
(2, 2, 5, 120.00);