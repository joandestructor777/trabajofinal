# Imagen base
FROM node:20

# Crear directorio de trabajo backend
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

# Reemplazar carpeta public con la compilación del frontend (Vite usa dist)
RUN rm -rf public
RUN mkdir public
RUN cp -r react-src/dist/* public/

# Exponer backend
EXPOSE 5000

# Ejecutar backend
CMD ["node", "server.js"]
