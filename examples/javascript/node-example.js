const { geometrize } = require('../../build/geometrize')
const PNGReader = require('png.js')
const { writeFileSync, existsSync, readFileSync } = require('fs')
const fetch = require('node-fetch')
const { resolve } = require('path')

function readBytes(url) {
  if (existsSync(url)) {
    const buf = readFileSync(url)
    var ab = new ArrayBuffer(buf.length)
    var view = new Uint8Array(ab)
    for (var i = 0; i < buf.length; ++i) {
      view[i] = buf[i]
    }
    return Promise.resolve(ab)
  }
  else {
    return fetch(url)
      .then(response =>
        response.arrayBuffer()
      )
      .catch(error => {
        console.error(`An error ocurred:`, error);
        process.exit(1)
      })
  }
}

function loadPng(url) {
  return new Promise((resolve, reject) => {
    readBytes(url)
      .then(bytes => {
        const reader = new PNGReader(bytes)
        reader.parse(function (err, png) {
          if (err) reject(err)
          resolve(geometrize.bitmap.Bitmap.createFromRawBytes(png.width, png.height, png.pixels))
        })
      })
  })
}

async function run({ input, iterations, candidateShapesPerStep, shapeMutationsPerStep, alpha }) {
  try {

    const bitmap = await loadPng(input)
    const runner = new geometrize.runner.ImageRunner(bitmap)
    const options = {
      shapeTypes: [0, 1, 2, 3, 4, 5, 6], // TODO: from enum
      candidateShapesPerStep,
      shapeMutationsPerStep,
      alpha
    }
    const svgData = []
    for (let i = 0; i < iterations; i++) {
      svgData.push(geometrize.exporter.SvgExporter.exportShapes(runner.step(options)))
    }
    return geometrize.exporter.SvgExporter.getSvgPrelude() + geometrize.exporter.SvgExporter.getSvgNodeOpen(bitmap.width, bitmap.height) + svgData.join('\n') + geometrize.exporter.SvgExporter.getSvgNodeClose()
  } catch (error) {
    console.error(`An error ocurred:`, error);
    process.exit(1)
  }
}

async function main() {
  const t0 = Date.now()
  const options = {
    ...{
      input: 'docs/logo.png',
      output: 'tmp_out.svg',
      iterations: 1000,
      shapeTypes: [0, 1, 2, 3, 4, 5, 6], // TODO: from enum
      candidateShapesPerStep: 50,
      shapeMutationsPerStep: 100,
      alpha: 128,
    }, ...require('minimist')(process.argv.slice(2)) || {}
  }

  const svg = await run(options)
  writeFileSync(options.output, svg)
  console.log(`
Written file ${options.output}.
Elapsed time: ${(Date.now() - t0) / 1000} seconds.
Output size: ${svg.length / 1000} KB.
Options: ${JSON.stringify(options)}
`.trim())

}

main()
