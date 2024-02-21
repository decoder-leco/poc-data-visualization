# POC Data visualisation

L'objectif de ce proof of concept, est de déterminer les meilleurs patterns et technologies, que nous pouvons utiliser, pour visualiser un ensemble de données, potentiellement important.

## Run locally

* Execute this:
```bash

docker-compose build jupyter_deno

docker-compose up -d jupyter_deno

# docker-compose logs -f jupyter_deno

```
* go to http://localhost:8888/lab/ , and use `decoderleco` as the token to login

## Stack

Ce POC utilise le stack technologique suivant:

* Deux bases de données:
  * PostGreSQL
  * MongoDB
* Un servive Jupyter Notebooks, qui permettre d'écrire des notebooks:
  * en R language
  * en `TypeScript`, avec `deno`:
    * pour cette partie, on tentera de reproduire un jupyter notebook, tel que présenté ici: https://blog.logrocket.com/deno-jupyter-notebook-data-dashboard/
    * on aura une image docker conçue:
      * avec une image de baseconçue: https://github.com/jupyter/docker-stacks/tree/main/images/
      * 
