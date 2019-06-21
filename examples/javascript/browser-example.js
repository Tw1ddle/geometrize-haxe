const { geometrize } = require('../../build/lib')
var PNGReader = require('png.js')

function loadPng(url) {
  return new Promise((resolve, reject) => {
    fetch(url).then(response =>
      response.arrayBuffer()
    ).then(bytes => {
      var reader = new PNGReader(bytes)
      reader.parse(function (err, png) {
        if (err) reject(err)
        const bitmap = geometrize.bitmap.Bitmap.createFromRawBytes(png.width, png.height, png.pixels)
        resolve(bitmap)
      })
    })
  })
}

async function test() {
  document.getElementById('run').addEventListener('click', e=>{
    const imgUrl = '/docs/logo.png'
    const iterations = parseInt(document.getElementById('iterations').value||'500')
    const interval = parseInt(document.getElementById('interval').value||'0')
    run({imgUrl, iterations, interval})
  })  
}

async function run({imgUrl,iterations, interval}) {
  const bitmap = await loadPng(imgUrl)
  const runner = new geometrize.runner.ImageRunner(bitmap)
  const options = {
    shapeTypes: [0, 1, 2, 3, 4, 5, 6], // TODO: from enum
    candidateShapesPerStep: 50,
    shapeMutationsPerStep: 100,
    alpha: 128
  }
  const svgData = []
  for (let i = 0; i < iterations; i++) {
    svgData.push(geometrize.exporter.SvgExporter.exportShapes(runner.step(options)))
    if(interval){
      renderSvg(bitmap, svgData)
      await wait(interval)
    }
  }
  renderSvg(bitmap, svgData)
}

function renderSvg(bitmap, svgData) {
  const svg = geometrize.exporter.SvgExporter.getSvgPrelude() + geometrize.exporter.SvgExporter.getSvgNodeOpen(bitmap.width, bitmap.height) + svgData.join('\n') + geometrize.exporter.SvgExporter.getSvgNodeClose();
  document.getElementById('output').innerHTML = svg;
}

function wait(ms) {
  return new Promise(resolve => {
    setTimeout(() => {
      resolve()
    }, ms)
  })
}

test()
