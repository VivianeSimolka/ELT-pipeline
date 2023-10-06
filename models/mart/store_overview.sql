with

successful_transactions as (

    select * from {{ ref('stg_successful_transaction_detailed') }}

),

final as (

    select

        store_id,
        store_name,
        store_address,
        store_city,
        store_country,
        store_onboarding_timestamp,
        store_typology,
        customer_id,

        count(distinct device_id) as device_count,
        count(distinct transaction_id) as transaction_count,
        sum(coalesce(transaction_amount,0)) as transaction_amount,
        avg(transaction_amount) as avg_transacted_amount,
        min(transaction_timestamp) as first_transaction_timestamp,
        max(transaction_timestamp) as latest_transaction_timestamp

    from successful_transactions

    group by 1,2,3,4,5,6,7,8

)

select * from final
