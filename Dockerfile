FROM node:20

# Crear carpeta de app
WORKDIR /usr/src/app

# Copiar los package.json
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar todo el proyecto
COPY . .

# Exponer el puerto de tu backend
EXPOSE 5000

# Ejecutar la app
CMD ["node", "server.js"]
