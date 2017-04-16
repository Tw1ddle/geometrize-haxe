[![Project logo](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/logo.png?raw=true "Geometrize Haxe - recreating images as geometric shapes logo")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)

**Geometrize Haxe** is a Haxe library for recreating images with geometric primitives. Run the web demo [in your browser](http://www.samcodes.co.uk/project/geometrize-haxe-web/).

The Geometrize Haxe library is based on [primitive](https://github.com/fogleman/primitive).

[![Geometrized Peacock](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/peacock.jpg?raw=true "Peacock")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)

## Features
* Recreate images as shapes - any combination of rectangles, rotated rectangles, triangles, circles, ellipses, rotated ellipses and lines are supported.
* Easily export geometrized images to SVG, or generated shape data to JSON.
* All Haxe targets are supported.

## Usage

Try the Geometrize [web demo](http://tw1ddle.github.io/geometrize-haxe-web/) and read the [code](http://www.samcodes.co.uk/project/geometrize-haxe-web/), or the HaxeFlixel [demo](http://tw1ddle.github.io/geometrize-haxe-demo/) and [code](https://github.com/Tw1ddle/geometrize-haxe-demo/). Then read the library [documentation](http://tw1ddle.github.io/geometrize-haxe/).

Basic usage: instantiate an ```ImageRunner```, passing it a ```Bitmap``` and starting background ```Rgba``` color. Add shapes by repeatedly calling ```runner.step(options)``` method, passing in your ```ImageRunnerOptions```.

## Install

Get the Haxe library from [GitHub](https://github.com/Tw1ddle/geometrize-haxe) or through [haxelib](http://lib.haxe.org/p/geometrize-haxe/).

Include it in your ```.hxml```
```
-lib geometrize-haxe
```

Or add it to your ```Project.xml```:
```
<haxelib name="geometrize-haxe" />
```

## How It Works

A user provides a *target image*, and the algorithm finds good shapes to approximate that image, adding shapes one by one. To find a shape to add, the algorithm generates a large number of random candidate shapes, repeatedly improving the fit of each using a hillclimbing optimization approach, eventually choosing the best fitting shape. A full explanation of the core algorithm is given [here](https://github.com/fogleman/primitive/blob/master/README.md#how-it-works-part-ii).

## Resources

* See the Geometrize [resources](https://github.com/Tw1ddle/geometrize-resources) and [template](https://github.com/Tw1ddle/geometrize-templates) repositories.
* See the Geometrize [haxelib code](https://github.com/Tw1ddle/geometrize-haxe) and library [documentation](http://tw1ddle.github.io/geometrize-haxe/).
* See the Geometrize [web demo](http://www.samcodes.co.uk/project/geometrize-haxe-web/) and web [demo code](https://github.com/Tw1ddle/geometrize-haxe-web/).
* See the HaxeFlixel Geometrize [demo](http://tw1ddle.github.io/geometrize-haxe-demo/) and the [demo code](https://github.com/Tw1ddle/geometrize-haxe-demo/).
* See the Primitive Go [repository](https://github.com/fogleman/primitive).

## Examples And Screenshots

[![Geometrized Swan](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/swan.jpg?raw=true "Swan")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Cat](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/cat.jpg?raw=true "Cat")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Figs](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/figs.jpg?raw=true "figs")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Gustave Courbet](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/gustave_courbet.jpg?raw=true "Gustave Courbet")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Leafy Railroad](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/leafy_railroad.jpg?raw=true "Leafy Railroad")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Road](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/road.jpg?raw=true "Road")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Sunflower](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/sunflower.jpg?raw=true "Sunflower")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Woodland Cemetery](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/woodland_cemetery.jpg?raw=true "Woodland Cemetery")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Pomegranate](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/pomegranate.jpg?raw=true "Pomegranate")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Monarch Butterfly](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/monarch_butterfly.jpg?raw=true "Monarch Butterfly")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Fairies](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/fairies.jpg?raw=true "Fairies")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Pyramid](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/pyramid.jpg?raw=true "Pyramid")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)
[![Geometrized Chomsky](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/chomsky.jpg?raw=true "Noam Chomsky")](http://www.samcodes.co.uk/project/geometrize-haxe-web/)

## Notes
* This implementation is single-threaded, and performance varies by target platform. Small target images are recommended - you probably do not need the detail anyway.
* Got an idea or suggestion? Open an issue on GitHub, or send Sam a message on [Twitter](https://twitter.com/Sam_Twidale).
* Geometrize Haxe is based on [primitive](https://github.com/fogleman/primitive), a Go library created by [Michael Fogleman](https://github.com/fogleman).
* Geometrize Haxe is available as a [haxelib](https://lib.haxe.org/p/geometrize-haxe).
* All Haxe targets are supported.