select

    store_id,
    store_name,
    transaction_amount

from {{ ref('store_overview') }}

order by
    transaction_amount desc,
    transaction_count desc                                                      --in case of tied result

limit 10
