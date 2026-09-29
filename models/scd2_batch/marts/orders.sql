{{ config(materialized='table') }}

select
    order_id,
    customer_name,
    customer_email,
    product_name,
    quantity,
    unit_price,
    order_total,
    round(quantity * unit_price, 2) as calculated_order_total,
    case
        when order_total != round(quantity * unit_price, 2) then true
        else false
    end as order_total_mismatch,
    status,
    shipping_address,
    created_at,
    updated_at,
    load_date

from {{ ref('stg_orders') }}