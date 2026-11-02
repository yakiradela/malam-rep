# --- Stage 1: Builder ---
FROM node:20-alpine AS builder

WORKDIR /app

# מעתיקים את כל קובצי הפרויקט כדי ששום תלות או קובץ לא יפספסו
COPY package*.json ./
COPY . .

# מתקינים את כל התלויות (כולל devDependencies אם הן נדרשות לסקריפטים או לטסטים)
RUN npm ci

# --- Stage 2: Runner ---
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

# יצירת משתמש אבטחה (Best Practice)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# העתקת הקבצים הדרושים בלבד מה-builder
COPY --from=builder /app/package.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/server.js ./
COPY --from=builder /app/primes.js ./
COPY --from=builder /app/index.html ./

# מתן הרשאות למשתמש החדש
RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 3000

CMD ["npm", "start"]
