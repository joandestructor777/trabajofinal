# Proyecto Colaborativo: Gestión en la Nube (AWS EC2 + GitHub Actions + Docker)

> ¡Tranquilo, ya casi! Aquí tienes un README completito, hecho como tú lo pediste: directo, práctico y con TODOS los pasos para que el profe vea evidencia real. Está en español "de calle" pero claro y profesional. Copia/pega, sube, prueba y si quieres lo adaptamos a tu app.

---

## 📌 Índice

1. Introducción
2. Equipo y Roles
3. Descripción del Proyecto
4. Estructura del Repositorio
5. Configuración del GitHub Project (Kanban)
6. Historias de Usuario (Plantillas y ejemplo)
7. Estrategia de Branching y Flujo de Trabajo
8. Sprint 1: Infraestructura (AWS EC2) — Paso a paso
9. Sprint 2: Automatización (GitHub Actions) — CI/CD y automatizaciones
10. Sprint 3: Containerización (Docker) — Dockerfile y docker-compose
11. Comandos útiles y checklist de despliegue
12. Posibles errores comunes y soluciones (debug rápido)
13. Métricas y reportes (cómo calcular y documentar)
14. Documentación final y evidencias
15. Presentación (guion para 20 minutos)
16. Lecciones aprendidas y mejoras futuras
17. Enlaces útiles y referencias

---

## 1. Introducción

Este repositorio es la entrega final del **Proyecto 1 — Computación en la nube**. Integra las tres actividades previas (AWS EC2, GitHub Actions y Docker) en un simulacro de proyecto profesional usando Kanban en GitHub Projects.

El README aquí explica TODO: cómo configurar, desplegar, automatizar, medir y presentar. Si algo suena raro, lo ajustamos.

---

## 2. Equipo y Roles

* **Product Owner / Líder de Proyecto:** [Nombre]
* **Frontend:** [Nombre]
* **Backend:** [Nombre]
* **DevOps / Infra:** [Nombre]
* **QA (opcional):** [Nombre]

> Consejo: dejan los roles en el README y en el GitHub Project (campo "Responsable"). Así queda claro quién hace qué.

---

## 3. Descripción del Proyecto

**Nombre del proyecto:** proyecto-colaborativo

**Qué hace:** Aplicación web (e.g., CRUD, blog, tienda simple) que se despliega en AWS EC2, tiene pipelines en GitHub Actions y se entrega en containers con Docker.

**Stack sugerido (puedes adaptar):**

* Frontend: React (Vite o Create React App)
* Backend: Node.js + Express
* DB: MongoDB (local o Atlas) o Postgres
* Infra: AWS EC2 (t2.micro o t3a.micro para pruebas)
* CI/CD: GitHub Actions
* Containerización: Docker

---

## 4. Estructura del Repositorio

```
proyecto-colaborativo/
├── .github/
│   ├── workflows/            # GitHub Actions
│   └── ISSUE_TEMPLATE/
├── docs/
├── src/
│   ├── backend/
│   └── frontend/
├── Dockerfile
├── docker-compose.yml
├── README.md
└── CONTRIBUTING.md
```

En `src/` pongan una app mínima: un `backend` que responda `GET /` con "OK" y un `frontend` que consuma eso. Lo básico para la demo.

---

## 5. Configuración del GitHub Project (Kanban)

1. Crear repo nuevo en GitHub: `proyecto-colaborativo` → Settings → Manage access → invitar a los miembros.

2. Ir a **Projects** → New Project → elegir **Board (Kanban)**.

3. Crear columnas (cards):

   * `📋 Backlog`
   * `🚀 Ready`
   * `👥 In Progress`
   * `🔍 Review`
   * `✅ Done`

4. Campos personalizados (Project settings → Fields):

   * `Sprint` (Sprint 1, Sprint 2, Sprint 3)
   * `Responsable` (@username)
   * `Prioridad` (Alta / Media / Baja)
   * `Estimación` (1,2,3,5,8)
   * `Tipo` (Feature / Bug / Documentation / DevOps)

5. Crear plantillas de Issue para historias de usuario: `.github/ISSUE_TEMPLATE/user_story.md` (ver plantilla abajo).

---

## 6. Historias de Usuario (Plantilla + Ejemplos)

### Plantilla (`.github/ISSUE_TEMPLATE/user_story.md`)

```markdown
# Historia de Usuario: [Título]

## Como [tipo de usuario]
Quiero [funcionalidad]
Para [beneficio/valor]

## Criterios de Aceptación:
- [ ] Criterio 1
- [ ] Criterio 2
- [ ] Criterio 3

## Estimación: [puntos]
## Sprint: [1|2|3]
## Responsable: @[username]
```

### Ejemplo (Sprint 1)

```
# Historia de Usuario: Desplegar servidor en EC2

## Como DevOps
Quiero lanzar una instancia EC2 y servir la API
Para que la app sea accesible desde internet

## Criterios de Aceptación:
- [ ] EC2 con puerto 80/3000 accesible
- [ ] Seguridad (grupo de seguridad) configurado
- [ ] README con pasos y comandos

## Estimación: 5
## Sprint: 1
## Responsable: @devops
```

> Recuerda: cada miembro debe crear mínimo 6 historias (2 por sprint). Pongan la URL del issue en el Project card.

---

## 7. Estrategia de Branching y Flujo de Trabajo

Ramas principales:

```
main
└── development
    ├── feature/sprint1-[func]
    ├── feature/sprint2-[func]
    └── feature/sprint3-[func]
```

Flujo:

1. Crear rama `feature/...` desde `development`.
2. Hacer commits claros (`feat: ...`, `fix: ...`).
3. Abrir PR contra `development`.
4. Review (1 reviewer mínimo) → merge si pasa tests.
5. Al terminar sprint, crear `release/vX` y luego merge a `main`.

### Nombres de ramas sugeridos

* `sprint1-infrastructure`
* `sprint2-automation`
* `sprint3-containerization`

---

## 8. Sprint 1 — Infraestructura (AWS EC2)

### Objetivo

Levantar una instancia EC2, instalar Node.js / Nginx (o servir con PM2) y desplegar la app.

### 1) Crear instancia EC2

* AWS Console → EC2 → Launch Instance

  * Amazon Linux 2 / Ubuntu 22.04
  * Tipo: `t2.micro` (o `t3a.micro` si está disponible)
  * Key pair: crear o subir `.pem` (guardar seguro)
  * Security Group: abrir puertos `22`, `80`, `443` (si usas HTTPS), y `3000` (si tu app sirve en 3000)

### 2) Conectar por SSH (Windows PowerShell o WSL / Linux / Mac)

```bash
chmod 400 key_uno.pem
ssh -i "key_uno.pem" ubuntu@<EC2_PUBLIC_IP>
```

Si usas Windows PowerShell y falla: usa `ssh -i .\key_uno.pem ubuntu@IP`.

### 3) Actualizar y preparar servidor

```bash
sudo apt update && sudo apt upgrade -y
# instalar node y npm
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs build-essential
# instalar pm2 para producción
sudo npm install -g pm2
```

### 4) Clonar repo y levantar app

```bash
git clone https://github.com/<org>/proyecto-colaborativo.git
cd proyecto-colaborativo/src/backend
npm install
# configurar env: crear .env con variables (PORT, DB_URI, etc.)
pm run build # si aplica
pm start # o pm2 start ./dist/index.js --name proyecto-api
```

O usar `pm2` para mantener proceso:

```bash
pm install
pm run start:prod # si tu package.json tiene script
pm2 start npm --name "api" -- start
pm2 save
```

### 5) Servir frontend (opcional) con Nginx

```bash
sudo apt-get install nginx -y
# copiar build del frontend a /var/www/html
sudo mv build/* /var/www/html/
sudo systemctl restart nginx
```

### Errores comunes Sprint 1 y soluciones

* *SSH: Permission denied (publickey)* → revisa que usas la key correcta y permisos `chmod 400`.
* *EC2 inaccesible* → Revisa Security Group y IP pública; comprueba que el puerto esté abierto.
* *Node no instalado* → revisa `node -v`; si no, reinstala con NodeSource.
* *App 502/Bad Gateway en Nginx* → Revisa que backend esté corriendo en el puerto configurado y que Nginx proxy_pass apunte al puerto correcto.

---

## 9. Sprint 2 — Automatización (GitHub Actions)

### Objetivo

Configurar CI que corra tests en cada PR, badges de estado y automatización para mover cards del Project.

### 1) CI básico (tests) — archivo: `.github/workflows/ci.yml`

```yaml
name: CI
on:
  pull_request:
    branches: [ development ]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Node
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      - name: Install dependencies (backend)
        run: |
          cd src/backend
          npm ci
      - name: Run tests (backend)
        run: |
          cd src/backend
          npm test
```

> Asegúrense de tener tests básicos (Jest/Mocha) aunque sea un test que verifique `GET /` responde 200.

### 2) Deployment workflow (push a main)

`.github/workflows/deploy.yml`

```yaml
name: Deploy to EC2
on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Sync files to EC2
        uses: appleboy/scp-action@v0.1.4
        with:
          host: ${{ secrets.EC2_HOST }}
          username: ubuntu
          key: ${{ secrets.EC2_KEY }}
          source: "src/*"
          target: "/home/ubuntu/proyecto"
      - name: Run remote deploy commands
        uses: appleboy/ssh-action@v0.1.7
        with:
          host: ${{ secrets.EC2_HOST }}
          username: ubuntu
          key: ${{ secrets.EC2_KEY }}
          script: |
            cd /home/ubuntu/proyecto/backend
            npm ci
            pm2 restart all
```

> **IMPORTANTE:** Guardar en GitHub Secrets `EC2_HOST` (IP), `EC2_KEY` (contenido de la `.pem`), y otros secretos (DB URI, API KEYS).

### 3) Project Automation (mover cards)

Usar la API de GitHub o Actions preconstruidas. Ejemplo simple para mover a `In Progress` cuando un issue es assigned:

`.github/workflows/project-automation.yml`

```yaml
name: Project Automation
on:
  issues:
    types: [assigned]
  pull_request:
    types: [opened, closed]

jobs:
  move-cards:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Move cards
        uses: peter-evans/projects-automation@v1
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          # config para mover cards según evento (leer docs del action)
```

> Si no quieren complicarse, usen `actions-ecosystem/action-...` o scripts con la API de GitHub.

---

## 10. Sprint 3 — Containerización (Docker)

### Dockerfile (Backend simple)

```dockerfile
# base
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --production
COPY . .
EXPOSE 3000
CMD [ "node", "dist/index.js" ]
```

### Dockerfile (Frontend - build)

```dockerfile
FROM node:18-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### docker-compose.yml

```yaml
version: '3.8'
services:
  backend:
    build: ./src/backend
    ports:
      - '3000:3000'
    environment:
      - NODE_ENV=production
  frontend:
    build: ./src/frontend
    ports:
      - '80:80'
```

### Optimización de imágenes

* Usar multi-stage builds para reducir tamaño.
* Ignorar `node_modules` en la copia con `.dockerignore`.

### Publicar en Docker Hub (opcional)

```bash
docker build -t usuario/proyecto-backend:latest ./src/backend
docker push usuario/proyecto-backend:latest
```

### Despliegue con Docker en EC2

1. Instalar Docker en la EC2 (Ubuntu):

```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker ubuntu
```

2. Usar `docker-compose up -d` en la EC2 para levantar servicios.

---

## 11. Comandos útiles y checklist de despliegue

### Comandos git básicos

```bash
# crear ramas
git checkout -b feature/sprint1-infra development
# push
git push origin feature/sprint1-infra
# PR desde GitHub UI o gh cli
```

### Checklist rápido antes de la entrega

* [ ] Todos los miembros tienen commits en el repo.
* [ ] Mínimo 6 historias por persona (links en project).
* [ ] CI corre en cada PR y tests pasan.
* [ ] App corriendo en EC2 y accesible.
* [ ] Dockerfile y docker-compose funcionando.
* [ ] README con instrucciones de instalación.
* [ ] Evidencias: screenshots del Kanban, logs de PRs, badges, etc.

---

## 12. Posibles errores comunes y soluciones (BIG list — léelo entero)

### Problemas con SSH / EC2

* **Permission denied (publickey)**: `chmod 400 key.pem`, asegurarse de que la key sea la correcta.
* **Timed out**: Security group no permite 22 o IP local bloqueada.
* **Instance status checks failing**: reinicia la instance desde consola o revisa logs del sistema.

### Nginx / Proxy

* **502 Bad Gateway**: backend caído o puerto incorrecto.
* **403 Forbidden**: permisos de carpeta `www` o propietario de archivos.

### Node / PM2

* **App crashea con error de falta de módulo**: ejecutar `npm ci` en servidor.
* **PM2 restart no actualiza**: `pm2 delete all` y luego `pm2 start`.

### Docker

* **Build falla por memory**: en EC2 t2.micro puede quedarse corto; usar máquinas con más RAM o hacer builds en local y push a registry.
* **Container no arranca**: revisar `docker logs <container>`.

### GitHub Actions

* **Secrets no configurados**: asegúrense de poner `EC2_KEY` completo (sin newlines corrompidos) y `EC2_HOST`.
* **Permissions insuficientes para mover Project cards**: usar token con scopes o `GITHUB_TOKEN` correcto.

---

## 13. Métricas y reportes

### Qué medir y cómo documentarlo

* **Velocity**: sumar puntos completados por sprint. Ej: Sprint 1 = 21 pts.
* **Burndown**: lista diaria con puntos restantes; pueden usar una imagen o tabla simple.
* **Lead Time**: tiempo desde que una card entra a `🚀 Ready` hasta `✅ Done`.
* **Cycle Time**: tiempo desde `👥 In Progress` hasta `✅ Done`.
* **Throughput**: historias completadas en el periodo.

Incluyan una tabla en `docs/metrics.md` con valores por sprint y gráficos (captura o imagen generada).

---

## 14. Documentación final y evidencias

Incluir en `docs/`:

* `capturas/` (tablero Kanban, PRs, commits, badges)
* `deploy/` (logs del servidor, comandos usados)
* `metrics.md`

En README, colocar enlaces a la app en EC2, link al Project y al Docker Hub (si aplica).

---

## 15. Presentación (guion para 20 minutos)

1. **Intro (3 min)**

   * Presentación del equipo (30s cada uno)
   * Idea general del proyecto
2. **Metodología y gestión (5 min)**

   * Mostrar GitHub Project: columnas, fields, ejemplos de historias
3. **Sprints (8 min)**

   * Sprint 1 (2.5 min): qué se hizo (EC2), demo rápida (API up)
   * Sprint 2 (2.5 min): CI y project automation (mostrar badge y logs)
   * Sprint 3 (3 min): Docker y deploy (mostrar `docker ps` en EC2)
4. **Colaboración y flujos (2 min)**

   * Mostrar PRs, reviews y merge
5. **Métricas y cierre (2 min)**

   * Velocity, burndown y lecciones aprendidas

> Ensayar con cronómetro y asignar partes a cada miembro.

---

## 16. Lecciones aprendidas y mejoras futuras

* Automatizar tests para frontend y backend.
* Mejorar seguridad: HTTPS (Let's Encrypt), IAM roles en AWS.
* Usar infra como código (Terraform) para reproducibilidad.
* Integrar monitoreo (Prometheus, Grafana) y alertas.

---

## 17. Enlaces útiles y referencias

* GitHub Projects docs
* GitHub Actions docs
* AWS EC2 docs
* Docker docs
* PM2 docs

---

## Contribuir (CONTRIBUTING.md básico)

```
1. Fork repo
2. Crear rama desde development: git checkout -b feature/mi-cosa
3. Hacer commits claros
4. Open PR contra development
5. asignar reviewers
```

---

## Tips finales (para que el profe quede feliz)

* Dejen evidencia: capturas del Kanban con columnas en distintos estados.
* Suban el video demo (5 min) con la app funcionando y pasos clave.
* No inventen commits: asegúrense que todos contribuyeron, aunque sea con documentación o issues.
* Documenten errores y cómo los arreglaron — eso suma mucho.

---

**Si quieres**: te lo dejo en el `.md` listo para descargar y subir. Dime si quieres que lo adapte con nombres reales del equipo, links y ejemplos concretos (por ejemplo, el workflow real con la IP de tu EC2). ¡Te hago las plantillas de Issue, los workflows y el Dockerfile listos para pegar.

¡Relájate, ya está casi! 😎
