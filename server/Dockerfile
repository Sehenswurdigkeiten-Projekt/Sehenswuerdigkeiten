FROM node:10.19.0
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3001
CMD [ "node", "loadBalancer.js" ]
