FROM node:21-bullseye-slim@sha256:ca86d530ffad5dce27016a5936c1b57a781d249c5a5bbb8f84a7a6bad03c49c7
WORKDIR /usr/local/bin/
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 5173
CMD ["npm", "run", "dev"]
