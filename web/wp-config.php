<?php
$root_dir = dirname(__DIR__);
$webroot_dir = $root_dir . '/web';

/**
 * URLs
 */
define('WP_HOME', 'http://local.dev');
define('WP_SITEURL', 'http://local.dev/wp');

/**
 * Custom Content Directory
 */
define('CONTENT_DIR', '/app');
define('WP_CONTENT_DIR', $webroot_dir . CONTENT_DIR);
define('WP_CONTENT_URL', WP_HOME . CONTENT_DIR);

/**
 * DB settings
 */
define('DB_NAME', 'vagrant');
define('DB_USER', 'root');
define('DB_PASSWORD', 'root');
define('DB_HOST', 'localhost');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
$table_prefix  = 'wp_';

/**
 * Authentication Unique Keys and Salts
 */
/**#@-*/
 define('AUTH_KEY',         '[zgoB<E $E2*%Ne ayr+.s)u+VTe*/X;Sq-B~],{[S:LN`wF C!$$yH:L(/oz6tZ');
 define('SECURE_AUTH_KEY',  ':-&q]<Lf3-tZd+Gi:#:f|;ozlANKyQS4GaY0YaEi<geU#H&E8CRr>D?kyA pFMIg');
 define('LOGGED_IN_KEY',    'C[J|xTn/Rx)N989Ao{I!hNz|(1@chPDZ,V2&*0.~m/ ?8iB5jb5~ ;.jH`~&.-YJ');
 define('NONCE_KEY',        '|MA|(5.@-8&{>S?Q3f>|8+fj2?@L;RSIJTe$#!%JXVWL{:)vSh0X|JW~Q~WJ0[c;');
 define('AUTH_SALT',        'Ta5i8ygS4QwT,=-PV/|BNoKEyHE7`wFV+xv(Dn0m[,xok;ZiPV-Z^kmg#(;-De3t');
 define('SECURE_AUTH_SALT', 'YoCQL9C5]IKNZLu;[Ty44Kl^`;q/ghPMW>;4EiyAcomu0{i+c{UrrH*Eh}|I}Sct');
 define('LOGGED_IN_SALT',   'o]a9.BJlJA!xd;KW_ZJ.d)t/-NnyZ^<J@ad..64s)_dD]ypmdChXHH+SnwQ&4jJY');
 define('NONCE_SALT',       '6j7vy|X={Ds9O^AX)<1)=R}T{hS3+yhbh)+kGQD,s3FH%wUa5#N#w&q_+o E8o;H');
/**#@-*/

/* Debug Mode */
define('WP_DEBUG', true);

/* Absolute path to the WordPress directory. */
if (!defined('ABSPATH')) {
  define('ABSPATH', $webroot_dir . '/wp/');
}

/* Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
