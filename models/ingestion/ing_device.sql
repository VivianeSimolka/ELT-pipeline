with

input as (

    select * from {{ ref('source_device') }}

),

final as (

    select
        id as device_id,
        type as device_type,
        store_id
    from input

)

select * from final
