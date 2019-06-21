## Requirements

You will need haxe and node.js installed in your system.

## Install dependencies

```sh
npm install --save png.js
npm install --save-dev browserify http-server terser
```

## Build

Build JavaScript target:

```sh
haxe build-js-target.hxml 
```

This will generate a JavaScript version of the library at `build/geometrize.js`.

Bundle browser example:

```
nxp browserify examples/javascript-browser/browser-example.js -o build/browser-example.js 
```

This will generate `build/browser-example.js` which includes browser example plus all its dependencies, like geometrize, png.js, etc. See how it's used by [browser-example.html](browser-example.html)

Minify bundle (optional):

```sh
npx terser build/browser-example.js -o build/browser-example.js 
```

Serve and open the example:

```sh
npx http-server . & 
firefox http://localhost:8080/examples/javascript-browser/browser-example.html &
```

### All together

```sh
haxe build-js-target.hxml 
nxp browserify examples/javascript-browser/browser-example.js -o build/browser-example.js 
npx terser build/browser-example.js -o build/browser-example.js 
npx http-server . 
```