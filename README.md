[![Project logo](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/logo.png?raw=true "Geometrize Haxe - recreating images as geometric shapes logo")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)

**Geometrize Haxe** is a Haxe library for recreating images with geometric primitives. Run the web demo [in your browser](http://www.samcodes.co.uk/project/geometrize-haxe-web/).

The Geometrize Haxe [haxelib](https://lib.haxe.org/p/geometrize-haxe) is based on the [primitive](https://github.com/fogleman/primitive) Go library.

[![Geometrized Cat](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/cat.jpg?raw=true "Geometrized Cat - ~200 Triangles")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)

## Features
* Recreate images as shapes - combinations of rectangles, rotated rectangles, triangles, circles, ellipses, rotated ellipses and lines are supported.
* Easily export geometrized images to SVG, or generated shape data to JSON.
* All Haxe targets are supported.

## Install

Get the Haxe library from [GitHub](https://github.com/Tw1ddle/geometrize-haxe) or through [haxelib](http://lib.haxe.org/p/geometrize-haxe/).

Include it in your project ```.hxml```
```
-lib geometrize-haxe
```

Or add it to your ```Project.xml```:
```
<haxelib name="geometrize-haxe" />
```

## Usage

See the Geometrize Haxe [web demo](http://www.samcodes.co.uk/project/geometrize-haxe-web/) and [code](http://www.samcodes.co.uk/project/geometrize-haxe-web/), and this HaxeFlixel [example](http://tw1ddle.github.io/geometrize-haxe-demo/) and [code](https://github.com/Tw1ddle/geometrize-haxe-demo/). Also read the library [documentation](http://tw1ddle.github.io/geometrize-haxe/).

Basic usage: instantiate an ```ImageRunner```, pass it a ```Bitmap``` and starting background ```Rgba``` color. Add shapes by repeatedly calling ```runner.step(options)```, passing your ```ImageRunnerOptions```. Export the results using the ```export``` methods of ```SvgExporter``` and ```ShapeJsonExporter```.

## How It Works

A user provides a target image, and the algorithm finds good shapes to approximate that image. To find a good shape, the algorithm generates a large number of random candidate shapes, repeatedly improving the fit of each using a hillclimbing optimization approach, eventually choosing the best fitting shape. Shapes are added one by one.

A detailed explanation of how the algorithm works is given in the primitive [readme](https://github.com/fogleman/primitive/blob/master/README.md#how-it-works-part-ii).

## Resources

* See the Geometrize [resources](https://github.com/Tw1ddle/geometrize-resources) and [template](https://github.com/Tw1ddle/geometrize-templates) repositories.
* See the Geometrize [haxelib code](https://github.com/Tw1ddle/geometrize-haxe) and library [documentation](http://tw1ddle.github.io/geometrize-haxe/).
* See the Geometrize [web demo](http://www.samcodes.co.uk/project/geometrize-haxe-web/) and web [demo code](https://github.com/Tw1ddle/geometrize-haxe-web/).
* See the HaxeFlixel Geometrize [demo](http://tw1ddle.github.io/geometrize-haxe-demo/) and the [demo code](https://github.com/Tw1ddle/geometrize-haxe-demo/).
* See the Primitive Go [repository](https://github.com/fogleman/primitive).

## Examples And Screenshots

There is no jagginess when saving images as vector-based SVG e.g. [pyramid](https://gist.github.com/Tw1ddle/31f211f0ae13af49302dc283a74522c3) or [pomegranate](https://gist.github.com/Tw1ddle/817fcef96c81ad5d2ece3a21b2aea124).

Examples from geometrizing public domain [artwork](https://commons.wikimedia.org/wiki/Category:Paintings_by_painter) and [photos](https://www.pexels.com/public-domain-images/):

[![Geometrized Swan](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/swan.jpg?raw=true "Swan")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Peacock](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/peacock.jpg?raw=true "Peacock")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Leafy Railroad](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/leafy_railroad.jpg?raw=true "Leafy Railroad")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Road](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/road.jpg?raw=true "Road")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Sunflower](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/sunflower.jpg?raw=true "Sunflower")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Woodland Cemetery](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/woodland_cemetery.jpg?raw=true "Woodland Cemetery")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Figs](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/figs.jpg?raw=true "figs")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Pomegranate](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/pomegranate.jpg?raw=true "Pomegranate")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Monarch Butterfly](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/monarch_butterfly.jpg?raw=true "Monarch Butterfly")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Gustave Courbet](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/gustave_courbet.jpg?raw=true "Gustave Courbet")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Fairies](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/fairies.jpg?raw=true "Fairies")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Pyramid](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/pyramid.jpg?raw=true "Pyramid")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Chomsky](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/chomsky.jpg?raw=true "Noam Chomsky")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)

## Notes
* This implementation is single-threaded, and performance varies by target platform. Small target images are recommended - you probably do not need the detail anyway.
* Got an idea or suggestion? Open an issue on GitHub, or send Sam a message on [Twitter](https://twitter.com/Sam_Twidale).
* Geometrize Haxe is based on [primitive](https://github.com/fogleman/primitive), a Go library created by [Michael Fogleman](https://github.com/fogleman).
* Geometrize Haxe is available as a [haxelib](https://lib.haxe.org/p/geometrize-haxe).
* All Haxe targets are supported.