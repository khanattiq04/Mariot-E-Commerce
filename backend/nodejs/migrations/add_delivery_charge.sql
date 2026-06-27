-- Per-product delivery charge (0 = free shipping). Order stores the summed charge.
ALTER TABLE `products` ADD COLUMN `delivery_charge` DECIMAL(10,2) NOT NULL DEFAULT 0;
ALTER TABLE `orders` ADD COLUMN `delivery_charge` DECIMAL(10,2) NOT NULL DEFAULT 0;
