package primitive.shape;

/**
 * A triangle.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class Triangle implements Shape {
	public var x1(default, null):Int;
	public var y1(default, null):Int;
	public var x2(default, null):Int;
	public var y2(default, null):Int;
	public var x3(default, null):Int;
	public var y3(default, null):Int;
	
	/**
	 * The x-bound of the whole canvas.
	 */
	public var xBound(default, null):Int;
	/**
	 * The y-bound of the whole canvas.
	 */
	public var yBound(default, null):Int;
	
	public function new(xBound:Int, yBound:Int) {
		x1 = Std.random(xBound);
		y1 = Std.random(yBound);
		x2 = x1 + Util.random(-16, 16);
		y2 = y1 + Util.random(-16, 16);
		x3 = x1 + Util.random(-16, 16);
		y3 = y1 + Util.random(-16, 16);
		
		this.xBound = xBound;
		this.yBound = yBound;
	}
	
	public function rasterize():Array<Scanline> {
		return []; // TODO
	}
	
	public function mutate():Void {
		// TODO
	}
	
	public function clone():Shape {
		var triangle:Triangle = new Triangle(xBound, yBound);
		triangle.x1 = x1;
		triangle.y1 = y1;
		triangle.x2 = x2;
		triangle.y2 = y2;
		triangle.x3 = x3;
		triangle.y3 = y3;
		return triangle;
	}
}