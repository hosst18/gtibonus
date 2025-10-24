
FROM node:20-alpine AS deps
WORKDIR /app
COPY package*.json ./

RUN npm ci --omit=dev --ignore-scripts


FROM node:20-alpine AS builder
WORKDIR /app
ENV HUSKY=0
COPY package*.json ./
RUN npm ci --ignore-scripts
COPY . .
RUN npm run build || mkdir -p dist


FROM node:20-alpine AS runtime
WORKDIR /app
ENV NODE_ENV=production
ENV PORT=3000
RUN addgroup -S app && adduser -S app -G app

COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/src ./src

EXPOSE 3000
USER app
CMD ["node", "src/index.js"]
