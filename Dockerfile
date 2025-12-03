FROM node:25-alpine AS builder

WORKDIR /app

COPY . .

RUN npm ci

#multi stage build to remove npm and it's vulnerabilities
FROM alpine:3.20

WORKDIR /app

COPY --from=builder /app .

RUN apk add --no-cache nodejs

EXPOSE 8080

CMD ["node", "app.js"]