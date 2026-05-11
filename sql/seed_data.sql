USE grocery_store;

-- =========================
-- USERS
-- =========================
INSERT INTO users (full_name, email, password, phone, address, role) VALUES
('Admin User', 'admin@grocery.com', 'admin123', '9800000000', 'Pokhara', 'admin'),
('John Doe',   'john@gmail.com',    '123456',   '9811111111', 'Kathmandu', 'customer'),
('Jane Smith', 'jane@gmail.com',    '123456',   '9822222222', 'Lalitpur',  'customer');

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
-- FRUITS (category_id = 1)
-- =========================
INSERT INTO product (category_id, name, description, price, stock_quantity, unit, image_url, brand) VALUES
(1, 'Apple',     'Fresh red apples',          180, 100, 'kg',    'apple.png',     'FreshFarm'),
(1, 'Banana',    'Organic bananas',           120, 150, 'dozen', 'banana.png',    'Organic'),
(1, 'Orange',    'Juicy sweet oranges',       160,  90, 'kg',    'orange.png',    'CitrusFresh'),
(1, 'Grapes',    'Seedless green grapes',     240,  60, 'kg',    'grapes.png',    'FreshFarm'),
(1, 'Mango',     'Sweet ripe mangoes',        200,  80, 'kg',    'mango.png',     'FreshFarm'),
(1, 'Pineapple', 'Fresh tropical pineapple',  150,  70, 'piece', 'pineapple.png', 'TropicalFresh');

-- =========================
-- VEGETABLES (category_id = 2)
-- =========================
INSERT INTO product (category_id, name, description, price, stock_quantity, unit, image_url, brand) VALUES
(2, 'Tomato',   'Fresh red tomatoes',        90, 120, 'kg', 'tomato.png',   'GreenLeaf'),
(2, 'Potato',   'Farm fresh potatoes',       70, 200, 'kg', 'potato.png',   'LocalFarm'),
(2, 'Carrot',   'Crunchy orange carrots',   110,  90, 'kg', 'carrot.png',   'VeggieFresh'),
(2, 'Broccoli', 'Healthy green broccoli',   220,  40, 'kg', 'broccoli.png', 'GreenLeaf'),
(2, 'Cabbage',  'Fresh green cabbage',       80, 100, 'kg', 'cabbage.png',  'LocalFarm'),
(2, 'Spinach',  'Leafy green spinach',       60, 150, 'kg', 'spinach.png',  'VeggieFresh');

-- =========================
-- DAIRY (category_id = 3)
-- =========================
INSERT INTO product (category_id, name, description, price, stock_quantity, unit, image_url, brand) VALUES
(3, 'Milk',            'Fresh cow milk',        75, 100, 'litre', 'milk.png',            'DairyBest'),
(3, 'Cheese',          'Cheddar cheese block', 350,  40, 'pack',  'cheese.png',          'Amul'),
(3, 'Butter',          'Creamy butter',        280,  60, 'pack',  'butter.png',          'DairyBest'),
(3, 'Yogurt',          'Thick plain yogurt',    90,  80, 'cup',   'yogurt.png',          'DairyBest'),
(3, 'Ice Cream',       'Vanilla ice cream',    250,  50, 'box',   'icecream.png',        'ColdTreat'),
(3, 'Strawberry Milk', 'Fresh strawberry milk',250,  45, 'litre', 'strawberrymilk.png',  'DairyBest');

-- =========================
-- BAKERY (category_id = 4)
-- =========================
INSERT INTO product (category_id, name, description, price, stock_quantity, unit, image_url, brand) VALUES
(4, 'Bread',     'Whole wheat bread',      75,  80, 'piece', 'bread.png',     'BakeryFresh'),
(4, 'Cake',      'Chocolate cake',        550,  25, 'piece', 'cake.png',      'BakeHouse'),
(4, 'Croissant', 'Buttery croissant',     150,  50, 'piece', 'croissant.png', 'BakeHouse'),
(4, 'Donut',     'Sweet glazed donut',     90,  70, 'piece', 'donut.png',     'SweetBake'),
(4, 'Muffin',    'Chocolate muffin',      120,  60, 'piece', 'muffin.png',    'BakeHouse'),
(4, 'Cookies',   'Crunchy cookies pack',  180,  55, 'pack',  'cookies.png',   'SweetBake');

-- =========================
-- BEVERAGES (category_id = 5)
-- =========================
INSERT INTO product (category_id, name, description, price, stock_quantity, unit, image_url, brand) VALUES
(5, 'Coca Cola',     'Chilled soft drink',    120, 100, 'bottle', 'cocacola.png',    'CocaCola'),
(5, 'Orange Juice',  'Fresh orange juice',    180,  80, 'bottle', 'orangejuice.png', 'JuicyFresh'),
(5, 'Mineral Water', 'Pure drinking water',    40, 200, 'bottle', 'water.png',       'AquaFresh'),
(5, 'Energy Drink',  'Boost energy drink',    150,  60, 'can',    'energydrink.png', 'PowerPlus'),
(5, 'Apple Juice',   'Fresh apple juice',     170,  70, 'bottle', 'applejuice.png',  'FruitKing'),
(5, 'Lemon Soda',    'Refreshing lemon soda', 110,  90, 'bottle', 'lemonsoda.png',   'FizzUp');

-- =========================
-- SPICES & SEASONING (category_id = 6)
-- =========================
INSERT INTO product (category_id, name, description, price, stock_quantity, unit, image_url, brand) VALUES
(6, 'Turmeric Powder', 'Organic turmeric',          180, 50, 'pack',   'turmeric.png', 'SpiceWorld'),
(6, 'Black Pepper',    'Premium pepper',             220, 40, 'pack',   'pepper.png',   'SpiceWorld'),
(6, 'Cinnamon',        'Aromatic cinnamon',          200, 35, 'pack',   'cinnamon.png', 'SpiceWorld'),
(6, 'Chili Powder',    'Spicy red chili powder',     150, 60, 'pack',   'chili.png',    'HotSpice'),
(6, 'Salt',            'Iodized salt',                50,200, 'pack',   'salt.png',     'PureSalt'),
(6, 'Curry Powder',    'Mixed spice curry powder',   180, 45, 'pack',   'curry.png',    'SpiceWorld');

-- =========================
-- CART ITEMS
-- =========================
INSERT INTO cart_items (user_id, product_id, quantity) VALUES
(2, 1, 2),
(2, 3, 1),
(3, 2, 5);

-- =========================
-- ORDERS
-- =========================
INSERT INTO orders (user_id, total_amount, order_status, payment_method, payment_status, delivery_address) VALUES
(2, 460.00, 'confirmed', 'cash_on_delivery', 'unpaid', 'Kathmandu'),
(3, 600.00, 'pending',   'online',           'paid',   'Lalitpur');

-- =========================
-- ORDER ITEMS
-- =========================
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 200.00),
(1, 3, 1,  60.00),
(2, 2, 5, 120.00);