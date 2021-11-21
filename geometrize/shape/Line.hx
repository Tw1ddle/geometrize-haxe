package geometrize.shape;

import geometrize.rasterizer.Scanline;
import geometrize.rasterizer.Rasterizer;
import geometrize.exporter.SvgExporter;

/**
 * A line.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class Line implements Shape {
	public var x1:Int;
	public var y1:Int;
	public var x2:Int;
	public var y2:Int;
	
	public var xBound(default, null):Int;
	public var yBound(default, null):Int;
	
	public function new(xBound:Int, yBound:Int) {
		x1 = Std.random(xBound);
		y1 = Std.random(yBound);
		x2 = Util.clamp(x1 + Std.random(32) + 1, 0, xBound);
		y2 = Util.clamp(y1 + Std.random(32) + 1, 0, yBound);
		
		this.xBound = xBound;
		this.yBound = yBound;
	}
	
	public function rasterize():Array<Scanline> {
		var lines:Array<Scanline> = [];
		
		var points = Rasterizer.bresenham(x1, y1, x2, y2);
		for (point in points) {
			lines.push(new Scanline(point.y, point.x, point.x));
		}
		
		return Scanline.trim(lines, xBound, yBound);
	}
	
	public function mutate():Void {
		var r = Std.random(4);
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
		var line = new Line(xBound, yBound);
		line.x1 = x1;
		line.y1 = y1;
		line.x2 = x2;
		line.y2 = y2;
		return line;
	}
	
	public function getType():ShapeType {
		return ShapeType.LINE;
	}
	
	public function getRawShapeData():Array<Float> {
		return [ x1, y1, x2, y2 ];
	}
	
	public function getSvgShapeData():String {
		return "<line x1=\"" + x1 + "\" y1=\"" + y1 + "\" x2=\"" + x2 + "\" y2=\"" + y2 + "\" " + SvgExporter.SVG_STYLE_HOOK + " />";
	}
}