
# Usa una imagen base de Ruby
FROM ruby:3.0.0

# Instala las dependencias del sistema necesarias
RUN apt-get update -qq && apt-get install -y nodejs yarn

# Configura el directorio de trabajo
WORKDIR /app

# Copia el Gemfile y Gemfile.lock para instalar las gemas
COPY Gemfile Gemfile.lock ./

# Instala las gemas
RUN bundle install

# Copia el resto de la aplicación
COPY . .

# Precompila los assets si es necesario (solo en producción)
# RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expone el puerto que usará la aplicación
EXPOSE 3000

# Comando para iniciar la aplicación
CMD ["bash", "-c", "rails db:migrate && rails server -b 0.0.0.0"]
