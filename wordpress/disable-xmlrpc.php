<?php
// wp-content/mu-plugins/disable-xmlrpc.php
// Disable XML-RPC for security.
add_filter('xmlrpc_enabled', '__return_false');

