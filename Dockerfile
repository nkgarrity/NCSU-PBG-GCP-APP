# Build stage
FROM node:18 as build
WORKDIR /app
# Copy from the subfolder
COPY ncsu-pbg-gcp-app/package*.json ./
RUN npm install
COPY ncsu-pbg-gcp-app/ ./
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]