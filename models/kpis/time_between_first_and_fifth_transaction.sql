with

successful_transactions as (

    select * from {{ ref('stg_successful_transaction_detailed') }}

),

first_and_fifth_transactions as (

    select
        store_id,
        min(iff(store_transaction_number=1, transaction_timestamp, null)) as first_transaction_timestamp,
        min(iff(store_transaction_number=5, transaction_timestamp, null)) as fifth_transaction_timestamp
    from successful_transactions
    group by 1

),

final as (

    select
        round(avg(datediff(
            day,
            first_transaction_timestamp,
            fifth_transaction_timestamp))) as days_from_first_to_fifth
    from first_and_fifth_transactions

)

select * from final
