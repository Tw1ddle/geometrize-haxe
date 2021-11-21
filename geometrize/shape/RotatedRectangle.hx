package geometrize.shape;

import geometrize.exporter.SvgExporter;
import geometrize.rasterizer.Rasterizer;
import geometrize.rasterizer.Scanline;
import geometrize.Util;

/**
 * A rotated rectangle.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class RotatedRectangle implements Shape {
	public var x1:Int;
	public var y1:Int;
	public var x2:Int;
	public var y2:Int;
	public var angle:Int;

	public var xBound(default, null):Int;
	public var yBound(default, null):Int;
	
	public function new(xBound:Int, yBound:Int) {
		x1 = Std.random(xBound);
		y1 = Std.random(yBound);
		x2 = Util.clamp(x1 + Std.random(32) + 1, 0, xBound);
		y2 = Util.clamp(y1 + Std.random(32) + 1, 0, yBound);
		angle = Util.random(0, 360);
		
		this.xBound = xBound;
		this.yBound = yBound;
	}
	
	public function rasterize():Array<Scanline> {
		return Scanline.trim(Rasterizer.scanlinesForPolygon(getCornerPoints()), xBound, yBound);
	}
	
	public function mutate():Void {
		var r = Std.random(3);
		switch (r) {
			case 0:
				x1 = Util.clamp(x1 + Util.random(-16, 16), 0, xBound - 1);
				y1 = Util.clamp(y1 + Util.random(-16, 16), 0, yBound - 1);
			case 1:
				x2 = Util.clamp(x2 + Util.random(-16, 16), 0, xBound - 1);
				y2 = Util.clamp(y2 + Util.random(-16, 16), 0, yBound - 1);
			case 2:
				angle = Util.clamp(angle + Util.random(-4, 4), 0, 360);
		}
	}
	
	public function clone():Shape {
		var rectangle = new RotatedRectangle(xBound, yBound);
		rectangle.x1 = x1;
		rectangle.y1 = y1;
		rectangle.x2 = x2;
		rectangle.y2 = y2;
		rectangle.angle = angle;
		return rectangle;
	}
	
	public function getType():ShapeType {
		return ShapeType.ROTATED_RECTANGLE;
	}
	
	public function getRawShapeData():Array<Float> {
		return [ Util.min(x1, x2), Util.min(y1, y2), Util.max(x1, x2), Util.max(y1, y2), angle ];
	}
	
	public function getSvgShapeData():String {
		var points:Array<Util.Point> = getCornerPoints();
		var s:String = "<polygon points=\"";
		for (i in 0...points.length) {
			s += points[i].x + " " + points[i].y;
			if (i != points.length - 1) {
				s += " ";
			}
		}
		s += "\" " + SvgExporter.SVG_STYLE_HOOK + "/>";
		return s;
	}
	
	private inline function getCornerPoints():Array<Util.Point> {
		var xm1:Int = Util.min(x1, x2);
		var xm2:Int = Util.max(x1, x2);
		var ym1:Int = Util.min(y1, y2);
		var ym2:Int = Util.max(y1, y2);
		
		var cx:Int = Std.int((xm1 + xm2) / 2);
		var cy:Int = Std.int((ym1 + ym2) / 2);
		
		var ox1:Int = xm1 - cx;
		var ox2:Int = xm2 - cx;
		var oy1:Int = ym1 - cy;
		var oy2:Int = ym2 - cy;
		
		var rads:Float = angle * Math.PI / 180.0;
		var c:Float = Math.cos(rads);
		var s:Float = Math.sin(rads);
		
		var ulx:Int = Std.int(ox1 * c - oy1 * s + cx);
		var uly:Int = Std.int(ox1 * s + oy1 * c + cy);
		var blx:Int = Std.int(ox1 * c - oy2 * s + cx);
		var bly:Int = Std.int(ox1 * s + oy2 * c + cy);
		var urx:Int = Std.int(ox2 * c - oy1 * s + cx);
		var ury:Int = Std.int(ox2 * s + oy1 * c + cy);
		var brx:Int = Std.int(ox2 * c - oy2 * s + cx);
		var bry:Int = Std.int(ox2 * s + oy2 * c + cy);
		
		return [ { x : ulx, y : uly }, { x : urx, y : ury }, { x : brx, y : bry }, { x : blx, y : bly } ];
	}
}