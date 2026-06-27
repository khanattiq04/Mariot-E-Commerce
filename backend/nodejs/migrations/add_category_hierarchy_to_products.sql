-- Migration to add sub-category and sub-sub-category foreign keys to products table
ALTER TABLE products 
ADD COLUMN sub_category_id INT NULL AFTER category_id,
ADD COLUMN sub_sub_category_id INT NULL AFTER sub_category_id;

-- Add foreign key constraints
ALTER TABLE products
ADD CONSTRAINT fk_product_sub_category FOREIGN KEY (sub_category_id) REFERENCES categories(id) ON DELETE SET NULL,
ADD CONSTRAINT fk_product_sub_sub_category FOREIGN KEY (sub_sub_category_id) REFERENCES categories(id) ON DELETE SET NULL;

-- Create indexes for performance
CREATE INDEX idx_products_sub_category_id ON products(sub_category_id);
CREATE INDEX idx_products_sub_sub_category_id ON products(sub_sub_category_id);
