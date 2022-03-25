# Seatplus

## Instructions
1) Bootstrap your `.env`
```
bash bootstrap.sh
```

2) Prepare source files
```
docker-compose run --rm php composer create-project seatplus/core . --prefer-dist --no-dev --no-ansi`
```


## Production
Spin the container up
```
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

Then run the migrations

## Development
If you plan to develop add the packages you wish to commit to:

You may want to install and use [Spin](https://serversideup.net/open-source/spin/getting-started/introduction)

1) Add repository to the project
   ```
   spin run --rm php composer create-project owner/repo ../packages/repo --prefer-dist --no-ansi --no-install
   # or without spin
   docker-compose -f docker-compose.yml -f docker-compose.dev.yml run --rm php composer create-project owner/repo ../packages/repo --prefer-dist --no-ansi --no-install
   ```
2) Add package to _repositories_ inside *composer.json*

   ```json
   // composer.json
   "repositories": [
    {
      "type": "path",
      "url": "../packages/web"
    },
   ],
   ```
3) add repository dependency with wildcard to *composer.json*
    ```json
   // composer.json
   "require": {
      "owner/repo": "*"
   }
   ```
          