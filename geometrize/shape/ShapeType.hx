package geometrize.shape;

/**
 * Enumeration specifying the types of shapes that can be used. These can be combined to produce images composed of multiple shape types.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
@:enum abstract ShapeType(Int) {
	var RECTANGLE = 0;
	var ROTATED_RECTANGLE = 1;
	var TRIANGLE = 2;
	var ELLIPSE = 3;
	var ROTATED_ELLIPSE = 4;
	var CIRCLE = 5;
	var LINE = 6;
}