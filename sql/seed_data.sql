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


INSERT INTO category (category_name, description, image_url) VALUES
('Fruits',             'Fresh fruits',          'fruits 1.png'),
('Vegetables',         'Fresh vegetables',      'vegetables 1.png'),
('Dairy',              'Dairy products',        'dairy 1.png'),
('Bakery',             'Baked goods',           'bakery.png'),
('Beverages',          'Drinks and juices',     'beverages 1.png'),
('Spices & Seasoning', 'Spices and seasonings', 'spices and seasoning 1.png');

-- =========================
-- PRODUCTS
-- =========================
INSERT INTO product (category_id, name, description, price, stock_quantity, unit, image_url, brand) VALUES
(1, 'Organic Bananas', 'Fresh organic bananas',  120, 100, 'dozen',  'Banana 1 1.png',       'Organic'),
(3, 'Fresh Milk',      'Fresh cow milk',          75,  80, 'litre',  'milk 1.png',           'DairyBest'),
(4, 'Whole Bread',     'Whole wheat bread',       75,  50, 'piece',  'bread 1.png',          'BakeryFresh'),
(5, 'Tropical Drinks', 'Tropical fruit juice',   100,  60, 'bottle', 'juice 1.png',          'TropicFresh'),
(6, 'Buldak Ramen',    'Spicy Korean ramen',     250,  40, 'pack',   'buldak 1.png',         'Samyang'),
(1, 'Brown Egg',       'Farm fresh brown eggs',  500,  30, 'dozen',  'brown eggs 1.png',     'LocalFarm'),
(6, 'Mapel Syrup',     'Pure maple syrup',       380,  25, 'bottle', 'mapel syrup.png',      'PureLeaf'),
(3, 'Strawberry Milk', 'Fresh strawberry milk',  250,  45, 'litre',  'strawberrymilk 1.png', 'DairyBest');

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