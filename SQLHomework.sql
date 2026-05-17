#Ràng buộc điều kiện dữ liệu trong SQL
# name: không được null, cho phép trùng lặp
# email: không được null, phải duy nhất
# date: không được null, phải là ngày tháng hợp lệ

#B1.1: Tạo table không có dependency trước
CREATE TABLE `food_type` (
    `type_id` INT PRIMARY KEY AUTO_INCREMENT,
    `type_name` VARCHAR(30) NOT NULL
);

CREATE TABLE `user` (
    `user_id` INT PRIMARY KEY AUTO_INCREMENT,
    `full_name` VARCHAR(255),
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL
);

CREATE TABLE `restaurant` (
    `res_id` INT PRIMARY KEY AUTO_INCREMENT,
    `res_name` VARCHAR(255),
    `image` VARCHAR(255),
    `desc` VARCHAR(255) DEFAULT "Null"
);

#B1.2: Tạo table có dependency tạo sau để tránh lỗi khi có foreign key tham chiếu đến table chưa tồn tại
CREATE TABLE `food` (
    `food_id` INT PRIMARY KEY AUTO_INCREMENT,
    `food_name` VARCHAR(30),
    `image` VARCHAR(255),
    `price` FLOAT,
    `desc` VARCHAR(255) DEFAULT "Null",
	`type_id` INT,
	
    FOREIGN KEY (`type_id`) REFERENCES `food_type`(`type_id`)
);

CREATE TABLE `sub_food` (
    `sub_id` INT PRIMARY KEY AUTO_INCREMENT,
    `sub_name` VARCHAR(30),
    `sub_price` FLOAT,
    `food_id` INT,
    
	FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
);

CREATE TABLE `order` (
	#optional order_id (dùng nếu áp dụng chuẩn hóa)
    `order_id`  INT PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT,
    `food_id` INT,
    `amount` INT,   
    `code` VARCHAR(255) NOT NULL UNIQUE,
	
    FOREIGN KEY (user_id) REFERENCES `user`(user_id),
    FOREIGN KEY (food_id) REFERENCES `food`(food_id) 
);

#optional: chuẩn hóa dữ liệu (Normalization) cho bảng order
#problem: arr_sub_id chứa nhiều hơn 1 dữ liệu (vi phạm điều kiện của 1NF)
#->solution: tạo bảng riêng để mỗi giá trị được đặt riêng trong 1 column
CREATE TABLE `order_sub` (
    `order_id`  INT,
    `sub_id`    INT,
    PRIMARY KEY (`order_id`, `sub_id`),
    
    FOREIGN KEY (`order_id`) REFERENCES `order`(`order_id`),
    FOREIGN KEY (`sub_id`)   REFERENCES `sub_food`(`sub_id`)
);


CREATE TABLE `rate_res` (
    `user_id` INT,
    `res_id` INT,
    `amount` INT,
    `date_rate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, res_id),
    
    FOREIGN KEY (user_id) REFERENCES `user` (user_id),
    FOREIGN KEY (res_id) REFERENCES `restaurant` (res_id)
);

CREATE TABLE `like_res` (
    `user_id` INT,
    `res_id` INT,
    `date_like` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, res_id),

    FOREIGN KEY (user_id) REFERENCES `user` (user_id),
    FOREIGN KEY (res_id) REFERENCES `restaurant` (res_id)
);

# Xóa table theo thứ tự sau để tránh lỗi khi có foreign key
# tham chiếu đến table đã bị xóa

DROP TABLE `order_sub`;   -- depends on order and sub_food
DROP TABLE `sub_food`;-- depends on food
DROP TABLE `order`;-- depends on food, user
DROP TABLE `like_res`;-- depends on user, restaurant
DROP TABLE `rate_res`;-- depends on user, restaurant
DROP TABLE `food`;-- depends on food_type

DROP TABLE `food_type`;

DROP TABLE `restaurant`;

DROP TABLE `user`;


#B2: Thêm data vào trong các bảng

#2.1. Bảng user
INSERT INTO `user` (full_name, email, password) VALUES 
(
    'Nguyen Van An',
    'an.nguyen@email.com',
    'hashed_pw_1'
),
(
    'Tran Thi Bich',
    'bich.tran@email.com',
    'hashed_pw_2'
),
(
    'Le Hoang Cuong',
    'cuong.le@email.com',
    'hashed_pw_3'
),
(
    'Pham Thi Dung',
    'dung.pham@email.com',
    'hashed_pw_4'
),
(
    'Hoang Van Em',
    'em.hoang@email.com',
    'hashed_pw_5'
),
(
    'Vu Thi Phuong',
    'phuong.vu@email.com',
    'hashed_pw_6'
),
(
    'Dang Minh Quan',
    'quan.dang@email.com',
    'hashed_pw_7'
),
(
    'Ngo Thi Hoa',
    'hoa.ngo@email.com',
    'hashed_pw_8'
),
(
    'Truong Van Khoa',
    'khoa.truong@email.com',
    'hashed_pw_9'
),
(
    'Mai Thi Lan',
    'lan.mai@email.com',
    'hashed_pw_10'
);

#2.2. Bảng restaurant
INSERT INTO `restaurant` (res_name, image, `desc`) VALUES 
(
    'Pho Saigon',
    'pho_saigon.jpg',
    'Phở truyền thống Nam Bộ'
),
(
    'Bun Bo Hue',
    'bun_bo.jpg',
    'Bún bò Huế chuẩn vị miền Trung'
),
(
    'Com Tam Quan 1',
    'com_tam.jpg',
    'Cơm tấm sườn bì chả'
),
(
    'Banh Mi 362',
    'banh_mi.jpg',
    'Bánh mì Sài Gòn nổi tiếng'
),
(
    'Lau Thai Xanh',
    'lau_thai.jpg',
    'Lẩu Thái chua cay đặc trưng'
);

#2.3. Bảng food_type
INSERT INTO `food_type` (type_name) VALUES
('Món nước'),    -- type_id 1
('Món khô'),     -- type_id 2
('Bánh mì'),     -- type_id 3
('Lẩu');		-- type_id 4

#2.4. Bảng food
INSERT INTO `food` (food_name,image,price,`desc`,type_id) VALUES
(
    'Phở bò tái',
    'pho_bo.jpg',
    65000,
    'Phở bò tái thơm ngon',
    1
),
(
    'Phở gà',
    'pho_ga.jpg',
    60000,
    'Phở gà nhẹ nhàng',
    1
),
(
    'Bún bò Huế',
    'bun_bo.jpg',
    70000,
    'Bún bò cay đặc trưng',
    1
),
(
    'Cơm tấm sườn',
    'com_tam.jpg',
    55000,
    'Cơm tấm sườn bì chả trứng',
    2
),
(
    'Cơm tấm bì',
    'com_bi.jpg',
    50000,
    'Cơm tấm bì chả',
    2
),
(
    'Bánh mì thịt',
    'banh_mi.jpg',
    30000,
    'Bánh mì pate thịt nguội',
    3
),
(
    'Bánh mì trứng',
    'banh_mi_trung.jpg',
    25000,
    'Bánh mì trứng ốp la',
    3
),
(
    'Lẩu Thái hải sản',
    'lau_thai.jpg',
    250000,
    'Lẩu Thái 2 người chua cay',
    4
);

#2.5. Bảng sub_food
INSERT INTO `sub_food` (sub_name, sub_price, food_id) VALUES
('Thêm thịt',20000, 1),
('Thêm gân',15000, 1),
('Thêm đùi gà',25000, 2),
('Thêm giò heo',30000, 3),
('Thêm huyết',10000, 3),
('Thêm trứng',8000, 4),
('Thêm chả',12000, 4),
('Thêm tôm',50000, 8),
('Thêm mực',40000, 8);


#2.6. Bảng order
INSERT INTO `order` (user_id, food_id, amount, code) VALUES
(1, 1, 2, 'ORD-001'),
(1, 3, 1, 'ORD-002'),
(1, 6, 3, 'ORD-003'),
(1, 4, 1, 'ORD-004'),
(2, 2, 1, 'ORD-005'),
(2, 5, 2, 'ORD-006'),
(2, 8, 1, 'ORD-007'),
(3, 1, 1, 'ORD-008'),
(3, 7, 2, 'ORD-009'),
(4, 4, 1, 'ORD-010'),
(4, 3, 1, 'ORD-011'),
(5, 6, 2, 'ORD-012'),
(6, 8, 1, 'ORD-013'),
(7, 2, 1, 'ORD-014');

#2.6.1 (Bảng optional). Bảng order_sub
INSERT INTO `order_sub` (order_id, sub_id) VALUES
-- ORD-001 (order_id=1): was '[1,2]' → Thêm thịt, Thêm gân
(1, 1),
(1, 2),
-- ORD-002 (order_id=2): was '[4]' → Thêm giò heo
(2, 4),
-- ORD-003 (order_id=3): was NULL → no subs
-- ORD-004 (order_id=4): was '[6,7]' → Thêm trứng, Thêm chả
(4, 6),
(4, 7),
-- ORD-005 (order_id=5): was '[3]' → Thêm đùi gà
(5, 3),
-- ORD-006 (order_id=6): was NULL → no subs
-- ORD-007 (order_id=7): was '[8,9]' → Thêm tôm, Thêm mực
(7, 8),
(7, 9),
-- ORD-008 (order_id=8): was NULL → no subs
-- ORD-009 (order_id=9): was NULL → no subs
-- ORD-010 (order_id=10): was '[6]' → Thêm trứng
(10, 6),
-- ORD-011 (order_id=11): was '[5]' → Thêm huyết
(11, 5),
-- ORD-012 (order_id=12): was NULL → no subs
-- ORD-013 (order_id=13): was '[8]' → Thêm tôm
(13, 8),
-- ORD-014 (order_id=14): was '[3]' → Thêm đùi gà
(14, 3);


#B2.7. Bảng like_res và rate_res
INSERT INTO `like_res` (user_id, res_id, date_like) VALUES
(1, 1, '2024-01-10 08:00:00'),
(1, 3, '2024-01-15 09:30:00'),
(1, 5, '2024-02-01 11:00:00'),
(2, 1, '2024-01-12 10:00:00'),
(2, 2, '2024-01-20 14:00:00'),
(2, 4, '2024-02-05 16:00:00'),
(3, 1, '2024-01-18 08:30:00'),
(3, 5, '2024-02-10 12:00:00'),
(4, 2, '2024-01-22 09:00:00'),
(4, 3, '2024-02-15 13:30:00'),
(5, 1, '2024-02-01 10:30:00'),
(6, 4, '2024-02-08 15:00:00'),
(7, 5, '2024-02-20 17:00:00');

INSERT INTO `rate_res` (user_id, res_id, amount, date_rate) VALUES
(1, 1, 5, '2024-01-11 09:00:00'),
(1, 3, 4, '2024-01-16 10:00:00'),
(2, 1, 4, '2024-01-13 11:00:00'),
(2, 2, 5, '2024-01-21 14:30:00'),
(3, 5, 3, '2024-02-11 13:00:00'),
(4, 2, 4, '2024-01-23 09:30:00'),
(4, 3, 5, '2024-02-16 14:00:00'),
(5, 1, 5, '2024-02-02 11:30:00'),
(6, 4, 3, '2024-02-09 16:00:00'),
(7, 5, 4, '2024-02-21 18:00:00');

#3. SQL Query

#3.1. Tìm 5 người đã like nhà hàng nhiều nhất
SELECT U.user_id, U.full_name, COUNT(LR.res_id) AS "Số lượt thích"
FROM user U
LEFT JOIN like_res LR ON U.user_id = LR.user_id
GROUP BY U.user_id, U.full_name
ORDER BY COUNT(U.user_id) DESC
LIMIT 5;

#3.2. Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT R.res_id, R.res_name, COUNT(LR.res_id) AS "Số lượt thích"
FROM restaurant R
LEFT JOIN like_res LR ON R.res_id = LR.res_id
GROUP BY R.res_id, R.res_name
ORDER BY COUNT(LR.res_id) DESC
LIMIT 2;

#3.3. Tìm người đã đặt hàng nhiều nhất
SELECT U.user_id, U.full_name, COUNT(O.user_id) AS "Số lần order"
FROM user U
LEFT JOIN `order` O ON U.user_id = O.user_id
GROUP BY U.user_id, U.full_name
ORDER BY COUNT(O.user_id) DESC
LIMIT 1;


#3.4 Tìm người dùng không hoạt động trong hệ thống (không đặt hàng, không like, không đánh giá nhà hàng)
#Idea: lấy 3 bảng con có thông tin user_id, vì nếu không hoạt động thì trong cả 3 bảng con sẽ không có data => sử dụng NOT IN
SELECT U.user_id, U.full_name
FROM user U
WHERE U.user_id NOT IN (
    SELECT user_id FROM `order`
    UNION
    SELECT user_id FROM like_res
    UNION
    SELECT user_id FROM rate_res
);



