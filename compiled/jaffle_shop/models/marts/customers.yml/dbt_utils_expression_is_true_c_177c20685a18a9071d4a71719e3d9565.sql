



select
    1
from "jaffle_shop"."main"."customers"

where not(lifetime_spend_pretax + lifetime_tax_paid = lifetime_spend)

