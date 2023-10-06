with

stores as (

    select * from {{ ref('ing_store') }}

),

devices as (

    select * from {{ ref('ing_device') }}

),

transactions as (

    select * from {{ ref('ing_transaction') }}

),

transaction_store_device_joined as (

    select

        transactions.transaction_id,
        transactions.product_name,
        transactions.product_sku,
        transactions.category_name,
        transactions.transaction_amount,
        transactions.transaction_status,
        transactions.card_number,
        transactions.cvv,
        transactions.transaction_timestamp,

        stores.store_id,
        stores.store_name,
        stores.store_address,
        stores.store_city,
        stores.store_country,
        stores.store_onboarding_timestamp,
        stores.store_typology,
        stores.customer_id,

        devices.device_id,
        devices.device_type

    from stores

    left join devices
        on stores.store_id = devices.store_id

    left join transactions
        on devices.device_id = transactions.device_id

    where
        transaction_id is not null
        and transaction_status = 'accepted'

),

final as (

    select
        transaction_id,
        product_name,
        product_sku,
        category_name,
        transaction_amount,
        card_number,
        cvv,
        transaction_timestamp,

        rank() over (partition by store_id
            order by transaction_timestamp) as store_transaction_number,

        datediff(day,
            store_onboarding_timestamp,
            transaction_timestamp) as days_since_store_onboarding,

        store_id,
        store_name,
        store_address,
        store_city,
        store_country,
        store_onboarding_timestamp,
        store_typology,
        customer_id,

        device_id,
        device_type

    from transaction_store_device_joined

)

select * from final
