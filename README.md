[![Project logo](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/logo.png?raw=true "Geometrize Haxe - recreating images as geometric shapes logo")](http://www.geometrize.co.uk/)

[![Haxelib Version](https://img.shields.io/github/tag/Tw1ddle/geometrize-haxe.svg?style=flat-square&label=haxelib)](http://lib.haxe.org/p/geometrize-haxe)
[![Travis Unit Test Build Status](https://img.shields.io/travis/Tw1ddle/geometrize-haxe-unit-tests.svg?style=flat-square)](https://travis-ci.org/Tw1ddle/geometrize-haxe-unit-tests)
[![Code Climate](https://img.shields.io/codeclimate/issues/github/Tw1ddle/geometrize-haxe.svg?style=flat-square)](https://codeclimate.com/github/Tw1ddle/geometrize-haxe/issues)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](https://github.com/Tw1ddle/geometrize-haxe/blob/master/LICENSE)

Geometrize Haxe is part of [Geometrize](http://www.geometrize.co.uk/), an app and tools for recreating images with geometric primitives. Run the demo [in your browser](http://www.samcodes.co.uk/project/geometrize-haxe-web/).

Geometrize Haxe is based on the [primitive](https://github.com/fogleman/primitive) Go library.

[![Geometrized Cat](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/cat.png?raw=true "Geometrized Cat - ~400 Geometric Primitives")](http://www.geometrize.co.uk/)

## Features
* Recreate images as geometric primitives - rectangles, triangles, circles, ellipses and lines are supported.
* Easily export geometrized images to SVG, and generated shape data to JSON.
* All Haxe targets are supported.

## How It Works

A user provides a target image, and the algorithm finds good shapes to approximate that image. To find a good shape, the algorithm generates a large number of random candidate shapes, repeatedly improving the fit of each using a hillclimbing optimization approach, eventually choosing the best fitting shape. Shapes are added one by one.

A detailed explanation of how the algorithm works is given in the primitive [readme](https://github.com/fogleman/primitive/blob/master/README.md#how-it-works-part-ii).

## Install

Get the [Haxe](https://haxe.org/) library from [GitHub](https://github.com/Tw1ddle/geometrize-haxe) or through [haxelib](http://lib.haxe.org/p/geometrize-haxe/).

## Usage

* Instantiate an ```ImageRunner```, passing it a ```Bitmap``` target image and a starting background ```Rgba``` color.
* Generate shapes by repeatedly calling ```runner.step(options)```, passing in your ```ImageRunnerOptions```.
* Export the results using the ```export``` methods on ```SvgExporter``` and ```ShapeJsonExporter```.

Refer to the library [documentation](http://tw1ddle.github.io/geometrize-haxe/). Also see the Geometrize Haxe [web demo](http://www.samcodes.co.uk/project/geometrize-haxe-web/) and [code](https://github.com/Tw1ddle/geometrize-haxe-web/), or this HaxeFlixel [example](http://samcodes.co.uk/project/geometrize-haxe-flixel/) and [code](https://github.com/Tw1ddle/geometrize-haxe-demo/).

## Resources

* See the Geometrize [resources](http://resources.geometrize.co.uk/) page.

## Examples And Screenshots

Geometrized public domain [artwork](https://commons.wikimedia.org/wiki/Category:Paintings_by_painter) and [photos](https://www.pexels.com/public-domain-images/):

[![Geometrized Leafy Railroad - 800 Rotated Rectangles](https://github.com/Tw1ddle/geometrize-haxe-web/blob/master/screenshots/leafy_railroad.png?raw=true "Leafy Railroad - 800 Rotated Rectangles")](http://www.geometrize.co.uk/)
[![Geometrized Flower - 330 Rotated Ellipses](https://github.com/Tw1ddle/geometrize-haxe-web/blob/master/screenshots/flower.png?raw=true "Flower - 330 Rotated Ellipses")](http://www.geometrize.co.uk/)
[![Geometrized Woodland Cemetery - 600 Rotated Rectangles](https://github.com/Tw1ddle/geometrize-haxe-web/blob/master/screenshots/woodland_cemetery.png?raw=true "Woodland Cemetery - 600 Rotated Rectangles")](http://www.geometrize.co.uk/)
[![Geometrized Pomegranate - 300 Rotated Ellipses](https://github.com/Tw1ddle/geometrize-haxe-web/blob/master/screenshots/pomegranate.png?raw=true "Pomegranate - 300 Rotated Ellipses")](http://www.geometrize.co.uk/)
[![Geometrized Monarch Butterfly - 800 Various Shapes](https://github.com/Tw1ddle/geometrize-haxe-web/blob/master/screenshots/monarch_butterfly.png?raw=true "Monarch Butterfly - 800 Various Shapes")](http://www.geometrize.co.uk/)
[![Geometrized Fairies - 500 Triangles](https://github.com/Tw1ddle/geometrize-haxe-web/blob/master/screenshots/fairies.png?raw=true "Fairies - 500 Triangles")](http://www.geometrize.co.uk/)
[![Geometrized Pyramid - 150 Triangles](https://github.com/Tw1ddle/geometrize-haxe-web/blob/master/screenshots/pyramid.png?raw=true "Pyramid - 150 Triangles")](http://www.geometrize.co.uk/)
[![Geometrized Chomsky - 300 Triangles](https://github.com/Tw1ddle/geometrize-haxe-web/blob/master/screenshots/chomsky.png?raw=true "Noam Chomsky - 300 Triangles")](http://www.geometrize.co.uk/)
[![Geometrized Mixed Peppers - 300 Rotated Ellipses](https://github.com/Tw1ddle/geometrize-haxe-web/blob/master/screenshots/mixed_peppers.png?raw=true "Mixed Peppers - 300 Rotated Ellipses")](http://www.geometrize.co.uk/)

For more examples, see the Geometrize [gallery](http://gallery.geometrize.co.uk/).

## Notes
* This implementation is single-threaded, and performance varies by target platform. Small target images work best.
* Got an idea or suggestion? Open an issue on GitHub, or send Sam a message on [Twitter](https://twitter.com/Sam_Twidale).
* Geometrize Haxe is available as a [haxelib](https://lib.haxe.org/p/geometrize-haxe).
* Find more code related to Geometrize [here](http://resources.geometrize.co.uk/).