package geometrize.shape;

import geometrize.exporter.SvgExporter;
import geometrize.rasterizer.Rasterizer;
import geometrize.rasterizer.Scanline;

/**
 * A triangle.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class Triangle implements Shape {
	public var x1:Int;
	public var y1:Int;
	public var x2:Int;
	public var y2:Int;
	public var x3:Int;
	public var y3:Int;
	
	public var xBound(default, null):Int;
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
		return Scanline.trim(Rasterizer.scanlinesForPolygon([ { x: x1, y: y1 }, { x: x2, y: y2 }, { x: x3, y: y3 } ]), xBound, yBound);
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
				x3 = Util.clamp(x3 + Util.random(-16, 16), 0, xBound - 1);
				y3 = Util.clamp(y3 + Util.random(-16, 16), 0, yBound - 1);
		}
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
	
	public function getType():ShapeType {
		return ShapeType.TRIANGLE;
	}
	
	public function getRawShapeData():Array<Float> {
		return [ x1, y1, x2, y2, x3, y3 ];
	}
	
	public function getSvgShapeData():String {
		return "<polygon points=\"" + x1 + "," + y1 + " " + x2 + "," + y2 + " " + x3 + "," + y3 + "\" " + SvgExporter.SVG_STYLE_HOOK + "/>";
	}
}