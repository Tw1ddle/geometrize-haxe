package geometrize.shape;

/**
 * Helper class for creating shapes.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class ShapeFactory {
	/**
	 * Creates a new shape of the specified type.
	 * @param	type	The type of shape to create.
	 * @param	xBound	The x-bound of the whole canvas.
	 * @param	yBound	The y-bound of the whole canvas.
	 * @return	The new shape.
	 */
	public static function create(type:ShapeType, xBound:Int, yBound:Int):Shape {
		return switch (type) {
			case RECTANGLE:
				return new Rectangle(xBound, yBound);
			case ROTATED_RECTANGLE:
				return new RotatedRectangle(xBound, yBound);
			case TRIANGLE:
				return new Triangle(xBound, yBound);
			case ELLIPSE:
				return new Ellipse(xBound, yBound);
			case ROTATED_ELLIPSE:
				return new RotatedEllipse(xBound, yBound);
			case CIRCLE:
				return new Circle(xBound, yBound);
			case LINE:
				return new Line(xBound, yBound);
			case QUADRATIC_BEZIER:
				return new QuadraticBezier(xBound, yBound);
		}
	}
	
	/**
	 * Creates a new random shape.
	 * @param	xBound	The x-bound of the whole canvas.
	 * @param	yBound	The y-bound of the whole canvas.
	 * @return	The new shape.
	 */
	public static function randomShape(xBound:Int, yBound:Int):Shape {
		return create(Util.randomArrayItem(AbstractEnumTools.getValues(ShapeType)), xBound, yBound);
	}
	
	/**
	 * Creates a random shape from the types supplied.
	 * @param	types	The types of shape to possibly create.
	 * @param	xBound	The x-bound of the whole canvas.
	 * @param	yBound	The y-bound of the whole canvas.
	 * @return	The new shape.
	 */
	public static function randomShapeOf(types:Array<ShapeType>, xBound:Int, yBound:Int):Shape {
		return create(Util.randomArrayItem(types), xBound, yBound);
	}
}