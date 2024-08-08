###############
# BUILD PHASE
###############
FROM node:1.27.0-alpine AS builder

WORKDIR '/app/'

# we need to keep COPY statement below,
# even if we are mounting a volume covering the file.
COPY package.json .

RUN npm install

# We can comment out the COPY statememt below
# now that we have docker volume referencing .:/app
# Let's keep the line however, 
# we need it if we are not using docker compose.
COPY . .

CMD ["npm", "run", "build"]


##############
# RUN PHASE
##############
FROM nginx AS run

COPY --from=builder /app/build /usr/share/nginx/html

# No need for more commands. Nginx starts automatically.
#
