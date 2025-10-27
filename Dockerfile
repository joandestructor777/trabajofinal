# Imagen base
FROM node:20

# Crear directorio de trabajo
WORKDIR /usr/src/app

# Instalar nodemon globalmente (solo si es desarrollo)
RUN npm install -g nodemon

# Copiar package.json y package-lock.json del backend
COPY package*.json ./

# Instalar dependencias del backend
RUN npm install

# Copiar la carpeta del frontend
COPY react-src ./react-src

# Instalar dependencias del frontend
WORKDIR /usr/src/app/react-src
RUN npm install

# Volver al directorio raíz del backend
WORKDIR /usr/src/app

# Copiar todo lo demás
COPY . .

# Exponer el puerto del backend
EXPOSE 5000

# Comando para levantar backend con nodemon (desarrollo)
CMD ["node", "server.js"]
