package geometrize.shape;

import geometrize.exporter.SvgExporter;
import geometrize.rasterizer.Scanline;

/**
 * An ellipse.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class Ellipse implements Shape {
	public var x:Int;
	public var y:Int;
	public var rx:Int;
	public var ry:Int;
	
	public var xBound(default, null):Int;
	public var yBound(default, null):Int;
	
	public function new(xBound:Int, yBound:Int) {
		x = Std.random(xBound);
		y = Std.random(yBound);
		rx = Std.random(32) + 1;
		ry = Std.random(32) + 1;
		
		this.xBound = xBound;
		this.yBound = yBound;
	}
	
	public function rasterize():Array<Scanline> {
		var lines:Array<Scanline> = [];
		var aspect:Float = rx / ry;
		
		var w:Int = xBound;
		var h:Int = yBound;
		
		for (dy in 0...ry) {
			var y1:Int = y - dy;
			var y2:Int = y + dy;
			if ((y1 < 0 || y1 >= h) && (y2 < 0 || y2 >= h)) {
				continue;
			}
			var s:Int = Std.int(Math.sqrt(ry * ry - dy * dy) * aspect);
			var x1:Int = x - s;
			var x2:Int = x + s;
			if (x1 < 0) {
				x1 = 0;
			}
			if (x2 >= w) {
				x2 = w - 1;
			}
			if (y1 >= 0 && y1 < h) {
				lines.push(new Scanline(y1, x1, x2));
			}
			if (y2 >= 0 && y2 < h && dy > 0) {
				lines.push(new Scanline(y2, x1, x2));
			}
		}
		
		return lines;
	}
	
	public function mutate():Void {
		var r = Std.random(3);
		switch (r) {
			case 0:
				x = Util.clamp(x + Util.random(-16, 16), 0, xBound - 1);
				y = Util.clamp(y + Util.random(-16, 16), 0, yBound - 1);
			case 1:
				rx = Util.clamp(rx + Util.random(-16, 16), 1, xBound - 1);
			case 2:
				ry = Util.clamp(ry + Util.random(-16, 16), 1, xBound - 1);
		}
	}
	
	public function clone():Shape {
		var ellipse = new Ellipse(xBound, yBound);
		ellipse.x = x;
		ellipse.y = y;
		ellipse.rx = rx;
		ellipse.ry = ry;
		return ellipse;
	}
	
	public function getType():ShapeType {
		return ShapeType.ELLIPSE;
	}
	
	public function getRawShapeData():Array<Float> {
		return [ x, y, rx, ry ];
	}
	
	public function getSvgShapeData():String {
		return "<ellipse cx=\"" + x + "\" cy=\"" + y + "\" rx=\"" + rx + "\" ry=\"" + ry + "\" " + SvgExporter.SVG_STYLE_HOOK + " />";
	}
}