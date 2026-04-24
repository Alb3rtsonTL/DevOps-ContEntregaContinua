# ── Imagen base
# nginx:alpine es ligera (~10 MB) y sirve archivos estáticos de forma eficiente
FROM nginx:alpine

# ── Metadatos
LABEL maintainer="Alb3rtsonTL"
LABEL description="Hello World – DevOps Entrega Continua"
LABEL version="1.0"

# ── Copiar archivos de la app al directorio por defecto de nginx 
COPY /src/  /usr/share/nginx/html/

# ── Puerto expuesto
EXPOSE 80

# ── Comando por defecto (heredado de la imagen base, explícito por claridad) ─
CMD ["nginx", "-g", "daemon off;"]