ALTER TABLE `categories`
  ADD COLUMN `show_on_home` TINYINT(1) NOT NULL DEFAULT 0 AFTER `order_index`,
  ADD COLUMN `home_poster_url` VARCHAR(500) DEFAULT NULL AFTER `show_on_home`,
  ADD COLUMN `home_poster_url_ar` VARCHAR(500) DEFAULT NULL AFTER `home_poster_url`;
