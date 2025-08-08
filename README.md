# Bookstars Django Project

A Django web application with PostgreSQL database, containerized with Docker.

## Prerequisites

- Docker
- Docker Compose

## Setup and Running

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd bookstars
   ```

2. Create a `.env` file from the example:
   ```bash
   cp .env.example .env
   ```

3. Update the `.env` file with your desired configuration (optional, the defaults will work for development).

4. Build and run the application:
   ```bash
   docker-compose up --build
   ```

5. The application will be available at: http://localhost:8000

## Development

### Running Commands Inside the Container

To run Django management commands:

```bash
# Run migrations
docker-compose exec web python manage.py migrate

# Create superuser
docker-compose exec web python manage.py createsuperuser

# Collect static files
docker-compose exec web python manage.py collectstatic

# Access Django shell
docker-compose exec web python manage.py shell
```

### Database Access

To access the PostgreSQL database directly:

```bash
docker-compose exec db psql -U bookstars_user -d bookstars_db
```

### Viewing Logs

```bash
# View all logs
docker-compose logs

# View specific service logs
docker-compose logs web
docker-compose logs db

# Follow logs in real-time
docker-compose logs -f
```

## Project Structure

```
bookstars/
├── bookstars/              # Django project directory
│   ├── __init__.py
│   ├── asgi.py
│   ├── settings.py         # Django settings (configured for Docker)
│   ├── urls.py
│   └── wsgi.py
├── manage.py              # Django management script
├── requirements.txt       # Python dependencies
├── Dockerfile            # Docker configuration
├── docker-compose.yml    # Docker Compose configuration
├── .env.example          # Environment variables template
├── .gitignore           # Git ignore file
└── README.md            # This file
```

## Environment Variables

The following environment variables can be configured in the `.env` file:

- `SECRET_KEY`: Django secret key
- `DEBUG`: Debug mode (True/False)
- `ALLOWED_HOSTS`: Comma-separated list of allowed hosts
- `DB_NAME`: PostgreSQL database name
- `DB_USER`: PostgreSQL username
- `DB_PASSWORD`: PostgreSQL password
- `DB_HOST`: PostgreSQL host (use 'db' for Docker)
- `DB_PORT`: PostgreSQL port

## Stopping the Application

```bash
docker-compose down
```

To also remove volumes (this will delete the database data):
```bash
docker-compose down -v
```

## Production Deployment

For production deployment:

1. Set `DEBUG=False` in your `.env` file
2. Use a strong `SECRET_KEY`
3. Configure appropriate `ALLOWED_HOSTS`
4. Use environment-specific database credentials
5. Consider using a reverse proxy like Nginx
6. Set up proper logging and monitoring
