package geometrize.shape;

import geometrize.Util.Point;
import geometrize.rasterizer.Scanline;
import geometrize.rasterizer.Rasterizer;
import geometrize.exporter.SvgExporter;

/**
 * A quadratic bezier curve.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class QuadraticBezier implements Shape {
	public var cx:Int;
	public var cy:Int;
	public var x1:Int;
	public var y1:Int;
	public var x2:Int;
	public var y2:Int;

	public var xBound(default, null):Int;
	public var yBound(default, null):Int;
	
	public function new(xBound:Int, yBound:Int) {
		x1 = Util.random(0, xBound - 1);
		y1 = Util.random(0, yBound - 1);
		cx = Util.random(0, xBound - 1);
		cy = Util.random(0, yBound - 1);
		x2 = Util.random(0, xBound - 1);
		y2 = Util.random(0, yBound - 1);
		
		this.xBound = xBound;
		this.yBound = yBound;
	}
	
	public function rasterize():Array<Scanline> {
		var lines:Array<Scanline> = [];
		var points:Array<Point> = [];
		var pointCount:Int = 20;
		
		for (i in 0...pointCount - 1) {
			var t:Float = i / pointCount;
			var tp:Float = 1 - t;
			var x:Int = Std.int(tp * (tp * x1 + (t * cx)) + t * ((tp * cx) + (t * x2)));
			var y:Int = Std.int(tp * (tp * y1 + (t * cy)) + t * ((tp * cy) + (t * y2)));
			points.push({ x: x, y : y });
		}
		
		for (i in 0...points.length - 1) {
			var p0 = points[i];
			var p1 = points[i + 1];
			
			var pts:Array<Point> = Rasterizer.bresenham(p0.x, p0.y, p1.x, p1.y);
			for (point in pts) {
				// Hack that should avoid overlapping pixels, don't add the next point if it's the same as the most-recently added one
				if (lines.length > 0) {
					var lastLine:Scanline = lines[lines.length - 1];
					if (lastLine.y == point.y && lastLine.x1 == point.x && lastLine.x2 == point.x) {
						continue;
					}
				}
				lines.push(new Scanline(point.y, point.x, point.x));
			}
		}
		
		return Scanline.trim(lines, xBound, yBound);
	}
	
	public function mutate():Void {
    var r:Int = Util.random(0, 2);
		switch(r) {
			case 0:
				cx = Util.clamp(cx + Util.random(-8, 8), 0, xBound - 1);
				cy = Util.clamp(cy + Util.random(-8, 8), 0, yBound - 1);
			case 1:
				x1 = Util.clamp(x1 + Util.random(-8, 8), 1, xBound - 1);
				y1 = Util.clamp(y1 + Util.random(-8, 8), 1, yBound - 1);
			case 2:
				x2 = Util.clamp(x2 + Util.random(-8, 8), 1, xBound - 1);
				y2 = Util.clamp(y2 + Util.random(-8, 8), 1, yBound - 1);
		}
	}
	
	public function clone():Shape {
		var bezier = new QuadraticBezier(xBound, yBound);
		bezier.cx = cx;
		bezier.cy = cy;
		bezier.x1 = x1;
		bezier.y1 = y1;
		bezier.x2 = x2;
		bezier.y2 = y2;
		return bezier;
	}
	
	public function getType():ShapeType {
		return ShapeType.QUADRATIC_BEZIER;
	}
	
	public function getRawShapeData():Array<Float> {
		return [ x1, y1, cx, cy, x2, y2 ];
	}
	
	public function getSvgShapeData():String {
		return "<path d=\"M" + x1 + " " + y1 + " Q " + cx + " " + cy + " " + x2 + " " + y2 + "\" " + SvgExporter.SVG_STYLE_HOOK + " />";
	}
}