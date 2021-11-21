package geometrize.shape;

/**
 * Enumeration specifying the types of shapes that can be used. These can be combined to produce images composed of multiple shape types.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
@:enum abstract ShapeType(Int) from Int to Int {
	public var RECTANGLE = 0;
	public var ROTATED_RECTANGLE = 1;
	public var TRIANGLE = 2;
	public var ELLIPSE = 3;
	public var ROTATED_ELLIPSE = 4;
	public var CIRCLE = 5;
	public var LINE = 6;
	public var QUADRATIC_BEZIER = 7;
}

/**
 * Collection of shape type constants to expose to JavaScript code.
 */
@:expose
class ShapeTypes {
	public static inline var RECTANGLE:Int = ShapeType.RECTANGLE;
	public static inline var ROTATED_RECTANGLE:Int = ShapeType.ROTATED_RECTANGLE;
	public static inline var TRIANGLE:Int = ShapeType.TRIANGLE;
	public static inline var ELLIPSE:Int = ShapeType.ELLIPSE;
	public static inline var ROTATED_ELLIPSE:Int = ShapeType.ROTATED_ELLIPSE;
	public static inline var CIRCLE:Int = ShapeType.CIRCLE;
	public static inline var LINE:Int = ShapeType.LINE;
	public static inline var QUADRATIC_BEZIER:Int = ShapeType.QUADRATIC_BEZIER;
}