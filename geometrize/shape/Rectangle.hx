package geometrize.shape;

import geometrize.rasterizer.Scanline;
import geometrize.exporter.SvgExporter;

/**
 * A rectangle.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class Rectangle implements Shape {
	public var x1:Int;
	public var y1:Int;
	public var x2:Int;
	public var y2:Int;
	
	public var xBound(default, null):Int;
	public var yBound(default, null):Int;
	
	public function new(xBound:Int, yBound:Int) {
		x1 = Std.random(xBound);
		y1 = Std.random(yBound);
		x2 = Util.clamp(x1 + Std.random(32) + 1, 0, xBound - 1);
		y2 = Util.clamp(y1 + Std.random(32) + 1, 0, yBound - 1);
		
		this.xBound = xBound;
		this.yBound = yBound;
	}
	
	public function rasterize():Array<Scanline> {
		var lines:Array<Scanline> = [];
		var yMin:Int = Util.min(y1, y2);
		var yMax:Int = Util.max(y1, y2);
		if (yMin == yMax) {
			lines.push(new Scanline(yMin, Util.min(x1, x2), Util.max(x1, x2)));
		} else {
			for (y in yMin...yMax) {
				lines.push(new Scanline(y, Util.min(x1, x2), Util.max(x1, x2)));
			}
		}
		return lines;
	}
	
	public function mutate():Void {
		var r = Std.random(2);
		switch (r) {
			case 0:
				x1 = Util.clamp(x1 + Util.random(-16, 16), 0, xBound - 1);
				y1 = Util.clamp(y1 + Util.random(-16, 16), 0, yBound - 1);
			case 1:
				x2 = Util.clamp(x2 + Util.random(-16, 16), 0, xBound - 1);
				y2 = Util.clamp(y2 + Util.random(-16, 16), 0, yBound - 1);
		}
	}
	
	public function clone():Shape {
		var rectangle = new Rectangle(xBound, yBound);
		rectangle.x1 = x1;
		rectangle.y1 = y1;
		rectangle.x2 = x2;
		rectangle.y2 = y2;
		return rectangle;
	}
	
	public function getType():ShapeType {
		return ShapeType.RECTANGLE;
	}
	
	public function getRawShapeData():Array<Float> {
		return [ Util.min(x1, x2), Util.min(y1, y2), Util.max(x1, x2), Util.max(y1, y2) ];
	}
	
	public function getSvgShapeData():String {
		return "<rect x=\"" + Util.min(x1, x2) + "\" y=\"" + Util.min(y1, y2) + "\" width=\"" + (Util.max(x1, x2) - Util.min(x1, x2)) + "\" height=\"" + (Util.max(y1, y2) - Util.min(y1, y2)) + "\" " + SvgExporter.SVG_STYLE_HOOK + " />";
	}
}