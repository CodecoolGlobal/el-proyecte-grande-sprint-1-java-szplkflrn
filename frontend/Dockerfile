FROM node:20.9.0-slim@sha256:fdf5490bb2e1aba61297901bbe55d39202a6d9f18913bfb4a37466f8b728a44e AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build


FROM nginx:stable-alpine3.17-slim@sha256:2dd6fda42712ea12e1654f5cf551144fd3f30269276f36ed1c9c2c19a18f7ec7
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]
