SELECT * FROM (SELECT
  COALESCE(subq_4.metric_time__day, subq_11.metric_time__day, subq_18.metric_time__day, subq_25.metric_time__day) AS metric_time__day
  , MAX(subq_4.orders) AS orders
  , MAX(subq_4.order_total) AS order_total
  , MAX(subq_11.new_customer_orders) AS new_customer_orders
  , MAX(subq_18.food_orders) AS food_orders
  , MAX(subq_25.drink_orders) AS drink_orders
FROM (
  SELECT
    metric_time__day
    , SUM(order_count) AS orders
    , SUM(order_total) AS order_total
  FROM (
    SELECT
      DATE_TRUNC('day', ordered_at) AS metric_time__day
      , order_total
      , 1 AS order_count
    FROM "jaffle_shop"."main"."orders" orders_src_10000
  ) subq_2
  GROUP BY
    metric_time__day
) subq_4
FULL OUTER JOIN (
  SELECT
    metric_time__day
    , SUM(order_count) AS new_customer_orders
  FROM (
    SELECT
      DATE_TRUNC('day', ordered_at) AS metric_time__day
      , customer_order_number AS order_id__customer_order_number
      , 1 AS order_count
    FROM "jaffle_shop"."main"."orders" orders_src_10000
  ) subq_7
  WHERE order_id__customer_order_number = 1
  GROUP BY
    metric_time__day
) subq_11
ON
  subq_4.metric_time__day = subq_11.metric_time__day
FULL OUTER JOIN (
  SELECT
    metric_time__day
    , SUM(order_count) AS food_orders
  FROM (
    SELECT
      DATE_TRUNC('day', ordered_at) AS metric_time__day
      , is_food_order AS order_id__is_food_order
      , 1 AS order_count
    FROM "jaffle_shop"."main"."orders" orders_src_10000
  ) subq_14
  WHERE order_id__is_food_order = true
  GROUP BY
    metric_time__day
) subq_18
ON
  COALESCE(subq_4.metric_time__day, subq_11.metric_time__day) = subq_18.metric_time__day
FULL OUTER JOIN (
  SELECT
    metric_time__day
    , SUM(order_count) AS drink_orders
  FROM (
    SELECT
      DATE_TRUNC('day', ordered_at) AS metric_time__day
      , is_drink_order AS order_id__is_drink_order
      , 1 AS order_count
    FROM "jaffle_shop"."main"."orders" orders_src_10000
  ) subq_21
  WHERE order_id__is_drink_order = true
  GROUP BY
    metric_time__day
) subq_25
ON
  COALESCE(subq_4.metric_time__day, subq_11.metric_time__day, subq_18.metric_time__day) = subq_25.metric_time__day
GROUP BY
  COALESCE(subq_4.metric_time__day, subq_11.metric_time__day, subq_18.metric_time__day, subq_25.metric_time__day))