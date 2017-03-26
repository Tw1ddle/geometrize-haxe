package primitive;

import primitive.bitmap.Bitmap;
import primitive.bitmap.Rgba;
import primitive.shape.Shape;
import primitive.shape.ShapeFactory;
import primitive.shape.ShapeType;

/**
 * The core functions in Primitive Haxe.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class Primitive {
	/**
	 * Calculates a measure of the improvement adding the shape provides - lower energy is better.
	 * @param	shape	The shape to check.
	 * @param	alpha	The alpha of the shape.
	 * @param	target	The target bitmap.
	 * @param	current	The current bitmap.
	 * @param	buffer	The buffer bitmap.
	 * @param	score	The score.
	 * @return	The energy measure.
	 */
	public static function energy(shape:Shape, alpha:Int, target:Bitmap, current:Bitmap, buffer:Bitmap, score:Float):Float {
		Sure.sure(shape != null);
		Sure.sure(target != null);
		Sure.sure(current != null);
		Sure.sure(buffer != null);
		
		// Gets the set of scanlines that describe the pixels covered by the shape
		var lines:Array<Scanline> = shape.rasterize();
		
		// Calculates the best color for the area covered by the scanlines
		var color:Rgba = computeColor(target, current, lines, alpha);
		
		// Copies the area covered by the scanlines to the buffer bitmap
		copyLines(buffer, current, lines);
		
		// Blends the scanlines into the buffer bitmap using the best color calculated earlier
		drawLines(buffer, color, lines);
		
		// Gets the root-mean-square error between the parts of the current and the modified buffer texture covered by the scanlines
		return differencePartial(target, current, buffer, score, lines);
	}
	
	/**
	 * Calculates the color of the scanlines.
	 * @param	target	The target image.
	 * @param	current	The current image.
	 * @param	lines	The scanlines.
	 * @param	alpha	The alpha of the scanline.
	 * @return	The color of the scanlines.
	 */
	public static function computeColor(target:Bitmap, current:Bitmap, lines:Array<Scanline>, alpha:Int):Rgba {
		Sure.sure(target != null);
		Sure.sure(current != null);
		Sure.sure(lines != null);
		Sure.sure(alpha >= 0);
		
		var totalRed:Int = 0;
		var totalGreen:Int = 0;
		var totalBlue:Int = 0;
		var count:Int = 0;
		
		var f:Float = 257 * 255 / alpha;
		var a:Int = Std.int(f);
		
		// For each scanline
		for (line in lines) {
			var y:Int = line.y;
			for (x in line.x1...line.x2) {
				// Get the overlapping target and current colors
				var t:Rgba = target.getPixel(x, y);
				var c:Rgba = current.getPixel(x, y);
				
				// Mix the red, green and blue components, blending by the given alpha value
				totalRed += (t.r - c.r) * a + c.r * 257;
				totalGreen += (t.g - c.g) * a + c.g * 257;
				totalBlue += (t.b - c.b) * a + c.b * 257;
				
				count++;
			}
		}
		
		if (count == 0) { // Early out to avoid integer divide by 0
			return 0;
		}
		
		// Scale totals down to 0-255 range to get average blended color
		var r:Int = Util.clamp(Std.int(totalRed / count) >> 8, 0, 255);
		var g:Int = Util.clamp(Std.int(totalGreen / count) >> 8, 0, 255);
		var b:Int = Util.clamp(Std.int(totalBlue / count) >> 8, 0, 255);
		
		return Rgba.create(r, g, b, alpha);
	}
	
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
			var ma:Int = line.alpha;
			var m:Int = 65535;
			var as:Float = (m - (sa * (ma / m))) * 257;
			var a:Int = Std.int(as);
			for (x in line.x1...line.x2) {
				// Get the current overlapping color
				var d:Rgba = image.getPixel(x, y);
				
				//trace("premul color");
				//trace(sr);
				//trace(sg);
				//trace(sb);
				//trace(sa);
				
				//trace("color c " + c);
				//trace("ma " + ma);
				//trace("a " + a);
				//trace("color d " + d);
				
				var dr:UInt = d.r;
				var dg:UInt = d.g;
				var db:UInt = d.b;
				var da:UInt = d.a;
				
				// Blend the color components
				var r:UInt = Std.int((dr * a + sr * ma) / m) >> 8;
				var g:UInt = Std.int((dg * a + sg * ma) / m) >> 8;
				var b:UInt = Std.int((db * a + sb * ma) / m) >> 8;
				var a:UInt = Std.int((da * a + sa * ma) / m) >> 8;
				
				//trace("color final...");
				//trace(r);
				//trace(g);
				//trace(b);
				//trace(a);
				
				//trace("color final " + Rgba.create(r, g, b, a));
				
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
			for (x in line.x1...line.x2) {
				destination.setPixel(x, y, source.getPixel(x, y));
			}
		}
	}
	
	/**
	 * Calculates the root-mean-square error between two bitmaps.
	 * @param	first	The first bitmap.
	 * @param	second	The second bitmap.
	 * @return	The difference/error measure between the two bitmaps.
	 */
	public static function differenceFull(first:Bitmap, second:Bitmap):Float {
		Sure.sure(first != null);
		Sure.sure(second != null);
		Sure.sure(first.width == second.width);
		Sure.sure(first.height == second.height);
		
		var total:UInt = 0;
		var width:Int = first.width;
		var height:Int = first.height;
		for (y in 0...height) {
			for (x in 0...width) {
				var f:Rgba = first.getPixel(x, y);
				var s:Rgba = second.getPixel(x, y);
				
				var dr:Int = f.r - s.r;
				var dg:Int = f.g - s.g;
				var db:Int = f.b - s.b;
				
				total += (dr * dr + dg * dg + db * db);
			}
		}
		return Math.sqrt(total / (width * height * 3.0)) / 255;
	}
	
	/**
	 * Calculates the root-mean-square error between the parts of the two bitmaps within the scanline mask.
	 * This is for optimization purposes, it lets us calculate new error values only for parts of the image we know have changed.
	 * @param	target	The target bitmap.
	 * @param	before	The bitmap before the change.
	 * @param	after	The bitmap after the change.
	 * @param	score	The score.
	 * @param	lines	The scanlines.
	 * @return	The difference/error between the two bitmaps, masked by the scanlines.
	 */
	public static function differencePartial(target:Bitmap, before:Bitmap, after:Bitmap, score:Float, lines:Array<Scanline>):Float {
		Sure.sure(target != null);
		Sure.sure(before != null);
		Sure.sure(after != null);
		Sure.sure(lines != null);
		
		var width:Int = target.width;
		var height:Int = target.height;
		var rgbCount:Int = width * height * 3;
		var total:UInt = Std.int(Math.pow(score * 255, 2) * rgbCount);
		for (line in lines) {
			var y = line.y;
			for (x in line.x1...line.x2) {
				var t:Rgba = target.getPixel(x, y);
				var b:Rgba = before.getPixel(x, y);
				var a:Rgba = after.getPixel(x, y);
				
				var dtbr:Int = t.r - b.r;
				var dtbg:Int = t.g - b.g;
				var dtbb:Int = t.b - b.b;
				
				var dtar:Int = t.r - a.r;
				var dtag:Int = t.g - a.g;
				var dtab:Int = t.b - a.b;
				
				total -= (dtbr * dtbr + dtbg * dtbg + dtbb * dtbb);
				total += (dtar * dtar + dtag * dtag + dtab * dtab);
			}
		}
		return Math.sqrt(total / rgbCount) / 255;
	}
	
	/**
	 * Gets the best state using a hill climbing algorithm.
	 * @param	shapes	The types of shape to use.
	 * @param	alpha	The opacity of the shape.
	 * @param	n	The number of random states to generate.
	 * @param	age	The number of hillclimbing steps.
	 * @param	m	The number of iterations for the overall algorithm.
	 * @param	target	The target bitmap.
	 * @param	current	The current bitmap.
	 * @param	buffer	The buffer bitmap.
	 * @return	The best state acquired from hill climbing i.e. the one with the lowest energy.
	 */
	public static function bestHillClimbState(shapes:Array<ShapeType>, alpha:Int, n:Int, age:Int, m:Int, target:Bitmap, current:Bitmap, buffer:Bitmap):State {
		var bestEnergy:Float = 0;
		var bestState:State = null;
		
		for (i in 0...m) {
			var state:State = bestRandomState(shapes, alpha, n, target, current, buffer);
			var before:Float = state.energy();
			state = hillClimb(state, age);
			var energy:Float = state.energy();
			if (i == 0 || energy < bestEnergy) {
				bestEnergy = energy;
				bestState = state;
			}
		}
		return bestState;
	}
	
	/**
	 * Gets the best state using a random algorithm.
	 * @param	shapes	The types of shape to use.
	 * @param	alpha	The opacity of the shape.
	 * @param	n	The number of states to try.
	 * @param	target	The target bitmap.
	 * @param	current	The current bitmap.
	 * @param	buffer	The buffer bitmap.
	 * @return	The best random state i.e. the one with the lowest energy.
	 */
	public static function bestRandomState(shapes:Array<ShapeType>, alpha:Int, n:Int, target:Bitmap, current:Bitmap, buffer:Bitmap):State {
		var bestEnergy:Float = 0;
		var bestState:State = null;
		
		for (i in 0...n) {
			var state:State = new State(ShapeFactory.randomShapeOf(shapes, current.width, current.height), alpha, target, current, buffer);
			var energy:Float = state.energy();
			if (i == 0 || energy < bestEnergy) {
				bestEnergy = energy;
				bestState = state;
			}
		}
		return bestState;
	}
	
	/**
	 * Hill climbing optimization algorithm, attempts to minimize energy (the error/difference).
	 * @param	state	The state to optimize.
	 * @param	maxAge	The maximum age.
	 * @return	The best state found from hillclimbing.
	 */
	public static function hillClimb(state:State, maxAge:Int):State {
		Sure.sure(state != null);
		Sure.sure(maxAge >= 0);
		
		var state:State = state.clone();
		var bestState:State = state.clone();
		var bestEnergy:Float = state.energy();
		
		var age:Int = 0;
		while (age < maxAge) {
			var undo:State = state.mutate();
			var energy:Float = state.energy();
			if (energy >= bestEnergy) {
				state = undo;
			} else {
				bestEnergy = energy;
				bestState = state.clone();
				age = -1;
			}
			age++;
		}
		
		return bestState;
	}
	
	/**
	 * Computes the average RGB color of the pixels in the image.
	 * @param	image	The image whose average color will be calculated.
	 * @return	The average RGB color of the image, RGBA8888 format. Alpha is set to opaque (255).
	 */
	public static function getAverageImageColor(image:Bitmap):Rgba {
		Sure.sure(image != null);
		
		var totalRed:Int = 0;
		var totalGreen:Int = 0;
		var totalBlue:Int = 0;
		//var totalAlpha:Int = 0;
		
		for (x in 0...image.width) {
			for (y in 0...image.height) {
				var pixel = image.getPixel(x, y);
				totalRed += pixel.r;
				totalGreen += pixel.g;
				totalBlue += pixel.b;
				//totalAlpha += pixel.a;
			}
		}
		
		var size:Int = image.width * image.height;
		return Rgba.create(Std.int(totalRed / size), Std.int(totalGreen / size), Std.int(totalBlue / size), 255);
	}
}