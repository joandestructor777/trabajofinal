# Proyecto Colaborativo - Gestión en la Nube (AWS + GitHub Actions + Docker)

> **Aplicación Web Desplegada en AWS con CI/CD y Containerización**  
> Proyecto desarrollado siguiendo metodología ágil con Kanban gestionado desde GitHub Projects.

---

## 🚀 Introducción

Este proyecto simula un entorno real de trabajo en el que se integra:
- **Despliegue en la nube (AWS EC2)**
- **Automatización CI/CD con GitHub Actions**
- **Containerización con Docker**
- **Gestión de proyecto colaborativo con GitHub Projects y Kanban**

Aunque en equipos reales esto se hace en grupo, en este caso **yo desarrollé todas las etapas del proyecto**, demostrando dominio de DevOps, despliegue, control de versiones, testing, gestión de ramas y containerización.

---

## 🎯 Objetivos del Proyecto

| Objetivo | Descripción |
|---------|-------------|
| Infraestructura en la nube | Configuración y despliegue en una instancia AWS EC2 |
| CI/CD Automatizado | GitHub Actions ejecutando builds, tests y despliegues automáticos |
| Containerización | Aplicación ejecutándose dentro de contenedores Docker |
| Gestión con Kanban | Proyecto estructurado por sprints en GitHub Projects |
| Documentación | Registro claro de procesos, decisiones y resultados |

---

## 🧑‍💻 Arquitectura

```
Usuario → Navegador → Servidor AWS EC2 → Docker Containers → Aplicación
```

**Componentes:**
- **Frontend:** HTML / CSS / JavaScript o React (dependiendo de la app seleccionada).
- **Backend:** Node.js + Express (en este caso).
- **Base de Datos:** MongoDB (local o Atlas).
- **DevOps Stack:** GitHub Actions + Docker + EC2.

---

## 🌐 Despliegue en AWS EC2 (Sprint 1)

### Requisitos Previos
- Cuenta AWS
- Instancia EC2 Ubuntu 22.04
- Clave `.pem` descargada

### Pasos Realizados

```bash
# Conectar a la instancia
ssh -i clave.pem ubuntu@IP_PUBLICA

# Actualizar paquetes
sudo apt update && sudo apt upgrade -y

# Instalar Node.js y Git
sudo apt install -y nodejs npm git

# Clonar el repositorio
git clone https://github.com/usuario/repositorio.git
cd repositorio

# Instalar dependencias
npm install

# Ejecutar la aplicación
npm start
```

### Configuración de Seguridad
- Se abrió el puerto **3000** y **80** en **Security Groups**.

---

## 🤖 Automatización CI/CD (Sprint 2)

Archivo `.github/workflows/deploy.yml`:

```yaml
name: Deploy to EC2

on:
  push:
    branches: ["main"]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Copy files to server
      uses: appleboy/scp-action@v0.1.4
      with:
        host: ${{ secrets.EC2_HOST }}
        username: ubuntu
        key: ${{ secrets.EC2_KEY }}
        source: "."
        target: "~/app"

    - name: Restart application (PM2)
      uses: appleboy/ssh-action@v0.1.10
      with:
        host: ${{ secrets.EC2_HOST }}
        username: ubuntu
        key: ${{ secrets.EC2_KEY }}
        script: |
          cd ~/app
          npm install
          pm2 restart all
```

---

## 📦 Containerización Docker (Sprint 3)

### Dockerfile

```Dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm","start"]
```

### Comandos utilizados

```bash
docker build -t nombre-app .
docker run -p 3000:3000 nombre-app
```

### Docker Hub (opcional)
```bash
docker login
docker tag nombre-app usuario/nombre-app
docker push usuario/nombre-app
```

---

## 🗂️ Gestión en GitHub Projects (Kanban)

Columnas usadas:

| Backlog | Ready | In Progress | Review | Done |
|--------|--------|-------------|--------|------|

Cada funcionalidad se manejó como **historia de usuario** con:
- Descripción clara
- Estimación en puntos
- Sprint asignado
- Criterios de aceptación

---

## 📊 Métricas del Proyecto

| Métrica | Resultado |
|--------|-----------|
| Historias completadas | 100% |
| Velocidad promedio | Estable |
| Bugs críticos | 0 |
| Tiempo de entrega | Dentro del cronograma |

---

## 💡 Lecciones Aprendidas

- La automatización evita errores manuales en despliegues.
- Docker facilita mover la app entre entornos sin configuraciones distintas.
- GitHub Projects ayuda a visualizar el progreso de manera clara.
- AWS requiere buena gestión de puertos y permisos para evitar fallos.

---

## 🧭 Instalación Local

```bash
git clone https://github.com/usuario/repositorio.git
cd repositorio
npm install
npm start
```

---

## ✅ Estado Final
- Aplicación funcional ✅
- Desplegada en AWS ✅
- CI/CD funcionando ✅
- Docker funcionando ✅
- Documentación completa ✅
jhfkjfhsjkfdjkfdsjfsdhfkjsdhfskjdfjsd
---

Hecho con dedicación, sudor, café y cero ganas de repetirlo. 💀🔥
