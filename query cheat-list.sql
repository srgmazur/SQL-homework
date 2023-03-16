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

-- Для первых 200 записей из таблицы orders выведите информацию в следующем виде (обратите внимание на пробелы):
-- Заказ № [id_заказа] создан [дата]
-- Полученную колонку назовите order_info.

select concat_ws (' ', 'Заказ №', order_id, 'создан', creation_time::date) as order_info 
from
  orders
limit
  200
