 # list all docker process system.
 docker ps

docker compose exec web rails db:drop

docker compose down -v
docker compose up

production:
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV.fetch("POSTGRES_USER") { "postgres" } %>
  password: <%= ENV.fetch("POSTGRES_PASSWORD") { "password" } %>
  host: <%= ENV.fetch("DB_HOST") { "db" } %>   # "db" is the Docker service name
  port: <%= ENV.fetch("DB_PORT") { 5432 } %>
  database: myapp_production