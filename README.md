[![Project logo](https://github.com/Tw1ddle/primitive-haxe/blob/master/screenshots/logo.png?raw=true "Primitive Haxe recreating images as geometric primitives logo")](http://tw1ddle.github.io/primitive-haxe-demo/)

**Primitive Haxe** is a cross-platform Haxe library for recreating images with geometric primitives. Try the online demo [here](http://tw1ddle.github.io/primitive-haxe-demo/).

Primitive Haxe is a partial port of the [primitive](https://github.com/fogleman/primitive) Go library.

## How It Works

The algorithm finds shapes that make a *current image* closely resemble a *target image*. First, the user provides a *target image* that to recreate with shapes. To add a shape, the algorithm randomly generates many candidate shapes, repeatedly improves the fit of these candidates using a hillclimbing optimization approach, choosing the best candidate found. A full explanation is provided [here](https://github.com/fogleman/primitive/blob/master/README.md#how-it-works-part-ii).

## Usage

Try the live [demo](http://tw1ddle.github.io/primitive-haxe-demo/), check the [demo code](https://github.com/Tw1ddle/primitive-haxe-demo/), and read the library [documentation](http://tw1ddle.github.io/primitive-haxe/).

This implementation is single-threaded and performance will vary by target platform, so small target images are recommended - you probably do not need the detail anyway.

## Install

```
haxelib install primitive-haxe
```

## Notes
* Got an idea or suggestion? Open an issue on GitHub, or send a message to Sam's [Twitter](https://twitter.com/Sam_Twidale).
* Primitive Haxe is based on [primitive](https://github.com/fogleman/primitive), a Go library created by [Michael Fogleman](https://github.com/fogleman).
* Primitive Haxe is available as a [haxelib](https://lib.haxe.org/p/primitive-haxe).
* All Haxe targets are supported.

## Screenshots

[![The Lady of Shalott](https://github.com/Tw1ddle/primitive-haxe/blob/master/screenshots/the_lady_of_shalott_waterhouse.jpg?raw=true "The Lady of Shalott as circles")](https://github.com/Tw1ddle/primitive-haxe-demo/)
