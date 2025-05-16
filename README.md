# Demo Project

This repository contains a demo project showcasing data engineering practices using dbt and PostgreSQL.

## Project Structure

```
demo-project/
├── dbt_postgres/           # dbt project directory
│   ├── models/            # dbt models
│   ├── profiles.yml       # dbt connection settings
│   └── dbt_project.yml    # dbt project configuration
├── postgres_queries/      # SQL scripts
│   └── sample_data.sql    # Sample data creation script
├── .envrc                 # direnv configuration
└── .python-version        # Python version specification
```

## Prerequisites

- Python 3.11 or higher
- PostgreSQL 16 or higher
- Git
- direnv (recommended for environment management)
- uv (Python package installer)

## Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/demo-project.git
   cd demo-project
   ```

2. **Set up Python environment and install dependencies**
   ```bash
   uv venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   uv pip install dbt-postgres
   ```

3. **Configure environment variables**
   Create a `.env` file in the project root:
   ```bash
   # Database connection
   POSTGRES_HOST=your_host
   POSTGRES_USER=your_user
   POSTGRES_PASSWORD=your_password
   POSTGRES_PORT=5432
   POSTGRES_DBNAME=your_database
   POSTGRES_SCHEMA=dbt_demo
   ```

   If using direnv:
   ```bash
   echo "dotenv .env" > .envrc
   direnv allow
   ```

4. **Initialize the database**
   ```bash
   psql -h $POSTGRES_HOST -U $POSTGRES_USER -d $POSTGRES_DBNAME -f postgres_queries/sample_data.sql
   ```

## Development

- The `dbt_postgres` directory contains the dbt project
- SQL scripts are in the `postgres_queries` directory
- Environment variables are managed through `.env` and `.envrc`
- Package management is handled by `uv` for faster installations

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License.
