# POC Data visualisation

L'objectif de ce proof of concept, est de déterminer les meilleurs patterns et technologies, que nous pouvons utiliser, pour visualiser un ensemble de données, potentiellement important.

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

### The TypeScript Jupyter notebook

* pour cette partie, on tentera de reproduire un jupyter notebook, tel que présenté ici: https://blog.logrocket.com/deno-jupyter-notebook-data-dashboard/
* on aura une image docker conçue:
  * avec une image docker de base deno
  * avec une installation des bibliothèques souhaitées: 
    * [D3.js](https://github.com/d3/d3)
    * [Observable Plot](https://github.com/observablehq/plot)
    * [Polars](https://github.com/pola-rs/nodejs-polars)
    * [Skia Canvas](https://github.com/samizdatco/skia-canvas)
    * [Display JS](https://deno.land/x/display@v0.1.1/mod.ts) see also https://github.com/rgbkrk/display.js
<!--
    * avec une image de base issue des standards officiels : https://github.com/jupyter/docker-stacks/tree/main/images/

-->