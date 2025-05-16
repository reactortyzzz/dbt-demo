with source as (
    select * from {{ source('dbt_demo', 'orders') }}
),

renamed as (
    select
        order_id,
        order_date,
        customer_id,
        employee_id,
        product_id,
        quantity,
        -- Calculate total amount if not already in the table
        quantity * (
            select price 
            from {{ source('dbt_demo', 'products') }} 
            where product_id = source.product_id
        ) as total_amount,
        -- Add some useful date fields
        date_trunc('day', order_date) as order_day,
        date_trunc('month', order_date) as order_month
    from source
)

select * from renamed 