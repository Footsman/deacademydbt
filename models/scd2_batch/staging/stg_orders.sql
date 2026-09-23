{{ config(materialized='view') }}

with source as (

    select * from {{ source('de_academy_raw', 'orders') }}

),

deduplicated as (

    select
        *,
        row_number() over (
            partition by order_id
            order by updated_at desc
        ) as row_num

    from source

)

select
    order_id,
    customer_name,
    customer_email,
    product_name,
    quantity,
    unit_price,
    order_total,
    status,
    shipping_address,
    created_at,
    updated_at,
    load_date

from deduplicated
where row_num = 1