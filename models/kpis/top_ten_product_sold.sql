select

    product_sku,
    product_name,
    transaction_count

from {{ ref('product_overview') }}

order by
    transaction_count desc,
    transaction_amount desc                                                     --in case of tied result

limit 10
