[![Project logo](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/logo.png?raw=true "Geometrize Haxe recreating images as geometric shapes logo")](http://tw1ddle.github.io/geometrize-haxe-demo/)

**Geometrize Haxe** is a cross-platform Haxe library for recreating images with geometric primitives. Try the online demo [here](http://tw1ddle.github.io/geometrize-haxe-demo/).

Geometrize Haxe is a port of [primitive](https://github.com/fogleman/primitive).

[![The Lady of Shalott](https://github.com/Tw1ddle/geometrize-haxe/blob/master/screenshots/the_lady_of_shalott_waterhouse.jpg?raw=true "The Lady of Shalott as circles")](https://github.com/Tw1ddle/geometrize-haxe-demo/)

## How It Works

The algorithm finds shapes that make a *current image* closely resemble a *target image*. The user provides a *target image* to recreate with shapes. To add a shape, the algorithm randomly generates a large number of candidate shapes, repeatedly improves the fit of these candidates by mutating them in a hillclimbing optimization approach, and chooses the best fitting shape. A full explanation is provided [here](https://github.com/fogleman/primitive/blob/master/README.md#how-it-works-part-ii).

## Usage

Try the live [demo](http://tw1ddle.github.io/geometrize-haxe-demo/), check the [demo code](https://github.com/Tw1ddle/geometrize-haxe-demo/), and read the library [documentation](http://tw1ddle.github.io/geometrize-haxe/).

This implementation is single-threaded and performance will vary by target platform, so small target images are recommended - you probably do not need the detail anyway.

## Install

```
haxelib install geometrize-haxe
```

## Notes
* Got an idea or suggestion? Open an issue on GitHub, or send Sam a message on [Twitter](https://twitter.com/Sam_Twidale).
* Geometrize Haxe is based on [primitive](https://github.com/fogleman/primitive), a Go library created by [Michael Fogleman](https://github.com/fogleman).
* Geometrize Haxe is available as a [haxelib](https://lib.haxe.org/p/geometrize-haxe).
* All Haxe targets are supported.
