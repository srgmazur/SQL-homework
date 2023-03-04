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
