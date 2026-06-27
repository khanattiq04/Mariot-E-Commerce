CREATE TABLE IF NOT EXISTS invoices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_number VARCHAR(100) NOT NULL UNIQUE,
    order_id INT NOT NULL,
    user_id INT DEFAULT NULL,
    user_email VARCHAR(255) DEFAULT NULL,
    user_name VARCHAR(255) DEFAULT NULL,
    order_total DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    given_by_user_id INT DEFAULT NULL,
    given_by_name VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_order_id (order_id),
    INDEX idx_user_id (user_id),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);
