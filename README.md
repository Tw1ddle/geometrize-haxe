[![Project logo](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/logo.png?raw=true "Geometrize Haxe - recreating images as geometric shapes logo")](https://www.geometrize.co.uk/)

[![Haxelib Version](https://img.shields.io/github/tag/Tw1ddle/geometrize-haxe.svg?style=flat-square&label=haxelib)](https://lib.haxe.org/p/geometrize-haxe)
[![Travis Unit Test Build Status](https://img.shields.io/travis/Tw1ddle/geometrize-haxe-unit-tests.svg?style=flat-square)](https://travis-ci.org/Tw1ddle/geometrize-haxe-unit-tests)
[![License](https://img.shields.io/:license-mit-blue.svg?style=flat-square)](https://github.com/Tw1ddle/geometrize-haxe/blob/master/LICENSE)

Geometrize Haxe is a Haxe library for recreating images with geometric primitives. Run the demo [in your browser](https://www.samcodes.co.uk/project/geometrize-haxe-web/).

Geometrize Haxe is part of [Geometrize](https://www.geometrize.co.uk/), and is based on the [primitive](https://github.com/fogleman/primitive) Go library.

[![Geometrized Cat 500 Triangles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/cat.gif?raw=true "Geometrized Cat - 500 Geometric Primitives")](https://www.geometrize.co.uk/)

## Features
* Recreate images as geometric primitives - rectangles, rotated rectangles, triangles, circles, ellipses, rotated ellipses and lines are supported.
* Export generated shape data to JSON.
* Export geometrized images as SVGs.
* All Haxe targets are supported.

## Shape Comparison

The matrix shows typical results for circles, triangles, rotated rectangles, rotated ellipses and all supported shapes at 50, 200 and 500 total shapes:

| -                  | 50 Shapes     | 200 Shapes    | 500 Shapes   |
| ------------------ | ------------- | ------------- | ------------ |
| Circles            | [![50 Circles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_50_circles.png?raw=true)](https://www.geometrize.co.uk/) | [![200 Circles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_200_circles.png?raw=true)](https://www.geometrize.co.uk/) | [![500 Circles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_500_circles.png?raw=true)](https://www.geometrize.co.uk/) |
| Triangles          | [![50 Triangles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_50_triangles.png?raw=true)](https://www.geometrize.co.uk/) | [![200 Triangles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_200_triangles.png?raw=true)](https://www.geometrize.co.uk/) | [![500 Triangles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_500_triangles.png?raw=true)](https://www.geometrize.co.uk/) |
| Rotated Rectangles | [![50 Rotated Rectangles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_50_rotated_rectangles.png?raw=true)](https://www.geometrize.co.uk/) | [![200 Rotated Rectangles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_200_rotated_rectangles.png?raw=true)](https://www.geometrize.co.uk/) | [![500 Rotated Rectangles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_500_rotated_rectangles.png?raw=true)](https://www.geometrize.co.uk/) |
| Rotated Ellipses   | [![50 Rotated Ellipses](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_50_rotated_ellipses.png?raw=true)](https://www.geometrize.co.uk/) | [![200 Rotated Ellipses](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_200_rotated_ellipses.png?raw=true)](https://www.geometrize.co.uk/) | [![500 Rotated Ellipses](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_500_rotated_ellipses.png?raw=true)](https://www.geometrize.co.uk/) |
| All Shapes         | [![50 All Shapes](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_50_all_shapes.png?raw=true)](https://www.geometrize.co.uk/) | [![200 All Shapes](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_200_all_shapes.png?raw=true)](https://www.geometrize.co.uk/) | [![500 All Shapes](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/seagull_500_all_shapes.png?raw=true)](https://www.geometrize.co.uk/) |

## How It Works

A user provides a target image, and the algorithm finds shapes to approximate that image. To identify a good shape, the algorithm generates a large number of random candidate shapes, repeatedly improving the fit of each using a hillclimbing optimization approach, eventually choosing the best-fitting shape. The shapes are added one by one.

## Install

Get the [Haxe](https://haxe.org/) library from [GitHub](https://github.com/Tw1ddle/geometrize-haxe) or through [haxelib](https://lib.haxe.org/p/geometrize-haxe/).

## Usage

* Instantiate an ```ImageRunner```, passing it a ```Bitmap``` target image and a starting background ```Rgba``` color.
* Generate shapes by repeatedly calling ```runner.step(options)```, passing in your ```ImageRunnerOptions```.
* Export the results using the ```export``` methods on ```SvgExporter``` and ```ShapeJsonExporter```.

Refer to the library [documentation](https://tw1ddle.github.io/geometrize-haxe/). Also see the Geometrize Haxe [web demo](https://www.samcodes.co.uk/project/geometrize-haxe-web/) and [code](https://github.com/Tw1ddle/geometrize-haxe-web/), or this HaxeFlixel [example](https://samcodes.co.uk/project/geometrize-haxe-flixel/) and [code](https://github.com/Tw1ddle/geometrize-haxe-demo/).

## Resources

* See the Geometrize [resources](https://resources.geometrize.co.uk/) page.

## Examples And Screenshots

Geometrized public domain [artwork](https://commons.wikimedia.org/wiki/Category:Paintings_by_painter) and [photos](https://www.pexels.com/public-domain-images/):

[![Geometrized Flower 330 Rotated Ellipses](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/flower.png?raw=true "Flower - 330 Rotated Ellipses")](https://www.geometrize.co.uk/)
[![Geometrized Train 230 Rotated Ellipses](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/train.png?raw=true "Train - 230 Rotated Ellipses")](https://www.geometrize.co.uk/)
[![Geometrized Woodland Cemetery 600 Rotated Rectangles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/woodland_cemetery.png?raw=true "Woodland Cemetery - 600 Rotated Rectangles")](https://www.geometrize.co.uk/)
[![Geometrized Pomegranate 300 Rotated Ellipses](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/pomegranate.png?raw=true "Pomegranate - 300 Rotated Ellipses")](https://www.geometrize.co.uk/)
[![Geometrized Monarch Butterfly 800 Various Shapes](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/monarch_butterfly.png?raw=true "Monarch Butterfly - 800 Various Shapes")](https://www.geometrize.co.uk/)
[![Geometrized Leafy Railroad 800 Rotated Rectangles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/leafy_railroad.png?raw=true "Leafy Railroad - 800 Rotated Rectangles")](https://www.geometrize.co.uk/)
[![Geometrized Pyramid 150 Triangles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/pyramid.png?raw=true "Pyramid - 150 Triangles")](https://www.geometrize.co.uk/)
[![Geometrized Trees 210 Ellipses](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/tree_under_clouds.png?raw=true "Tree Under Clouds - 210 Ellipses")](https://www.geometrize.co.uk/)
[![Geometrized Chomsky 300 Triangles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/chomsky.png?raw=true "Noam Chomsky - 300 Triangles")](https://www.geometrize.co.uk/)
[![Geometrized Trees 250 Rotated Ellipses](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/trees.png?raw=true "Trees - 250 Rotated Ellipses")](https://www.geometrize.co.uk/)
[![Geometrized Fairies 500 Triangles](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/fairies.png?raw=true "Fairies - 500 Triangles")](https://www.geometrize.co.uk/)

For more examples, see the Geometrize [gallery](https://gallery.geometrize.co.uk/).

## Notes
* This implementation is single-threaded, and performance varies by target platform. Small target images work best.
* Got an idea or suggestion? Open an issue on GitHub, or send Sam a message on [Twitter](https://twitter.com/Sam_Twidale).
* Find more related projects and open source code [here](https://resources.geometrize.co.uk/).