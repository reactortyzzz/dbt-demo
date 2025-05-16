{{ config(materialized='table') }}

with orders as (
    select * from {{ ref('stg_orders') }}
),

products as (
    select * from {{ source('dbt_demo', 'products') }}
),

daily_sales as (
    select
        date_trunc('day', order_date) as sale_date,
        p.category,
        count(distinct order_id) as number_of_orders,
        sum(quantity) as total_quantity,
        sum(total_amount) as total_revenue,
        avg(total_amount) as average_order_value
    from orders o
    join products p
        on o.product_id = p.product_id
    group by 1, 2
)

select * from daily_sales 