<?php
// ** Database settings ** //
define('DB_NAME', 'casbeghen_db');
define('DB_USER', 'root');
define('DB_PASSWORD', safe_file_get_contents('/run/secrets/db_password'));
define('DB_HOST', 'wordpress_db');
define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

// ** Authentication Unique Keys and Salts ** //
define('AUTH_KEY', safe_file_get_contents('/run/secrets/auth_key'));
define('SECURE_AUTH_KEY', safe_file_get_contents('/run/secrets/secure_auth_key'));
define('LOGGED_IN_KEY', safe_file_get_contents('/run/secrets/logged_in_key'));
define('NONCE_KEY', safe_file_get_contents('/run/secrets/nonce_key'));
define('AUTH_SALT', safe_file_get_contents('/run/secrets/auth_salt'));
define('SECURE_AUTH_SALT', safe_file_get_contents('/run/secrets/secure_auth_salt'));
define('LOGGED_IN_SALT', safe_file_get_contents('/run/secrets/logged_in_salt'));
define('NONCE_SALT', safe_file_get_contents('/run/secrets/nonce_salt'));

// ** Redis Cache Settings ** //
define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);
define('WP_REDIS_PASSWORD', safe_file_get_contents('/run/secrets/redis_password'));
define('WP_CACHE', true); // Caching explicitly enabled for development

// Database Table Prefix
$table_prefix = 'ca_';

// Enable email-based password recovery
define('WP_MAIL_FROM', getenv('WP_ADMIN_EMAIL') ?: 'deborahsbeghen@gmail.com');
define('WP_MAIL_FROM_NAME', 'CasBeghen Development');

// Include additional configurations
if (file_exists(__DIR__ . '/wp-config-additions.php')) {
    include_once __DIR__ . '/wp-config-additions.php';
}

// Debugging Mode
define('WP_DEBUG', true); // Debugging enabled for development
define('WP_DEBUG_LOG', true); // Enable debug logging
define('WP_DEBUG_DISPLAY', true); // Show errors on screen
@ini_set('display_errors', 1);

// Safely read secret files
function safe_file_get_contents($file) {
    if (file_exists($file)) {
        return trim(file_get_contents($file));
    }
    error_log("Warning: Secret file $file is missing.");
    return '';
}

// Set WordPress paths
if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}
require_once ABSPATH . 'wp-settings.php';

