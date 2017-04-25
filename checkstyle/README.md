# Geometrize Haxe Coding Standard

The bundled Haxe Checkstyle configuration provides a coding standard for the Geometrize Haxe library.

## Setup

```
haxelib install checkstyle
```

## Usage

Open and build the FlashDevelop projects in this directory to get an interactive error report with highlighting. Alternatively, run Checkstyle in console:

```
haxelib run checkstyle -s ../geometrize -c ../checkstyle_config.json
```

## Tips
* Run Checkstyle as a post-build step or as a compile-on-save option. This makes adhering to the coding standard less demanding.