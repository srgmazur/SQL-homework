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

-- Примените DISTINCT сразу к двум колонкам таблицы courier_actions и отберите уникальные пары значений courier_id и order_id.
-- Результат отсортируйте сначала по возрастанию id курьера, затем по возрастанию id заказа.

select distinct
  courier_id,
  order_id
from
  courier_actions
order by
  courier_id,
  order_id

-- Посчитайте максимальную и минимальную цены товаров в таблице products. Поля назовите соответственно max_price, min_price.
-- Поля в результирующей таблице: max_price, min_price
select
  max(price) as max_price,
  min(price) as min_price
from
  products

-- Как вы помните, в таблице users у некоторых пользователей не были указаны их даты рождения.
-- Посчитайте в одном запросе количество всех записей в таблице и количество только тех записей, для которых в колонке birth_date указана дата рождения.
-- Колонку с общим числом записей назовите dates, а колонку с записями без пропусков — dates_not_null.

select
  count(birth_date) as dates_not_null,
  count(*) as dates
from
  users

-- Посчитайте количество всех значений в колонке user_id в таблице user_actions, а также количество уникальных значений в этой колонке (т.е. количество уникальных пользователей сервиса).
-- Колонку с первым полученным значением назовите users, а колонку со вторым — unique_users.

select
  count(user_id) as users,
  count(DISTINCT user_id) as unique_users
from
  user_actions

-- Посчитайте количество курьеров женского пола в таблице couriers. Полученный столбец с одним значением назовите couriers.
select
  count(DISTINCT courier_id) as couriers
from
  couriers
where
  sex = 'female'

-- Рассчитайте время, когда были совершены первая и последняя доставки заказов в таблице courier_actions.
-- Колонку с временем первой доставки назовите first_delivery, а колонку с временем последней — last_delivery.
-- Поля в результирующей таблице: first_delivery, last_delivery

select
  min(time) as first_delivery,
  max(time) as last_delivery
from
  courier_actions
where
  action = 'deliver_order'

-- Представьте, что один из пользователей сервиса сделал заказ, в который вошли одна пачка сухариков, одна пачка чипсов и один энергетический напиток. Посчитайте стоимость такого заказа.
-- Колонку с рассчитанной стоимостью заказа назовите order_price.
-- Для расчётов используйте таблицу products.
-- Поле в результирующей таблице: order_price

select
  sum(price) as order_price
from
  products
where
  name = 'сухарики' OR name= 'чипсы' OR name = 'энергетический напиток'

-- Посчитайте количество заказов в таблице orders с девятью и более товарами. Для этого воспользуйтесь функцией array_length,
-- отфильтруйте данные по количеству товаров в заказе и проведите агрегацию. Полученный столбец назовите orders.

Поле в результирующей таблице: orders
select
  count (order_id) as orders
from
  orders
where
  array_length (product_ids, 1) >= 9

-- С помощью функции AGE и агрегирующей функции рассчитайте возраст самого молодого курьера мужского пола в таблице couriers.
-- Возраст выразите количеством лет, месяцев и дней (как в примере выше), переведя его в тип VARCHAR. 
-- В качестве даты, относительно которой считать возраст курьеров, используйте свою текущую дату (либо не указывайте её на месте первого аргумента,
-- как показано в примерах).
-- Полученную колонку со значением возраста назовите min_age.
-- Поле в результирующей таблице: min_age

select
    min(age(current_date, birth_date))::VARCHAR as min_age
from
    couriers
where
    sex = 'male'

-- Посчитайте стоимость заказа, в котором будут три пачки сухариков, две пачки чипсов и один энергетический напиток.
-- Колонку с рассчитанной стоимостью заказа назовите order_price.
-- Для расчётов используйте таблицу products.
-- Поле в результирующей таблице: order_price

select
    sum(
        CASE 
        WHEN name='сухарки' THEN price*3
        WHEN name='чипсы' THEN price*2
        WHEN name='энергетический напиток' THEN price
        END
    ) as order_price
from
    products

    -- Посчитайте стоимость заказа, в котором будут три пачки сухариков, две пачки чипсов и один энергетический напиток.
-- Колонку с рассчитанной стоимостью заказа назовите order_price.
-- Для расчётов используйте таблицу products.
-- Поле в результирующей таблице: order_price

select
    sum(
        CASE 
        WHEN name='сухарики' THEN price * 3
        WHEN name='чипсы' THEN price * 2
        WHEN name='энергетический напиток' THEN price
        else 0
        END
    ) as order_price
from
    products

-- Рассчитайте среднюю цену товаров в таблице products, в названиях которых присутствуют слова «чай» или «кофе».
-- Любым известным способом исключите из расчёта товары содержащие «иван-чай» или «чайный гриб».
-- Среднюю цену округлите до двух знаков после запятой. Столбец с полученным значением назовите avg_price.
-- Поле в результирующей таблице: avg_price

select
    round(avg(
        CASE 
        WHEN name like '%чай%' and not name like '%гриб%' and not name like '%иван-чай%' then price
        when name like '%кофе%' THEN price
        else null
        END
    ), 2) as avg_price
from
    products

-- Воспользуйтесь функцией AGE и рассчитайте разницу в возрасте между самым старым и самым молодым пользователями мужского пола в таблице users. 
-- Разницу в возрасте выразите количеством лет, месяцев и дней, переведя её в тип VARCHAR. 
-- Колонку с посчитанным значением назовите age_diff.
-- Поле в результирующей таблице: age_diff

select
   age(max(birth_date), min(birth_date))::VARCHAR as age_diff
from
    users
where
    sex = 'male'

-- Рассчитайте среднее количество товаров в заказах из таблицы orders, которые пользователи оформляли по выходным дням 
-- (суббота и воскресенье) в течение всего времени работы сервиса.
-- Полученное значение округлите до двух знаков после запятой. Колонку с ним назовите avg_order_size.
-- Поле в результирующей таблице: avg_order_size

select
   round(avg(array_length(product_ids, 1)), 2) as avg_order_size
from
    orders
where
    DATE_PART('dow', creation_time) = 6 OR DATE_PART('dow', creation_time) = 0

-- На основе данных в таблице user_actions посчитайте количество уникальных пользователей сервиса, количество уникальных заказов, 
-- поделите одно на другое и выясните, сколько заказов приходится на одного пользователя.
-- В результирующей таблице отразите все три значения — поля назовите соответственно unique_users, unique_orders, orders_per_user.
-- Показатель числа заказов на пользователя округлите до двух знаков после запятой.
-- Поля в результирующей таблице: unique_users, unique_orders, orders_per_user

select
   count(DISTINCT user_id) as unique_users,
   count(DISTINCT order_id) as unique_orders,
   round((count(DISTINCT order_id)::decimal / count(DISTINCT user_id)), 2) as orders_per_user
from
    user_actions

-- Посчитайте, сколько пользователей никогда не отменяли свой заказ. Для этого из общего числа всех уникальных пользователей 
-- отнимите число уникальных пользователей, которые хотя бы раз отменяли заказ. Подумайте, какое условие необходимо указать в FILTER, 
-- чтобы получить корректный результат.
-- Полученный столбец назовите users_count.
-- Поле в результирующе таблице: users_count

select
   (count(distinct user_id) - (count(distinct user_id) filter (where action = 'cancel_order'))) as users_count
from
    user_actions

-- Посчитайте общее количество заказов в таблице orders, количество заказов с пятью и более товарами и найдите долю заказов с пятью и более товарами
-- в общем количестве заказов. В результирующей таблице отразите все три значения — поля назовите
-- соответственно orders, large_orders, large_orders_share.
-- Долю заказов с пятью и более товарами в общем количестве товаров округлите до двух знаков после запятой.
-- Поля в результирующей таблице: orders, large_orders, large_orders_share
-- При расчёте доли не забудьте хотя бы одно из значений предварительно привести к типу DECIMAL.
-- Также помните, что использовать в расчётах алиасы новых колонок нельзя.

select
   count(order_id) as orders,
   count(order_id) filter (where array_length(product_ids, 1) >= 5) as large_orders,
   round((count(order_id) filter (where array_length(product_ids, 1) >= 5))::decimal / (count(order_id)), 2) as large_orders_share
from
    orders