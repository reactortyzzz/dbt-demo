with source as (
    select * from {{ source('dbt_demo', 'customers') }}
),

renamed as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        signup_date,
        -- Add some basic transformations
        concat(first_name, ' ', last_name) as full_name,
        date_trunc('month', signup_date) as signup_month
    from source
)

select * from renamed 