with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

customer_orders as (
    select
        c.customer_id,
        c.full_name,
        c.email,
        c.signup_date,
        count(o.order_id) as total_orders,
        sum(o.total_amount) as total_spent,
        min(o.order_date) as first_order_date,
        max(o.order_date) as last_order_date
    from customers c
    left join orders o
        on c.customer_id = o.customer_id
    group by 1, 2, 3, 4
)

select * from customer_orders 