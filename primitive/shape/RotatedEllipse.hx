package primitive.shape;

import primitive.Scanline;

/**
 * A rotated ellipse.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class RotatedEllipse implements Shape {
	public var x(default, null):Float;
	public var y(default, null):Float;
	public var rx(default, null):Float;
	public var ry(default, null):Float;
	public var angle(default, null):Float;
	
	/**
	 * The x-bound of the whole canvas.
	 */
	public var xBound(default, null):Int;
	/**
	 * The y-bound of the whole canvas.
	 */
	public var yBound(default, null):Int;
	
	public function new(xBound:Int, yBound:Int) {
		x = Std.random(xBound);
		y = Std.random(yBound);
		rx = Std.random(32) + 1;
		ry = Std.random(32) + 1;
		angle = Std.random(361);
		
		this.xBound = xBound;
		this.yBound = yBound;
	}
	
	public function rasterize():Array<Scanline> {
		var lines:Array<Scanline> = [];
		
		var n:Int = 16;
		for (i in 0...n) {
			var p1:Float = i / n;
			var p2:Float = (i + 1) / n;
			var a1 = p1 * 2 * Math.PI;
			var a2 = p2 * 2 * Math.PI;
			var x0 = rx * Math.cos(a1);
			var y0 = ry * Math.sin(a1);
			var x1 = rx * Math.cos(a1 + (a2 - a1) / 2);
			var y1 = ry * Math.sin(a1 + (a2 - a1) / 2);
			var x2 = rx * Math.cos(a2);
			var y2 = ry * Math.sin(a2);
			var cx = 2 * x1 - x0 / 2 - x2 / 2;
			var cy = 2 * y1 - y0 / 2 - y2 / 2;
			
			// TODO
		}
		
		return lines;
	}
	
	public function mutate():Void {
		// TODO
		/*
		var r = Std.random(3);
		switch(r) {
			case 0:
				x = Util.clamp(x + Util.random(-16, 16), 0, xBound - 1);
				y = Util.clamp(y + Util.random(-16, 16), 0, yBound - 1);
			case 1:
				rx = Util.clamp(rx + Util.random(-16, 16), 1, xBound - 1);
				ry = Util.clamp(ry + Util.random(-16, 16), 1, xBound - 1);
			case 2:
				angle += Util.random(-16, 16);
		}
		*/
	}
	
	public function clone():Shape {
		var ellipse = new RotatedEllipse(xBound, yBound);
		
		// TODO
		
		return ellipse;
	}
}