-- Arabic images for hero slider + promotions (popups/banners)
ALTER TABLE `hero_slides` ADD COLUMN `image_ar` TEXT AFTER `image`;
ALTER TABLE `promotions` ADD COLUMN `image_url_ar` TEXT AFTER `image_url`;
