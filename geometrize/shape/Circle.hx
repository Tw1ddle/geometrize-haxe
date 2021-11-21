package geometrize.shape;

import geometrize.exporter.SvgExporter;

/**
 * A circle.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class Circle extends Ellipse {
	public function new(xBound:Int, yBound:Int) {
		super(xBound, yBound);
		
		// Circle is a special case of ellipse, just make the x/y radius the same
		rx = Std.random(32) + 1;
		ry = rx;
	}
	
	override public function mutate():Void {
		var r = Std.random(2);
		switch (r) {
			case 0:
				x = Util.clamp(x + Util.random(-16, 16), 0, xBound - 1);
				y = Util.clamp(y + Util.random(-16, 16), 0, yBound - 1);
			case 1:
				var r = Util.clamp(rx + Util.random(-16, 16), 1, xBound - 1);
				rx = r;
				ry = r;
		}
	}
	
	override public function clone():Shape {
		var circle = new Circle(xBound, yBound);
		circle.x = x;
		circle.y = y;
		circle.rx = rx;
		circle.ry = ry;
		return circle;
	}
	
	override public function getType():ShapeType {
		return ShapeType.CIRCLE;
	}
	
	override public function getRawShapeData():Array<Float> {
		return [ x, y, rx ];
	}
	
	override public function getSvgShapeData():String {
		return "<circle cx=\"" + x + "\" cy=\"" + y + "\" r=\"" + rx + "\" " + SvgExporter.SVG_STYLE_HOOK + " />";
	}
}