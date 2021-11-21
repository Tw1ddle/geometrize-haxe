package geometrize.rasterizer;

import haxe.ds.IntMap;
import geometrize.ArraySet;
import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;
import geometrize.Util;

/**
 * Rasterization helper functions.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class Rasterizer {
	/**
	 * Draws scanlines onto an image.
	 * @param	image	The image to be drawn to.
	 * @param	color	The color of the scanlines.
	 * @param	lines	The scanlines to draw.
	 */
	public static function drawLines(image:Bitmap, c:Rgba, lines:Array<Scanline>):Void {
		Sure.sure(image != null);
		Sure.sure(lines != null);
		
		// Convert the non-premultiplied color to alpha-premultiplied 16-bits per channel RGBA
		// In other words, scale the rgb color components by the alpha component
		var sr:Int = c.r;
		sr |= sr << 8;
		sr *= c.a;
		sr = Std.int(sr / 0xFF);
		var sg:Int = c.g;
		sg |= sg << 8;
		sg *= c.a;
		sg = Std.int(sg / 0xFF);
		var sb:Int = c.b;
		sb |= sb << 8;
		sb *= c.a;
		sb = Std.int(sb / 0xFF);
		var sa:Int = c.a;
		sa |= sa << 8;
		
		// For each scanline
		for (line in lines) {
			var y:Int = line.y;
			var ma:Int = 65535;
			var m:Int = 65535;
			var as:Float = (m - (sa * (ma / m))) * 257;
			var a:Int = Std.int(as);
			for (x in line.x1...line.x2 + 1) {
				// Get the current overlapping color
				var d:Rgba = image.getPixel(x, y);
				
				var dr:UInt = d.r;
				var dg:UInt = d.g;
				var db:UInt = d.b;
				var da:UInt = d.a;
				
				// Blend the color components
				var r:UInt = Std.int((dr * a + sr * ma) / m) >> 8;
				var g:UInt = Std.int((dg * a + sg * ma) / m) >> 8;
				var b:UInt = Std.int((db * a + sb * ma) / m) >> 8;
				var a:UInt = Std.int((da * a + sa * ma) / m) >> 8;
				
				image.setPixel(x, y, Rgba.create(r, g, b, a));
			}
		}
	}
	
	/**
	 * Copies source pixels to a destination defined by a set of scanlines.
	 * @param	destination	The destination bitmap to copy the lines to.
	 * @param	source	The source bitmap to copy the lines from.
	 * @param	lines	The scanlines that comprise the source to destination copying mask.
	 */
	public static function copyLines(destination:Bitmap, source:Bitmap, lines:Array<Scanline>):Void {
		Sure.sure(destination != null);
		Sure.sure(source != null);
		Sure.sure(lines != null);
		
		for (line in lines) {
			var y = line.y;
			for (x in line.x1...line.x2 + 1) {
				destination.setPixel(x, y, source.getPixel(x, y));
			}
		}
	}
	
	/**
	 * Bresenham's line algorithm, returns the points on the line x1,y1 to x2,y2
	 * @param	x1	x-coordinate of the first point.
	 * @param	y1	y-coordinate of the first point.
	 * @param	x2	x-coordinate of the second point.
	 * @param	y2	y-coordinate of the second point.
	 * @return	The points on the line x1,y1 to x2,y2
	 */
	public static function bresenham(x1:Int, y1:Int, x2:Int, y2:Int):Array<Point> {
		var points = [];
		
		var dx:Int = x2 - x1;
		var ix:Int = ((dx > 0) ? 1 : 0) - ((dx < 0) ? 1 : 0);
		dx = Util.abs(dx) << 1;
		
		var dy:Int = y2 - y1;
		var iy:Int = ((dy > 0) ? 1 : 0) - ((dy < 0) ? 1 : 0);
		dy = Util.abs(dy) << 1;
		
		var points:Array<{ x:Int, y:Int }> = [];
		points.push({ x: x1, y: y1 });
		
		if (dx >= dy) {
			var error:Int = (dy - (dx >> 1));
			while (x1 != x2) {
				if (error >= 0 && ((error != 0) || (ix > 0))) {
					error -= dx;
					y1 += iy;
				}
				
				error += dy;
				x1 += ix;
				points.push({ x: x1, y: y1 });
			}
		} else {
			var error:Int = (dx - (dy >> 1));
			while (y1 != y2) {
				if (error >= 0 && ((error != 0) || (iy > 0))) {
					error -= dy;
					x1 += ix;
				}
				
				error += dx;
				y1 += iy;
				points.push({ x: x1, y: y1 });
			}
		}
		
		return points;
	}
	
	/**
	 * Converts a polygon to a set of rasterizable scanlines.
	 * @param	points	The vertices of the polygon.
	 * @return	Scanlines for the polygon.
	 */
	public static function scanlinesForPolygon(points:Array<Point>):Array<Scanline> {
		var lines:Array<Scanline> = [];
		
		var edges:Array<Point> = [];
		for (i in 0...points.length) {
			var p1 = points[i];
			var p2 = (i == (points.length - 1)) ? points[0] : points[i + 1];
			var p1p2 = bresenham(p1.x, p1.y, p2.x, p2.y);
			edges = edges.concat(p1p2);
		}
		
		var yToXs:IntMap<ArraySet<Int>> = new IntMap<ArraySet<Int>>();
		for (point in edges) {
			var s = yToXs.get(point.y);
			if (s != null) {
				s.add(point.x);
			} else {
				s = ArraySet.create();
				s.add(point.x);
				yToXs.set(point.y, s);
			}
		}
		
		for (key in yToXs.keys()) {
			var minMaxElements = Util.minMaxElements(yToXs.get(key));
			lines.push(new Scanline(key, minMaxElements.x, minMaxElements.y));
		}
		
		return lines;
	}
}