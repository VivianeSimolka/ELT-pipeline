with

input as (

    select * from {{ ref('source_store') }}

),

final as (

    select
        id as store_id,
        name as store_name,
        address as store_address,
        city as store_city,
        country as store_country,
        cast(created_at as timestamp) as store_onboarding_timestamp,
        typology as store_typology,
        customer_id
    from input

)

select * from final
