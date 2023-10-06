with

input as (

    select * from {{ ref('source_transaction') }}

),

final as (

    select
        id as transaction_id,
        device_id,
        product_name,
        product_sku,
        category_name,
        amount as transaction_amount,
        status as transaction_status,
        card_number,
        cvv,
        cast(created_at as timestamp) as transaction_timestamp
    from input

)

select * from final
