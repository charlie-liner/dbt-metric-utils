



select
    1
from "jaffle_shop"."main"."orders"

where not(order_total = subtotal + tax_paid)

