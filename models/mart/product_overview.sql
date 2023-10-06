with

successful_transactions as (

    select * from {{ ref('stg_successful_transaction_detailed') }}

),

product_transactions as (

    select distinct

        product_sku,
        first_value(product_name) over                                          --prevent duplicates in the event of SKU or category name change
            (partition by product_sku
            order by transaction_timestamp desc) as product_name,
        first_value(category_name) over
            (partition by product_sku
            order by transaction_timestamp desc) as category_name,
        transaction_id,
        transaction_amount

    from successful_transactions
),

final as (

    select distinct

        product_sku,
        product_name,
        category_name,

        count(distinct transaction_id) as transaction_count,
        sum(coalesce(transaction_amount,0)) as transaction_amount

    from product_transactions

    group by 1,2,3

)

select * from final
