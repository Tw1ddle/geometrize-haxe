## Requirements

You will need haxe and node.js installed in your system.

## Install dependencies

```sh
npm install --save jimp minimist
```

## Build

Build JavaScript target:

```sh
haxe build-js-target.hxml 
```

This will generate a JavaScript version of the library at `build/geometrize.js`.

## Run

```sh
node examples/javascript-node/node-example.js --input docs/logo.png --output tmp_out.svg --iterations 100 --shapeTypes 0,1,2,3,4,5,6 --candidateShapesPerStep 50 --shapeMutationsPerStep 100 --alpha 128
```

All arguments are optional so the following will also work: 

```sh
node examples/javascript-node/node-example.js
```
