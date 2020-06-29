FROM hayd/deno:latest
WORKDIR /app
USER deno
ADD . .
RUN deno cache app.ts
CMD ["run", "--allow-net", "app.ts" ]