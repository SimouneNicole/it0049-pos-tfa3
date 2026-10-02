<?php

use App\Controllers\Customers;
use App\Controllers\Pages;
use App\Controllers\Users;
use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', [Pages::class, 'home']);
$routes->get('about', [Pages::class, 'about']);
$routes->get('customers', [Customers::class, 'index']);
$routes->get('customers/new', [Customers::class, 'new']);
$routes->post('customers', [Customers::class, 'create']);
$routes->get('customers/(:num)/edit', [Customers::class, 'edit/$1']);
$routes->post('customers/(:num)', [Customers::class, 'update/$1']);
$routes->get('users', [Users::class, 'index']);
$routes->get('users/new', [Users::class, 'new']);
$routes->post('users', [Users::class, 'create']);
$routes->get('users/(:num)/edit', [Users::class, 'edit/$1']);
$routes->post('users/(:num)', [Users::class, 'update/$1']);
