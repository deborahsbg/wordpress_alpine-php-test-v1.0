<?php
// Database settings fallback
if (!defined('DB_NAME')) {
    define('DB_NAME', 'casbeghen_db');
}
if (!defined('DB_USER')) {
    define('DB_USER', 'root');
}
if (!defined('DB_PASSWORD')) {
    $db_password_file = '/run/secrets/db_password';
    define('DB_PASSWORD', file_exists($db_password_file) ? trim(file_get_contents($db_password_file)) : '');
}
if (!defined('DB_HOST')) {
    define('DB_HOST', 'wordpress_db');
}

// Redis settings
if (!defined('WP_REDIS_HOST')) {
    define('WP_REDIS_HOST', 'redis');
}
if (!defined('WP_REDIS_PORT')) {
    define('WP_REDIS_PORT', 6379);
}
if (!defined('WP_REDIS_PASSWORD')) {
    $redis_password_file = '/run/secrets/redis_password';
    define('WP_REDIS_PASSWORD', file_exists($redis_password_file) ? trim(file_get_contents($redis_password_file)) : '');
}
if (!defined('WP_CACHE')) {
    define('WP_CACHE', true);
}
if (!defined('WP_REDIS_MAXTTL')) {
    define('WP_REDIS_MAXTTL', 3600); // 1-hour max TTL
}
if (!defined('WP_REDIS_CLIENT')) {
    define('WP_REDIS_CLIENT', 'predis');
}

