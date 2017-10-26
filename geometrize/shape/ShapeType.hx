package geometrize.shape;

/**
 * Enumeration specifying the types of shapes that can be used. These can be combined to produce images composed of multiple shape types.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
@:enum abstract ShapeType(Int) {
	public var RECTANGLE = 0;
	public var ROTATED_RECTANGLE = 1;
	public var TRIANGLE = 2;
	public var ELLIPSE = 3;
	public var ROTATED_ELLIPSE = 4;
	public var CIRCLE = 5;
	public var LINE = 6;
}