const { geometrize } = require('../../build/geometrize')
const PNGReader = require('png.js')

function loadPng(url) {
  return new Promise((resolve, reject) => {
    fetch(url).then(response =>
      response.arrayBuffer()
    ).then(bytes => {
      const reader = new PNGReader(bytes)
      reader.parse(function (err, png) {
        if (err) reject(err)
        document.getElementById('inputSize').innerHTML = (png.pixels.length / 1000) + 'KB'
        const bitmap = geometrize.bitmap.Bitmap.createFromRawBytes(png.width, png.height, png.pixels)
        resolve(bitmap)
      })
    })
  })
}

function renderSvg(bitmap, svgData) {
  const svg = geometrize.exporter.SvgExporter.getSvgPrelude() + geometrize.exporter.SvgExporter.getSvgNodeOpen(bitmap.width, bitmap.height) + svgData.join('\n') + geometrize.exporter.SvgExporter.getSvgNodeClose()
  document.getElementById('output').innerHTML = svg
  document.getElementById('outputSize').innerHTML = (svg.length / 1000) + 'KB'
}

function wait(ms) {
  return new Promise(resolve => {
    setTimeout(() => {
      resolve()
    }, ms)
  })
}

async function run({ imgUrl, iterations, interval }) {
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
    if (interval) {
      renderSvg(bitmap, svgData)
      await wait(interval)
    }
  }
  renderSvg(bitmap, svgData)
}

async function test() {
  document.getElementById('main').innerHTML = html
  document.getElementById('run').addEventListener('click', async e => {
    const imgUrl = document.getElementById('imgUrl').value || 'logo.png'
    const iterations = parseInt(document.getElementById('iterations').value || '100')
    const interval = parseInt(document.getElementById('interval').value || '0')
    document.getElementById('status').innerHTML = 'Working'
    const t0 = Date.now()
    await run({ imgUrl, iterations, interval })
    document.getElementById('elapsedTime').innerHTML = ((Date.now() - t0) / 1000) + 'seconds'
    document.getElementById('status').innerHTML = 'Stand by'
  })
  document.getElementById('imgUrl').addEventListener('change', async e => {
    document.getElementById('img').src = document.getElementById('imgUrl').value
  })
}

const html = `
<img id="img" src="logo.png"/><br/>
<div>Input size: <span id="inputSize"></span></div>
<label>Image URL: <input type="url" value="logo.png" id="imgUrl"/></label><br/>
<label>Iterations: <input id="iterations" type="number" min="1" value="100"/></label><br/>
<label>Interval: <input id="interval" type="number" min="0" value="0"/></label><br/>
<button id="run">run</button><br/>
<div>Status: <span id="status">Stand by</span></div>
<div>Output size: <span id="outputSize"></span></div>
<div>Elapsed time: <span id="elapsedTime"></span></div>
<div id="output"></div>
<h4>Working Image URLs</h4>
<p>png.js, the library to decode images that this example uses, support a limited set of formats (this is not a geometrize limitation but png.js'). This is a list of images that currently work for you to test:</p>
<ul>
<li>https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png</li>
<li>logo.png</li>
<li>https://upload.wikimedia.org/wikipedia/commons/b/b8/Lokazzjoni_ta%27_Ruma.png</li>
<li>https://upload.wikimedia.org/wikipedia/commons/1/15/Xochiquetzal_V.png</li>
<li>https://i.imgur.com/PzdDHyo.png?2</li>
<li>https://i.imgur.com/8UQhIQQ.png</li>
<li>https://upload.wikimedia.org/wikipedia/commons/8/86/Nikon_D3000_CN-2011-04.png</li>
<li>https://upload.wikimedia.org/wikipedia/commons/d/d6/Wikipedia-logo-v2-en.png</li>
<li>https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Fiji_banded_iguana_in_Vienna_Zoo_on_2013-05-12.png/640px-Fiji_banded_iguana_in_Vienna_Zoo_on_2013-05-12.png</li>
</ul>
`

test()
