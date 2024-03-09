# POC Data visualisation

L'objectif de ce proof of concept, est de déterminer les meilleurs patterns et technologies, que nous pouvons utiliser, pour visualiser un ensemble de données, potentiellement important.

## Run locally

* Execute this:

```bash

docker-compose build jupyter_deno

docker-compose up -d jupyter_deno

# docker-compose logs -f jupyter_deno

# --- # ---
# --- 
# -
# docker-compose down && git checkout . && git checkout feature/jb/first/notebooks && git pull && docker-compose build jupyter_deno && docker-compose up -d jupyter_deno && docker-compose logs -f jupyter_deno
```

* go to http://localhost:8888/lab/ , and use `decoderleco` as the token to login

<!--

Little helper for working with VirtualBox VM as a docker runner

```bash
scp -r jbl@mongo.pesto.io:/home/jbl/poc-data-visualization/notebooks/jb/PolarsDemo1.ipynb ./notebooks/jb/

scp -r jbl@jupyter-spark.pesto.io:/home/jbl/poc-data-visualization/notebooks/jb/PolarsDemo1.ipynb ./notebooks/jb/

scp -r jbl@jupyter-deno.pesto.io:/home/jbl/poc-data-visualization/notebooks/jb/PolarsDemo1.ipynb ./notebooks/jb/

# and in the VM:

# docker-compose down && git checkout . && git checkout feature/jb/first/notebooks && git pull && docker-compose build jupyter_deno && docker-compose up -d jupyter_deno && docker-compose logs -f jupyter_deno
```
-->

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
