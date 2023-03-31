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
  
-- Давайте представим, что по какой-то необъяснимой причине мы вдруг решили в одночасье повысить цену всех товаров
-- в таблице products на 5%. Выведите наименования всех товаров, их старую и новую цену.
-- Колонку с новой ценой назовите new_price. Результат отсортируйте по убыванию значений в новой колонке.
-- Поля в результирующей таблице: name, price, new_price
select
  name,
  price,
  price * 1.05 as new_price
from
  products
order by
  new_price desc


-- Вновь, как и в прошлом задании, повысьте цену всех товаров на 5%, только теперь к колонке с новой ценой 
-- примените функцию ROUND. Выведите id и наименование товаров, их старую цену, а также новую цену с округлением.
-- Новую цену округлите до одного знака после запятой, но тип данных не меняйте. Колонку с новой ценой снова назовите new_price.
-- Результат отсортируйте сначала по убыванию новой цены, затем по возрастанию id товара.
--
-- Поля в результирующей таблице: product_id, name, price, new_price

select
  product_id,
  name,
  price,
  round(price * 1.05, 1) as new_price
from
  products
order by
  new_price desc, 
  product_id
  
  -- Повысьте цену на 5% только на те товары, цена которых превышает 100 рублей.
-- Цену остальных товаров оставьте без изменений. Также не повышайте цену на икру, которая и так стоит 800 рублей.
-- Выведите id и наименования всех товаров, их старую и новую цену. Цену округлять не нужно.
-- Колонку с новой ценой снова назовите new_price.
-- Результат отсортируйте сначала по убыванию новой цены, затем по возрастанию id товара.
--
-- Поля в результирующей таблице: product_id, name, price, new_price
select
  product_id,
  name,
  price as old_price,
  case
    when price > 100
    and name != 'икра' then price * 1.05
    else price
  end as new_price
from
  products
order by
  new_price desc,
  product_id
  
  -- Вычислите НДС каждого товара в таблице products и рассчитайте цену без учёта НДС. 
-- Выведите всю информацию о товарах, включая сумму налога и цену без его учёта. 
-- Колонки с суммой налога и ценой без НДС назовите соответственно tax и price_before_tax. 
-- Округлите значения в этих колонках до двух знаков после запятой.
--
-- Результат отсортируйте сначала по убыванию цены товара без учёта НДС, затем по возрастанию id товара.
-- Поля в результирующей таблице: product_id, name, price, tax, price_before_tax

select
  product_id,
  name,
  price,
  round(price / 120 * 20, 2) as tax,
  round(price - (price / 120 * 20), 2) as price_before_tax
from
  products
order by
  price_before_tax desc,
  product_id
  
-- Используя операторы SELECT, FROM, ORDER BY и LIMIT, а также функцию LENGTH, определите товар с самым длинным названием
-- в таблице products. Выведите его наименование, длину наименования в символах, а также цену этого товара.
-- Колонку с длиной наименования в символах назовите name_length.
--
-- Поля в результирующей таблице: name, name_length, price

select
  name,
  length(name) as name_length,
  price
from
  products
order by
  name_length desc
LIMIT
  1
  
-- Отберите из таблицы products все товары, названия которых либо начинаются со слова «чай», либо состоят из пяти символов.
-- Выведите две колонки: id товаров и их наименования.
-- Результат должен быть отсортирован по возрастанию id товара.
-- Поля в результирующей таблице: product_id, name
select
  product_id,
  name
from
  products
where
  split_part(name,' ',1) = 'чай' OR length(name) = 5
order by
  product_id

-- Выберите из таблицы products id и наименования только тех товаров, названия которых начинаются на букву «с» и содержат только одно слово.
-- Результат должен быть отсортирован по возрастанию id товара.
-- Поля в результирующей таблице: product_id, name

select
  product_id,
  name
from
  products
where
  name like 'с%' and not name like '% %'
order by
  product_id
  
-- Составьте SQL-запрос, который выбирает из таблицы products все чаи стоимостью больше 60 рублей и вычисляет для них цену со скидкой 25%.
-- Скидку в % менеджер попросил указать в отдельном столбце в формате текста, то есть вот так: «25%» (без кавычек). 
-- Столбцы со скидкой и новой ценой назовите соответственно discount и new_price.
-- Также необходимо любым известным способом избавиться от «чайного гриба»: вряд ли менеджер имел в виду и его, когда ставил нам задачу.
-- Результат должен быть отсортирован по возрастанию id товара.
-- Поля в результирующей таблице: product_id, name, price, discount, new_price

select
  product_id,
  name,
  price,
  '25%' as discount,
  price * 0.75 as new_price
from
  products
where
  name like '%чай%' and price >= '60' and not name like '%гриб%'
order by
  product_id

-- Из таблицы user_actions выведите всю информацию о действиях пользователей с id 170, 200 и 230 за период с 25 августа
-- по 4 сентября 2022 года включительно. Результат отсортируйте по убыванию id заказа — то есть от самых поздних действий
-- к самым первым. Поля в результирующей таблице: user_id, order_id, action, time
select
  user_id,
  order_id,
  action,
  time
from
  user_actions
where
  user_id in(170, 200, 230)
  and time between '2022-08-25' and '2022-09-05'
order by
  order_id desc

-- Определите id и даты рождения 50 самых молодых пользователей мужского пола из таблицы users.
-- Не учитывайте тех пользователей, у которых не указана дата рождения.
-- Поле в результирующей таблице: user_id, birth_date
select
  birth_date,
  user_id
from
  users
where
  birth_date is not null and sex = 'male'
order by
  birth_date desc
limit
  50
  
  -- Из таблицы user_actions получите id всех заказов, сделанных пользователями сервиса в августе 2022 года.
-- Результат отсортируйте по возрастанию id заказа.
-- Поле в результирующей таблице: order_id

select
  order_id
from
  user_actions
 where
  action = 'create_order' and date_part('month', time) = '08' and date_part('year', time) = '2022'
order by
  order_id
