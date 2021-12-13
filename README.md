# README

RAILS ENGINE LITE SOLO PROJECT

* Ruby version: ruby 2.7.2 | Rails version: 5.3.6

* Database creation: Rails db:{drop, create, migrate, seed}

* How to run the test suite: RSpec


RAILS API APPLICATION ENDPOINTS

- GET /api/v1/items
- GET /api/v1/items/:id 
- POST /api/v1/items
- PUT /api/v1/items/:id
- DELETE /api/v1/item/:id
- GET /api/v1/items/:id/merchant
- GET /api/v1/merchants/find_all | query params: name, min_price, max_price. NOTE: Can not use name and price params together at once.

- GET /api/v1/merchants
- GET /api/v1/merchants/:id
- GET /api/v1/merchants/:id/items
- GET /api/v1/merchants/find | query params: name
