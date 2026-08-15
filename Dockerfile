FROM node:26-alpine

WORKDIR /app

COPY package.json yarn.lock ./
RUN npm install -g corepack && corepack enable && corepack prepare yarn@stable --activate && yarn install
COPY . .

EXPOSE 3000
CMD ["node", "src/index.js"]