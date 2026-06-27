-- Product variants: options (Color, Size) + combinations with own price/stock/SKU

CREATE TABLE IF NOT EXISTS product_options (
  id INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  name_ar VARCHAR(50) NULL,
  position INT DEFAULT 0,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  INDEX idx_po_product (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS product_variants (
  id INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT NOT NULL,
  sku VARCHAR(100) NULL,
  price DECIMAL(10,2) NOT NULL DEFAULT 0,
  offer_price DECIMAL(10,2) NULL,
  stock_quantity INT NOT NULL DEFAULT 0,
  image_url VARCHAR(500) NULL,
  use_primary_image TINYINT(1) NOT NULL DEFAULT 1,
  options_signature VARCHAR(500) NOT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  UNIQUE KEY uk_variant_sig (product_id, options_signature),
  UNIQUE KEY uk_variant_sku (sku),
  INDEX idx_pv_product (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS product_variant_options (
  variant_id INT NOT NULL,
  option_id INT NOT NULL,
  value VARCHAR(100) NOT NULL,
  value_ar VARCHAR(100) NULL,
  PRIMARY KEY (variant_id, option_id),
  FOREIGN KEY (variant_id) REFERENCES product_variants(id) ON DELETE CASCADE,
  FOREIGN KEY (option_id) REFERENCES product_options(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Default variant flag
ALTER TABLE product_variants ADD COLUMN is_default TINYINT(1) NOT NULL DEFAULT 0;

-- Flag on products to short-circuit lookups
ALTER TABLE products ADD COLUMN has_variants TINYINT(1) NOT NULL DEFAULT 0;

-- Link cart and order lines to a specific variant (nullable: products without variants still work)
ALTER TABLE cart_items ADD COLUMN variant_id INT NULL AFTER product_id;
ALTER TABLE cart_items ADD INDEX idx_ci_variant (variant_id);
ALTER TABLE cart_items ADD CONSTRAINT fk_ci_variant FOREIGN KEY (variant_id) REFERENCES product_variants(id) ON DELETE CASCADE;

ALTER TABLE order_items ADD COLUMN variant_id INT NULL AFTER product_id;
ALTER TABLE order_items ADD INDEX idx_oi_variant (variant_id);
-- order_items intentionally has NO FK on variant_id — historical orders must survive variant deletion
