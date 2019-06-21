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

/**
 * Collection of shape type constants to expose to JavaScript code.
 */
@:expose
class ShapeTypes {
	public static inline var RECTANGLE = ShapeType.RECTANGLE;
	public static inline var ROTATED_RECTANGLE = ShapeType.ROTATED_RECTANGLE;
	public static inline var TRIANGLE = ShapeType.TRIANGLE;
	public static inline var ELLIPSE = ShapeType.ELLIPSE;
	public static inline var ROTATED_ELLIPSE = ShapeType.ROTATED_ELLIPSE;
	public static inline var CIRCLE = ShapeType.CIRCLE;
	public static inline var LINE = ShapeType.LINE;
}