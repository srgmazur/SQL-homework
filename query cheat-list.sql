-- first one
SELECT
  order_id,
  product_ids,
  creation_time
FROM
  orders
ORDER BY
  creation_time desc
LIMIT
  100
---

select
  name as product_name,
  price as product_price
from
  products
order by
  price desc
limit
  5
----
select
  price :: varchar
from
  products

-----

select
  courier_id,
  date_part ('year', birth_date) as birth_year
from
  couriers
order by
  birth_year desc,
  courier_id
  
  ---
  
  select
  courier_id,
  coalesce (date_part ('year', birth_date) :: varchar, 'unknown') as birth_year
from
  couriers
order by
  birth_year desc,
  courier_id
