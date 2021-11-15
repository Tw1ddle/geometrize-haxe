#!/bin/bash

# This batch file generates the documentation for Geometrize Haxe.

# Clean the generated documentation folder, to remove any old documentation.
rm -rf "generated_docs"

# Delete any existing generated XML-format type information.
rm -f types.xml

# Build the XML-format type information.
haxe build.hxml

# Generate the documentation.
haxelib run dox -i types.xml -theme ./themes/samcodes --title "Geometrize API" -D version 1.0.3 --include "(geometrize)" -o generated_docs