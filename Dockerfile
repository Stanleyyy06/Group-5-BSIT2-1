version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    container_name: netad_postgres
    environment:
      POSTGRES_DB: netad_db
      POSTGRES_USER: netad_user
      POSTGRES_PASSWORD: netad_password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U netad_user"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - netad-network

  app:
    build: .
    container_name: netad_app
    ports:
      - "5000:5000"
    environment:
      DATABASE_URL: postgresql://netad_user:netad_password@postgres:5432/netad_db
      FLASK_ENV: development
      SECRET_KEY: dev-secret-key-12345
      ADMIN_USERNAME: admin
      ADMIN_PASSWORD: Admin@12345
      CAMERA_MODE: public
    depends_on:
      postgres:
        condition: service_healthy
    volumes:
      - .:/app
    networks:
      - netad-network
    command: python app.py

volumes:
  postgres_data:

networks:
  netad-network:
    driver: bridge
