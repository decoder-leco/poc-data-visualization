
# The `TypeScript` Jupyter notebook

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

Et voici le notebook à tester:

```TypeScript
import * as d3 from "npm:d3";
import { createCanvas } from "https://deno.land/x/skia_canvas/mod.ts";
import pl from "npm:nodejs-polars";
import { display } from "https://deno.land/x/display@v0.1.1/mod.ts";


let response = await fetch(
  "https://gist.githubusercontent.com/agustinustheo/195f32a4a6c68c493056c883d959ca35/raw/c7363d8b916ab00a2d1747adb89fca120da29f42/mock_financial_data.csv",
);

let data = await response.text();

let df = pl.readCSV(data, { sep: "," });

// await display(df.sample(10));

const lastDataPoint = df.tail(1).toRecords()[0];
console.log(lastDataPoint);

let categories = ['Salaries', 'R&D', 'Marketing', 'Utilities', 'Rent', 'Equipment', 'Software', 'Hardware', 'Consulting', 'Office Supplies'];

// Sample data
const sampleData1 = [];
for(let i = 0; i < categories.length; i++) {
    const category = categories[i];
    sampleData1.push({
        category,
        amount: lastDataPoint[category],
    });
}

// data au-dessus

const width = 500;
const height = 500;
const radius = Math.min(width, height) / 2;

// Create a pie function
const pie = d3.pie().value(d => d.amount);

// Create an arc generator for the slices
const arc = d3.arc()
    .innerRadius(0)
    .outerRadius(radius);

// Create an arc generator for the labels
const labelArc = d3.arc()
    .innerRadius(radius - 40) // Adjust to position the labels
    .outerRadius(radius - 40);

// Create the canvas
const canvas = createCanvas(width, height);
const ctx = canvas.getContext("2d");

// Translate to center the pie chart
ctx.translate(width / 2, height / 2);

// Draw the pie chart
pie(sampleData1).forEach((d, i) => {
    // Draw the slice
    ctx.beginPath();
    arc.context(ctx)(d);
    ctx.fillStyle = d3.schemeCategory10[i % 10];
    ctx.fill();

    // Draw the label
    ctx.fillStyle = "#000"; // Label color
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";

    const centroid = labelArc.centroid(d);
    ctx.fillText(d.data.category, centroid[0], centroid[1]);
});

// Display the canvas
await display(canvas);
```

* Là:

```TypeScript

import React from 'npm:react';
import ReactDOM from 'npm:react-dom/server';

import * as d3 from "npm:d3";
// import { createCanvas } from "https://deno.land/x/skia_canvas/mod.ts";
import pl from "npm:nodejs-polars";
// import { display } from "https://deno.land/x/display@v0.1.1/mod.ts";


let response = await fetch(
  "https://gist.githubusercontent.com/agustinustheo/195f32a4a6c68c493056c883d959ca35/raw/c7363d8b916ab00a2d1747adb89fca120da29f42/mock_financial_data.csv",
);

let data = await response.text();

let df = pl.readCSV(data, { sep: "," });


const HTMLtoRender = `<h1>Hello world!</h1><div>${df.sample(10)}</div>`;

// https://docs.jupyter.org/en/latest/reference/mimetype.html
const inspect = (obj: any) => {
    
    if (React.isValidElement(obj)) {
        return {
            [Symbol.for('Jupyter.display')]() {
                return {
                    'text/html': ReactDOM.renderToString(obj),
                };
            },
        };
    }
    return obj
};

inspect(
    <>
        <em>Hi:</em>
        <img src="https://api.iconify.design/fluent-emoji-flat/alarm-clock.svg" />
        ${HTMLtoRender}
    </>
);
```

là :

```TypeScript
import * as d3 from "npm:d3";
// import { createCanvas } from "https://deno.land/x/skia_canvas/mod.ts";
import pl from "npm:nodejs-polars";
// import { display } from "https://deno.land/x/display@v0.1.1/mod.ts";


const response = await fetch(
  "https://gist.githubusercontent.com/agustinustheo/195f32a4a6c68c493056c883d959ca35/raw/c7363d8b916ab00a2d1747adb89fca120da29f42/mock_financial_data.csv",
);

const data = await response.text();

let df = pl.readCSV(data, { sep: "," });

// await display(df.sample(10));

const lastDataPoint = df.tail(1).toRecords()[0];
console.log(lastDataPoint);








// const HTMLtoRender = `<h1>Hello world!</h1><div>${df.sample(10)}</div>`;

import React, { useRef, useEffect } from 'npm:react';
import ReactDOM from 'npm:react-dom/server';


export const DecoderCanvas = (props) => {
    const  categories = ['Salaries', 'R&D', 'Marketing', 'Utilities', 'Rent', 'Equipment', 'Software', 'Hardware', 'Consulting', 'Office Supplies'];
    // Sample data
    const sampleData1 = [];
    for(let i = 0; i < categories.length; i++) {
      let category = categories[i];
      sampleData1.push({
          category,
          amount: lastDataPoint[category],
      });
    }
    const width = 500;
    const height = 500;
    const radius = Math.min(width, height) / 2;
    
    // Create a pie function
    const pie = d3.pie().value(d => d.amount);
    
    // Create an arc generator for the slices
    const arc = d3.arc()
        .innerRadius(0)
        .outerRadius(radius);
    
    // Create an arc generator for the labels
    const labelArc = d3.arc()
        .innerRadius(radius - 40) // Adjust to position the labels
        .outerRadius(radius - 40);

    const canvasRef = useRef(null)
    
    const draw = (ctx/*, frameCount*/) => {
        /*
        ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height)
        ctx.fillStyle = '#000000'
        ctx.beginPath()
        ctx.arc(50, 100, 20*Math.sin(frameCount*0.05)**2, 0, 2*Math.PI)
        ctx.fill()
        */
        // Translate to center the pie chart
        ctx.translate(width / 2, height / 2);
        console.log(`value of sampleData1:`, sampleData1)
        // Draw the pie chart
        pie(sampleData1).forEach((d, i) => {
          // Draw the slice
          context.beginPath();
          arc.context(ctx)(d);
          ctx.fillStyle = d3.schemeCategory10[i % 10];
          ctx.fill();
          // Draw the label
          ctx.fillStyle = "#000"; // Label color
          ctx.textAlign = "center";
          ctx.textBaseline = "middle";
          const centroid = labelArc.centroid(d);
          ctx.fillText(d.data.category, centroid[0], centroid[1]);
        });
    }
    
    useEffect(() => {
    
    const canvas = canvasRef.current
    const context = canvas.getContext('2d')
    // const ctx = canvas.getContext("2d");
    

    //Our draw come here
    draw(context)
    }, [draw])
    
    return (<canvas ref={canvasRef} {...props}/>)
}

// https://docs.jupyter.org/en/latest/reference/mimetype.html
const inspect = (obj: any) => {
    
    if (React.isValidElement(obj)) {
        return {
            [Symbol.for('Jupyter.display')]() {
                return {
                    'text/html': ReactDOM.renderToString(obj),
                };
            },
        };
    }
    return obj
};

inspect(
    <>
        <em>Hi:</em>
        <img src="https://api.iconify.design/fluent-emoji-flat/alarm-clock.svg" />
        <DecoderCanvas fill={'#00AB00'} fillstyle={'#00A'} width="300" height="300" />
    </>
);



```


Popopopo, pourvu que j'exporte l'historique des messages Telegram en JSON, j'arrive à générer en typescript, un graphe des rankings de messages de chaque membre du groupe télégram, comme ça : 

```TypeScript

import resultData from './decoderleco.telegram.chat.history.json' assert {type: "json"}
import * as Plot from "npm:@observablehq/plot"
import { DOMParser, SVGElement } from "npm:linkedom"

function mergeText(arr) {
    return typeof arr === "string" ? arr : arr.map(x => {
        if (typeof x === "string") return x
        return x.text
    }).join("")
}

function findRanking(x, name) {
    console.log(` >>> findRanking - x = [${x}]`)
    console.log(` >>> findRanking name = [${name}]`)
    
    if ( x == null ) {
        console.log(` >>> findRanking - x is null`)
    }

    if (x.split("\n") == null) {
        console.log(` >>> findRanking - x.split("antisLash n") is null`)
    }
    const line = x.split("\n").find(x => x.includes(name))
    if (line === undefined) {
        console.log(` >>> findRanking - line is undefined`)
    }
    if (line == null) {
        console.log(` >>> findRanking - line is null`)
        return 100
    }
    if (line === undefined) {
        return 100
    } else {
        console.log(` >>> findRanking - line is NOT undefined`)
        if ( line == null ) {
            console.log(` >>> findRanking - but line IS NULL`)
        } else {
            console.log(` >>> findRanking - and line IS NOT NULL`)
        }
        // let foundMatches = line.match(/^\d+/)[0];
        let foundMatches = line.match(/^\d+/);
        console.log(` >>> findRanking - foundMatches = [${foundMatches}]`)
        if (foundMatches == null) {
            return 10
        }
        let toReturn = Number(line.match(/^\d+/)[0])
        console.log(` >>> findRanking - toReturn=[${toReturn}]`)
        return toReturn
    }

}

var getRanks = (name) => {
    // const raw = resultData.messages
    // .map(x => [x.date, mergeText(x.text)])
    // .filter(x => x[1].includes("音游排行"))
    // .map(x => ({date: new Date(x[0]), rank: findRanking(x[1], name)}))
    const raw = resultData.messages
    .map(x => [x.date, mergeText(x.text)])
    .map(x => ({date: new Date(x[0]), rank: findRanking(x[1], name)}))
    const firstValid = raw.findIndex(x => x.rank !== 100)
    return raw.slice(firstValid)
}

var getMultipleRanks = (names) => names.map(x => getRanks(x).map(y => ({...y, name: x}))).reduce((a,b) => [...a, ...b])

// var ranks = getMultipleRanks(["ユメステ", "アイプラ", "プロセカ", "バンドリ"])

// var ranks = getMultipleRanks(["Galicez", "Boris", "decoder_l", "Jb Kritcek777"])

var ranks = getMultipleRanks(["Galicez", "Boris", "decoder_l"])


var document = new DOMParser().parseFromString("<!DOCTYPE html><html></html>")

var plot = Plot.plot({
  color: {legend: true},
  marks: [
    Plot.lineY(ranks, {x: "date", y: "rank", stroke: "name"})
  ],
  document,
  y: {
      domain: [100, 0]
  }
}).toString()

var display = {
    [Symbol.for("Jupyter.display")]() {
        return {
            "text/html": plot
        }
    }
}

display
```

* et sans les console log :

```bash
import resultData from './decoderleco.telegram.chat.history.json' assert {type: "json"}
import * as Plot from "npm:@observablehq/plot"
import { DOMParser, SVGElement } from "npm:linkedom"

function mergeText(arr) {
    return typeof arr === "string" ? arr : arr.map(x => {
        if (typeof x === "string") return x
        return x.text
    }).join("")
}

function findRanking(x, name) {
    const line = x.split("\n").find(x => x.includes(name))
    if (line == null) {
        return 100
    }
    if (line === undefined) {
        return 100
    } else {
        // let foundMatches = line.match(/^\d+/)[0];
        let foundMatches = line.match(`/^${name}*/`);
        if (foundMatches == null) {
            return 50
        }
        let toReturn = Number(line.match(/^\d+/)[0])
        console.log(` toReturn = [${toReturn}]`)
        return toReturn
    }

}

var getRanks = (name) => {
    // const raw = resultData.messages
    // .map(x => [x.date, mergeText(x.text)])
    // .filter(x => x[1].includes("音游排行"))
    // .map(x => ({date: new Date(x[0]), rank: findRanking(x[1], name)}))
    const raw = resultData.messages
    .map(x => [x.date, mergeText(x.text)])
    .map(x => ({date: new Date(x[0]), rank: findRanking(x[1], name)}))
    const firstValid = raw.findIndex(x => x.rank !== 100)
    return raw.slice(firstValid)
}

var getMultipleRanks = (names) => names.map(x => getRanks(x).map(y => ({...y, name: x}))).reduce((a,b) => [...a, ...b])

// var ranks = getMultipleRanks(["ユメステ", "アイプラ", "プロセカ", "バンドリ"])

// var ranks = getMultipleRanks(["Galicez", "Boris", "decoder_l", "Jb Kritcek777"])

// var ranks = getMultipleRanks(["Galicez", "Boris", "decoder_l", "+33 6 78 27 56 95"])

var ranks = getMultipleRanks(["Galicez", "Boris", "decoder_l", "Jb"])


var document = new DOMParser().parseFromString("<!DOCTYPE html><html></html>")

var plot = Plot.plot({
  color: {legend: true},
  marks: [
    Plot.lineY(ranks, {x: "date", y: "rank", stroke: "name"})
  ],
  document,
  y: {
      domain: [100, 0]
  }
}).toString()

var display = {
    [Symbol.for("Jupyter.display")]() {
        return {
            "text/html": plot
        }
    }
}

display
```


* Là, voilà un exemple de composnat react écrit en pur typescript, qui fonctionne (mais les composants de react-icons, ça ne passe pas):

```TypeScript
import React, { useRef, useEffect } from 'npm:react';
import ReactDOM from 'npm:react-dom/server';
import { FaWeight, FaFortAwesome, FaSpaceAwesome } from "npm:react-icons/fa";


export interface TestReactComponentProps {
    name?: string
    color?: string
    size?: number
    alt?: string
    className?: string
}
export function TestReactComponent(props?: TestReactComponentProps) {
  
  return (
    <>
        <ul>
          <li>
              FaWeight
          </li>
          <li>
              FaFortAwesome
          </li>
          <li>
              FaSpaceAwesome
          </li>
        </ul>
    </>
  );
};

// https://docs.jupyter.org/en/latest/reference/mimetype.html
const inspect = (obj: any) => {
    
    if (React.isValidElement(obj)) {
        return {
            [Symbol.for('Jupyter.display')]() {
                return {
                    'text/html': ReactDOM.renderToString(obj),
                };
            },
        };
    }
    return obj
};

inspect(
    <>
        <em>Hi:</em>
        <img src="https://api.iconify.design/fluent-emoji-flat/alarm-clock.svg" />
        <TestReactComponent />
    </>
);
```
