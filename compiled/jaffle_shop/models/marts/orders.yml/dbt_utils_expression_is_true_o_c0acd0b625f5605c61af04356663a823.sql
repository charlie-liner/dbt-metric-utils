



select
    1
from "jaffle_shop"."main"."orders"

where not(order_items_subtotal = subtotal)

