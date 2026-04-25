# DevOps · Entrega Continua con Docker [![web](https://img.shields.io/badge/repo-blue)](https://github.com/Alb3rtsonTL/DevOps-Render-Deploy)

![Info](https://img.shields.io/badge/type-Practice-white)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![Docker Hub](https://img.shields.io/badge/Docker%20Hub-2496ED?logo=docker&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?logo=github-actions&logoColor=white)
![Render](https://img.shields.io/badge/Render-46E3B7?logo=render&logoColor=black)
[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Versión](https://img.shields.io/badge/Versi%C3%B3n-2.0-brightgreen)](https://github.com/Alb3rtsonTL/DevOps-Render-Deploy)

---

## Descripción

Continuación de la práctica de DevOps. Partiendo del repositorio anterior (Dockerfile + app Hello World), se agrega **automatización completa con GitHub Actions**:

1. En cada push a `main` → se construye la imagen Docker
2. La imagen se sube automáticamente a **Docker Hub**
3. Se dispara el **deploy automático en Render.com**

---

## Flujo CI/CD Completo

```
push a main
     │
     ▼
GitHub Actions
     │
     ├─► docker build + push → Docker Hub
     │
     └─► Deploy Hook → Render.com
                               │
                               └─► Sitio en producción actualizado
```

---

## Tecnologías

| Herramienta | Rol |
|---|---|
| **HTML / CSS / JS** | App web Hello World |
| **Docker / Dockerfile** | Contenerización de la app |
| **nginx:alpine** | Servidor dentro del contenedor |
| **Docker Hub** | Registro de imágenes |
| **GitHub Actions** | Automatización CI/CD |
| **Render.com** | Plataforma de despliegue en producción |

---

## Estructura del Proyecto

```
DevOps-Render-Deploy/
├── .github/
│   └── workflows/
│       └── deploy.yml   <- Pipeline CI/CD
├── src/
│   └── img
│       └── background.webp
│   └──  index.html
│   └──  styles.css
│   └──  scripts.js
├── Dockerfile
└── README.md
```

---

## Configuración paso a paso

### 1. Obtener token de Docker Hub

1. Ingresar a https://hub.docker.com
2. Ir a **Account Settings → Security → Personal Access Tokens**
3. Crear un nuevo token con permiso **Read & Write**
4. Copiar el token generado (solo se muestra una vez)

---

### 2. Crear servicio en Render.com

1. Ingresar a https://render.com y crear cuenta
2. **New → Web Service**
3. Seleccionar **Deploy an existing image from a registry**
4. En Image URL poner:
   ```
   docker.io/<tu-usuario-dockerhub>/devops-render-deploy:latest
   ```
5. Elegir el plan **Free** y hacer clic en **Create Web Service**

#### Obtener el Deploy Hook URL:
1. Dentro del servicio creado ir a **Settings**
2. Buscar la sección **Deploy Hook**
3. Copiar la URL completa (formato: `https://api.render.com/deploy/srv-xxxx?key=yyyy`)

---

### 3. Agregar los Secrets en GitHub

Ir al repositorio → **Settings → Secrets and variables → Actions → New repository secret**

| Secret | Valor |
|---|---|
| `DOCKERHUB_USERNAME` | Tu usuario de Docker Hub |
| `DOCKERHUB_TOKEN` | El token generado en el paso 1 |
| `RENDER_DEPLOY_HOOK_URL` | La URL del Deploy Hook de Render |

> Los secrets nunca se guardan en el código. GitHub los inyecta de forma segura al correr el workflow.

---

### 4. Hacer push y verificar el pipeline

```bash
git add .
git commit -m "feat: add GitHub Actions CI/CD pipeline"
git push origin main
```

Luego ir a la pestaña **Actions** del repositorio para ver el pipeline en tiempo real.

---

## Workflow explicado (deploy.yml)

```yaml
on:
  push:
    branches: [main]   # Se activa en cada push a main
```

**Job 1: build-and-push**

| Paso | Acción |
|---|---|
| checkout@v4 | Clona el código del repo |
| login-action@v3 | Inicia sesión en Docker Hub con los secrets |
| setup-buildx-action@v3 | Configura el builder avanzado de Docker |
| metadata-action@v5 | Genera tags automáticos: latest + SHA del commit |
| build-push-action@v5 | Construye la imagen y hace push a Docker Hub |

**Job 2: deploy-render** (depende del Job 1)

| Paso | Acción |
|---|---|
| curl POST | Llama al Deploy Hook URL de Render para disparar el redeploy |

---

## Comandos manuales (sin Actions)

```bash
# Build
docker build -t devops-render-deploy .

# Run local
docker run -d -p 8080:80 devops-render-deploy

# Push manual a Docker Hub
docker tag devops-render-deploy <usuario>/devops-render-deploy:latest
docker push <usuario>/devops-render-deploy:latest
```

---

- **Autor:** Alb3rtsonTL – Albertson Terrero López
- **Licencia:** MIT License
- **Versión:** 2.0