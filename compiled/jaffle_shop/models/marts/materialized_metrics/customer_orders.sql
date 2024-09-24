SELECT * FROM (SELECT
  COALESCE(subq_4.customer, subq_10.customer) AS customer
  , MAX(subq_4.count_lifetime_orders) AS count_lifetime_orders
  , MAX(subq_4.lifetime_spend_pretax) AS lifetime_spend_pretax
  , MAX(subq_10.average_order_value) AS average_order_value
FROM (
  SELECT
    customer_id AS customer
    , SUM(count_lifetime_orders) AS count_lifetime_orders
    , SUM(lifetime_spend_pretax) AS lifetime_spend_pretax
  FROM "jaffle_shop"."main"."customers" customers_src_10000
  GROUP BY
    customer_id
) subq_4
FULL OUTER JOIN (
  SELECT
    customer
    , lifetime_spend_pretax / count_lifetime_orders AS average_order_value
  FROM (
    SELECT
      customer_id AS customer
      , SUM(count_lifetime_orders) AS count_lifetime_orders
      , SUM(lifetime_spend_pretax) AS lifetime_spend_pretax
    FROM "jaffle_shop"."main"."customers" customers_src_10000
    GROUP BY
      customer_id
  ) subq_9
) subq_10
ON
  subq_4.customer = subq_10.customer
GROUP BY
  COALESCE(subq_4.customer, subq_10.customer))