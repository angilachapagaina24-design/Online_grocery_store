USE grocery_store;

-- CATEGORY DATA
INSERT INTO category
(category_id, category_name, image_url, description, status)
VALUES
(1,'Fruits','fruits 1.png','Fresh fruits','active'),
(2,'Vegetables','vegetables 1.png','Fresh vegetables','active'),
(3,'Dairy','dairy 1.png','Dairy products','active'),
(4,'Bakery','bakery.png','Baked goods','active'),
(5,'Beverages','beverages 1.png','Drinks and juices','active'),
(6,'Spices & Seasoning','spices and seasoning 1.png','Spices and seasonings','active');

-- USERS DATA
INSERT INTO users
(user_id, full_name, email, password, phone, address, role, status)
VALUES
(1,'Admin User','admin@grocery.com','admin123','9800000000','Pokhara','admin','active'),
(2,'John Doe','john@gmail.com','123456','9811111111','Kathmandu','customer','active'),
(3,'Jane Smith','jane@gmail.com','123456','9822222222','Lalitpur','customer','active');

-- PRODUCT DATA
INSERT INTO product
(product_id, category_id, name, description, price, stock_quantity,
unit, image_url, brand, status)
VALUES
(1,1,'Apple','Fresh red apples',180.00,98,'kg','apple.png','FreshFarm','available'),
(2,1,'Banana','Organic bananas',120.00,150,'dozen','banana.png','Organic','available'),
(3,1,'Orange','Juicy sweet oranges',160.00,90,'kg','orange.png','CitrusFresh','available'),
(19,2,'Tomato','Fresh red tomatoes',90.00,120,'kg','tomato.png','GreenLeaf','available'),
(25,3,'Milk','Fresh cow milk',75.00,99,'litre','milk.png','DairyBest','available'),
(31,4,'Bread','Whole wheat bread',75.00,80,'piece','bread.png','BakeryFresh','available'),
(37,6,'Turmeric Powder','Organic turmeric',180.00,50,'pack','turmeric.png','SpiceWorld','available');

-- ORDERS DATA
INSERT INTO orders
(order_id, user_id, total_amount, order_status,
payment_method, payment_status, delivery_address)
VALUES
(1,2,460.00,'confirmed','cash_on_delivery','unpaid','Kathmandu'),
(2,3,600.00,'confirmed','online','paid','Lalitpur');

-- ORDER ITEMS DATA
INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, price, product_name)
VALUES
(1,1,1,2,200.00,'Apple'),
(2,1,3,1,60.00,'Orange'),
(3,2,2,5,120.00,'Banana');

-- CART ITEMS DATA
INSERT INTO cart_items
(cart_id, user_id, product_id, quantity)
VALUES
(1,2,1,2),
(2,2,3,1),
(3,3,2,5);