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



  ssh-keygen -t ed25519 -C "prakarnwongsanit@gmail.com"


docker build -t kamago .
docker images
  
docker tag kamago pnwt9565/kamago:latest

docker commit ea03be8b8d28 postgres:latest
docker commit 50f1a3509831 blog-web:latest

docker tag blog-web:latest pnwt9565/blog-web:latest
docker push pnwt9565/blog-web:latest

docker run -it --rm blog-web /bin/bash


docker pull pnwt9565/blog-web:latest

docker compose build

docker compose up

docker run -it --rm blog-web /bin/bash