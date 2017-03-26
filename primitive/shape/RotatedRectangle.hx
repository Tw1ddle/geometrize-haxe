package primitive.shape;

/**
 * A rotated rectangle.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class RotatedRectangle implements Shape {
	public var x(default, null):Int;
	public var y(default, null):Int;
	public var sx(default, null):Int;
	public var sy(default, null):Int;
	public var angle(default, null):Int;
	
	public function new(xBound:Int, yBound:Int) {
		// TODO
	}
	
	public function rasterize():Array<Scanline> {
		return []; // TODO
	}
	
	public function mutate():Void {
		// TODO
	}
	
	public function clone():Shape {
		return null; // TODO
	}
}