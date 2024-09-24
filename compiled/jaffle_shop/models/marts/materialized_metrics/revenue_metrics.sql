SELECT * FROM (SELECT
  metric_time__day
  , SUM(revenue) AS revenue
  , SUM(food_revenue) AS food_revenue
  , SUM(drink_revenue) AS drink_revenue
FROM (
  SELECT
    DATE_TRUNC('day', ordered_at) AS metric_time__day
    , product_price AS revenue
    , case when is_food_item is true then product_price else 0 end AS food_revenue
    , case when is_drink_item is true then product_price else 0 end AS drink_revenue
  FROM "jaffle_shop"."main"."order_items" order_item_src_10000
) subq_2
GROUP BY
  metric_time__day)