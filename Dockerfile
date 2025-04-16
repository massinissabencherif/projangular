# Étape 1 : Build Angular
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Étape 2 : Serveur Nginx pour héberger l'app
FROM nginx:alpine

COPY --from=build /app/dist/projangular /usr/share/nginx/html

# Supprimer la config par défaut de NGINX
RUN rm /etc/nginx/conf.d/default.conf

# Ajouter ta propre config (tu peux la personnaliser ensuite)
COPY nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
