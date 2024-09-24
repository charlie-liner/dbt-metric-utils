



select
    1
from "jaffle_shop"."main"."stg_orders"

where not(order_total - tax_paid = subtotal)

