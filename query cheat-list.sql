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
