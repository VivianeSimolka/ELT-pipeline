select

    store_typology,
    round(sum(coalesce(transaction_amount,0)) /
        sum(transaction_count),2) as avg_transaction_amount

from {{ ref('store_overview') }}

group by 1

order by 2 desc
