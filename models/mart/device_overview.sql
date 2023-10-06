with

successful_transactions as (

    select * from {{ ref('stg_successful_transaction_detailed') }}

),

final as (

    select

        device_id,
        device_type,

        count(distinct transaction_id) as transaction_count,
        sum(coalesce(transaction_amount,0)) as transaction_amount

    from successful_transactions

    group by 1,2

)

select * from final
