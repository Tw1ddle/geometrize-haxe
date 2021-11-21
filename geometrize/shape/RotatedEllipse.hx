package geometrize.shape;

import geometrize.exporter.SvgExporter;
import geometrize.rasterizer.Rasterizer;
import geometrize.rasterizer.Scanline;

/**
 * A rotated ellipse.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class RotatedEllipse implements Shape {
	public var x:Int;
	public var y:Int;
	public var rx:Int;
	public var ry:Int;
	public var angle:Int;
	
	public var xBound(default, null):Int;
	public var yBound(default, null):Int;
	
	public function new(xBound:Int, yBound:Int) {
		x = Std.random(xBound);
		y = Std.random(yBound);
		rx = Std.random(32) + 1;
		ry = Std.random(32) + 1;
		angle = Std.random(360);
		
		this.xBound = xBound;
		this.yBound = yBound;
	}
	
	public function rasterize():Array<Scanline> {
		var pointCount:Int = 20;
		var points:Array<{x : Int, y: Int}> = [];
		
		var rads:Float = angle * (Math.PI / 180.0);
		var c:Float = Math.cos(rads);
		var s:Float = Math.sin(rads);
		
		for (i in 0...pointCount) {
			var rot:Float = ((360.0 / pointCount) * i) * (Math.PI / 180.0);
			var crx:Float = rx * Math.cos(rot);
			var cry:Float = ry * Math.sin(rot);
			
			var tx:Int = Std.int(crx * c - cry * s + x);
			var ty:Int = Std.int(crx * s + cry * c + y);
			
			points.push({ x: tx, y: ty });
		}
		
		return Scanline.trim(Rasterizer.scanlinesForPolygon(points), xBound, yBound);
	}
	
	public function mutate():Void {
		var r = Std.random(4);
		switch (r) {
			case 0:
				x = Util.clamp(x + Util.random(-16, 16), 0, xBound - 1);
				y = Util.clamp(y + Util.random(-16, 16), 0, yBound - 1);
			case 1:
				rx = Util.clamp(rx + Util.random(-16, 16), 1, xBound - 1);
			case 2:
				ry = Util.clamp(ry + Util.random(-16, 16), 1, yBound - 1);
			case 3:
				angle = Util.clamp(angle + Util.random(-4, 4), 0, 360);
		}
	}
	
	public function clone():Shape {
		var ellipse = new RotatedEllipse(xBound, yBound);
		ellipse.x = x;
		ellipse.y = y;
		ellipse.rx = rx;
		ellipse.ry = ry;
		ellipse.angle = angle;
		return ellipse;
	}
	
	public function getType():ShapeType {
		return ShapeType.ROTATED_ELLIPSE;
	}
	
	public function getRawShapeData():Array<Float> {
		return [ x, y, rx, ry, angle ];
	}
	
	public function getSvgShapeData():String {
		var s:String = "<g transform=\"translate(" + x + " " + y + ") rotate(" + angle + ") scale(" + rx + " " + ry + ")\">";
		s += "<ellipse cx=\"" + 0 + "\" cy=\"" + 0 + "\" rx=\"" + 1 + "\" ry=\"" + 1 + "\" " + SvgExporter.SVG_STYLE_HOOK + " />";
		s += "</g>";
		return s;
	}
}