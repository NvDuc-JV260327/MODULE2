-- Thêm một đơn hàng mới vào bảng orders và chi tiết của đơn hàng đó vào bảng order_details.
-- Tính tổng doanh thu của toàn bộ cửa hàng
SELECT SUM(quantity * price) AS 'Doanh thu'
FROM order_details;

-- Tính doanh thu trung bình của mỗi đơn hàng
SELECT AVG(quantity * price) AS 'Doanh thu TB'
FROM order_details;

-- Tìm và hiển thị thông tin của đơn hàng có doanh thu cao nhất
SELECT * 
FROM order_details
WHERE order_id = (
	SELECT order_id
    FROM order_details
    GROUP BY order_id
    ORDER BY SUM(quantity * price) DESC
    LIMIT 1
);

-- Tìm và hiển thị danh sách 3 sản phẩm bán chạy nhất dựa trên tổng số lượng đã bán
SELECT p.id,
       p.name,
       SUM(od.quantity) AS total_sold
FROM products p
JOIN order_details od
    ON p.id = od.product_id
GROUP BY p.id, p.name
ORDER BY total_sold DESC
LIMIT 3;
