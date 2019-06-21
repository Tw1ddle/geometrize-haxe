const { geometrize } = require('../../build/geometrize')
const { writeFileSync, existsSync, readFileSync } = require('fs')
const Jimp = require('jimp')

async function loadPng(url) {
  const image = await  Jimp.read(url)
  return geometrize.bitmap.Bitmap.createFromRawBytes(image.bitmap.width, image.bitmap.height, image.bitmap.data)
}

async function run({ input, iterations, candidateShapesPerStep, shapeMutationsPerStep, alpha, shapeTypes }) {
  try {
    const bitmap = await loadPng(input)
    const runner = new geometrize.runner.ImageRunner(bitmap)
    const options = {
      shapeTypes, // TODO: from enum
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
  const args = require('minimist')(process.argv.slice(2)) || {}
  const options = {
    ...{
      input: 'docs/logo.png',
      output: 'tmp_out.svg',
      iterations: 1000,
      shapeTypes: [0, 1, 2, 3, 4, 5, 6], // TODO: from enum
      candidateShapesPerStep: 50,
      shapeMutationsPerStep: 100,
      alpha: 128,
    }, ...args
  }
  if(typeof options.shapeTypes==='string' ){
    options.shapeTypes = options.shapeTypes.split(',').map(s=>parseInt(s))
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
