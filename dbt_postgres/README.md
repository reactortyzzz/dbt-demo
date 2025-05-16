# DBT Demo Project

This is a dbt project that demonstrates data transformation patterns using a sample e-commerce dataset. The project includes staging, intermediate, and mart models to showcase different dbt features and best practices.

## Prerequisites

- Python 3.11 or higher
- PostgreSQL 16 or higher
- Git

## Project Structure

```
dbt_postgres/
├── models/
│   ├── staging/          # Initial data cleaning and standardization
│   │   ├── stg_customers.sql
│   │   └── stg_orders.sql
│   ├── intermediate/     # Business logic and transformations
│   │   └── int_customer_orders.sql
│   ├── marts/           # Final presentation layer
│   │   └── daily_sales.sql
│   ├── schema.yml       # Model documentation and tests
│   └── sources.yml      # Source table definitions
└── profiles.yml         # Database connection settings
```

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/dbt-demo.git
   cd dbt-demo
   ```

2. **Create and activate a virtual environment**
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install dbt-postgres
   ```

4. **Set up environment variables**
   Create a `.envrc` file in the project root:
   ```bash
   # Database connection
   export POSTGRES_HOST=your_host
   export POSTGRES_USER=your_user
   export POSTGRES_PASSWORD=your_password
   export POSTGRES_PORT=5432
   export POSTGRES_DBNAME=your_database
   export POSTGRES_SCHEMA=dbt_demo
   ```

   If you're using direnv:
   ```bash
   echo "dotenv .env" > .envrc
   direnv allow
   ```

5. **Initialize the database**
   Run the SQL script to create the sample data:
   ```bash
   psql -h $POSTGRES_HOST -U $POSTGRES_USER -d $POSTGRES_DBNAME -f postgres_queries/sample_data.sql
   ```

## Running the Project

1. **Test the connection**
   ```bash
   dbt debug
   ```

2. **Run the models**
   ```bash
   dbt run
   ```

3. **Run the tests**
   ```bash
   dbt test
   ```

4. **Generate documentation**
   ```bash
   dbt docs generate
   dbt docs serve
   ```

## Available Models

### Staging Models
- `stg_customers`: Basic customer data transformations
- `stg_orders`: Order data with calculated fields

### Intermediate Models
- `int_customer_orders`: Customer order history and metrics

### Mart Models
- `daily_sales`: Daily sales analysis by product category

## Testing

The project includes several types of tests:
- Unique and not_null tests on key columns
- Referential integrity tests
- Custom data tests

Run all tests with:
```bash
dbt test
```

## Documentation

The project includes:
- Model descriptions
- Column descriptions
- Data lineage
- Test coverage

View the documentation with:
```bash
dbt docs serve
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
