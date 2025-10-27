# Imagen base
FROM node:20

# Crear directorio de trabajo
WORKDIR /usr/src/app

# Copiar e instalar dependencias backend
COPY package*.json ./
RUN npm install

# Copiar todo el proyecto
COPY . .

# Entrar al frontend, instalar y construir
WORKDIR /usr/src/app/react-src
RUN npm install
RUN npm run build

# Volver al backend
WORKDIR /usr/src/app

# Borrar carpeta public existente
RUN rm -rf public

# Crear carpeta public y mover la build allí
RUN mkdir public
RUN mv react-src/build/* public/

# Exponer backend
EXPOSE 5000

# Ejecutar en producción
CMD ["node", "server.js"]
