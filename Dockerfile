# Imagen base
FROM node:20

# Crear directorio de trabajo
WORKDIR /usr/src/app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar dependencias backend
RUN npm install

# Copiar todo el backend
COPY . .

# Entrar al frontend y construirlo
WORKDIR /usr/src/app/react-src
RUN npm install
RUN npm run build

# Volver al backend
WORKDIR /usr/src/app

# Mover la build del frontend a la carpeta public o donde tu servidor la sirva
RUN rm -rf ./public
RUN mv react-src/build ./public

# Exponer el backend
EXPOSE 5000

# Comando para iniciar backend en producción
CMD ["node", "server.js"]
