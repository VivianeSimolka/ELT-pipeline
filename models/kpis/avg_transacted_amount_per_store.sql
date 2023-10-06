select

    store_id,
    store_name,
    round(avg_transacted_amount, 2) as avg_transacted_amount

from {{ ref('store_overview') }}

order by 3 desc
