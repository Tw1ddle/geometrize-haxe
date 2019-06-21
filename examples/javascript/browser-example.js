const { geometrize } = require('../../build/lib')
const a = require('../../build/lib')
debugger
var PNGReader = require('png.js')
function loadPng(url) {
  return new Promise((resolve, reject) => {
    fetch('/docs/logo.png').then(response =>
      response.arrayBuffer()
    ).then(bytes => {
      var reader = new PNGReader(bytes)
      reader.parse(function (err, png) {
        if (err) reject(err)
        const bitmap = geometrize.bitmap.Bitmap.createFromRawBytes(png.width, png.height, png.pixels)
        resolve(bitmap)
        // debugger
        // var data = geometrize.bitmap.Data.alloc(png.pixels.length);
        // for (let i = 0; i <png.pixels.length; i++) {
        //   data.set(i, png.pixels[i])
        // }
        // resolve({ ...png, data: geometrize.bitmap.Bitmap.createFromBytes(png.width, png.height, data) })
      })
    })
  })
}

async function test() {
  const bitmap = await loadPng('/docs/logo.png')
  const runner = new geometrize.runner.ImageRunner(bitmap)
  const options = {
    shapeTypes: [0, 1, 2, 3], // TODO: from enum
    candidateShapesPerStep: 50,
    shapeMutationsPerStep: 100,
    alpha: 128
  }
  const iterations = 500
  let results = []
  const svgData = []
  for (let i = 0; i < iterations; i++) {
    const r = runner.step(options)
    svgData.push(geometrize.exporter.SvgExporter.exportShapes(r))
    if(r && r.length){
      results.push(r[0])
    }
  }
  debugger
  const svg2 = geometrize.exporter.SvgExporter.getSvgPrelude() + geometrize.exporter.SvgExporter.getSvgNodeOpen(bitmap.width, bitmap.height) + svgData.join('\n') + geometrize.exporter.SvgExporter.getSvgNodeClose();

  document.getElementById('output').innerHTML = svg2
}

test()






// const Jimp = require('jimp')

// const blobToBuffer = require('blob-to-bufer')

// async function fetchAsBuffer(url) {
//   var options= {
//     method: 'GET',
//     mode: 'cors',
//     cache: 'default'
//   }
//   var request = new Request(url)
//   const response = await fetch(request)
//   const blob = await response.blob()
//   const buffer = await blobToBuffer(blob)
//   return buffer
// }