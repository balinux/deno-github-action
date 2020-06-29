# about 
deploy deno to fly.io with github actions

# references
https://fly.io/docs/app-guides/continuous-deployment-with-github-actions/

# config
- docker : 
``` Dockerfile
FROM hayd/deno:latest
WORKDIR /app
USER deno
ADD . .
RUN deno cache app.ts
CMD ["run", "--allow-net", "app.ts" ]
```
  

# step
- create repo
- create simple app, example: https://deno.land/#getting-started
- login to fly.io with : ```flyctl auth login```
- create token fly.io with : ```flyctl auth token```
- go to setting on your repository
- create a secret, name: FLY_API_TOKEN, with value fro token step 2
- create Dockerfile add config docker
- run flyctl apps create to create a fly.toml
- create `.github/workflows/main.yml` file with these content: 
```
name: Fly Deploy
on: [push]
env:
  FLY_API_TOKEN: ${{ secrets.FLY_API_TOKEN }}
jobs:
  deploy:
      name: Deploy app
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v2
        - uses: superfly/flyctl-actions@1.1
          with:
            args: "deploy"
```

- commit and push
- This is where the magic happens - The push will have triggered a deploy and from now on whenever you push a change, the app will automatically be redeployed.