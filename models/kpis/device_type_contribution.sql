select distinct

    device_type,
    round(sum(transaction_count) over (partition by device_type) /
        sum(transaction_count) over() * 100, 2) as device_type_transaction_percentage

from {{ ref('device_overview') }}

order by 1
