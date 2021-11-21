package geometrize;

import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;
import geometrize.rasterizer.Rasterizer;
import geometrize.rasterizer.Scanline;
import geometrize.shape.Shape;
import geometrize.shape.ShapeFactory;
import geometrize.shape.ShapeType;

/**
 * The core functions in Geometrize Haxe.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class Core {
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
			for (x in line.x1...line.x2 + 1) {
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
	 * Calculates the root-mean-square error between two bitmaps.
	 * @param	first	The first bitmap.
	 * @param	second	The second bitmap.
	 * @return	The difference/error measure between the two bitmaps.
	 */
	public static function differenceFull(first:Bitmap, second:Bitmap):Float {
		Sure.sure(first != null);
		Sure.sure(second != null);
		Sure.sure(first.width != 0);
		Sure.sure(first.height != 0);
		Sure.sure(second.width != 0);
		Sure.sure(second.height != 0);
		Sure.sure(first.width == second.width);
		Sure.sure(first.height == second.height);
		
		var total:Float = 0;
		var width:Int = first.width;
		var height:Int = first.height;
		for (y in 0...height) {
			for (x in 0...width) {
				var f:Rgba = first.getPixel(x, y);
				var s:Rgba = second.getPixel(x, y);
				
				var dr:Int = f.r - s.r;
				var dg:Int = f.g - s.g;
				var db:Int = f.b - s.b;
				var da:Int = f.a - s.a;
				
				total += (dr * dr + dg * dg + db * db + da * da);
			}
		}
		var result:Float = Math.sqrt(total / (width * height * 4.0)) / 255;
		Sure.sure(Math.isFinite(result));
		return result;
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
		Sure.sure(lines.length != 0);
		
		var width:Int = target.width;
		var height:Int = target.height;
		var rgbaCount:Int = width * height * 4;
		var total:Float = Math.pow(score * 255, 2) * rgbaCount;
		for (line in lines) {
			var y = line.y;
			for (x in line.x1...line.x2 + 1) {
				var t:Rgba = target.getPixel(x, y);
				var b:Rgba = before.getPixel(x, y);
				var a:Rgba = after.getPixel(x, y);
				
				var dtbr:Int = t.r - b.r;
				var dtbg:Int = t.g - b.g;
				var dtbb:Int = t.b - b.b;
				var dtba:Int = t.a - b.a;
				
				var dtar:Int = t.r - a.r;
				var dtag:Int = t.g - a.g;
				var dtab:Int = t.b - a.b;
				var dtaa:Int = t.a - a.a;
				
				total -= (dtbr * dtbr + dtbg * dtbg + dtbb * dtbb + dtba * dtba);
				total += (dtar * dtar + dtag * dtag + dtab * dtab + dtaa * dtaa);
			}
		}
		var result:Float = Math.sqrt(total / rgbaCount) / 255;
		Sure.sure(Math.isFinite(result));
		return result;
	}
	
	/**
	 * Gets the best state using a random algorithm.
	 * @param	shapes	The types of shape to use.
	 * @param	alpha	The opacity of the shape.
	 * @param	n	The number of states to try.
	 * @param	target	The target bitmap.
	 * @param	current	The current bitmap.
	 * @param	buffer	The buffer bitmap.
	 * @param	lastScore	The last score recorded by the model.
	 * @return	The best random state i.e. the one with the lowest energy.
	 */
	public static function bestRandomState(shapes:Array<ShapeType>, alpha:Int, n:Int, target:Bitmap, current:Bitmap, buffer:Bitmap, lastScore:Float):State {
		var bestEnergy:Float = 0;
		var bestState:State = null;
		
		for (i in 0...n) {
			var state:State = new State(ShapeFactory.randomShapeOf(shapes, current.width, current.height), alpha, target, current, buffer);
			var energy:Float = state.energy(lastScore);
			if (i == 0 || energy < bestEnergy) {
				bestEnergy = energy;
				bestState = state;
			}
		}
		return bestState;
	}
	
	/**
	 * Gets the best state using a hill climbing algorithm.
	 * @param	shapes	The types of shape to use.
	 * @param	alpha	The opacity of the shape.
	 * @param	n	The number of random states to generate.
	 * @param	age	The number of hillclimbing steps.
	 * @param	target	The target bitmap.
	 * @param	current	The current bitmap.
	 * @param	buffer	The buffer bitmap.
	 * @param	lastScore	The last score recorded by the model.
	 * @return	The best state acquired from hill climbing i.e. the one with the lowest energy.
	 */
	public static function bestHillClimbState(shapes:Array<ShapeType>, alpha:Int, n:Int, age:Int, target:Bitmap, current:Bitmap, buffer:Bitmap, lastScore:Float):State {
		var state:State = bestRandomState(shapes, alpha, n, target, current, buffer, lastScore);
		state = hillClimb(state, age, lastScore);
		return state;
	}
	
	/**
	 * Hill climbing optimization algorithm, attempts to minimize energy (the error/difference).
	 * @param	state	The state to optimize.
	 * @param	maxAge	The maximum age.
	 * @param	lastScore	The last score recorded by the model.
	 * @return	The best state found from hillclimbing.
	 */
	public static function hillClimb(state:State, maxAge:Int, lastScore:Float):State {
		Sure.sure(state != null);
		Sure.sure(maxAge >= 0);
		
		var state:State = state.clone();
		var bestState:State = state.clone();
		var bestEnergy:Float = state.energy(lastScore);
		
		var age:Int = 0;
		while (age < maxAge) {
			var undo:State = state.mutate();
			var energy:Float = state.energy(lastScore);
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
		
		var lines:Array<Scanline> = shape.rasterize(); // Gets the set of scanlines that describe the pixels covered by the shape
		Sure.sure(lines != null);
		Sure.sure(lines.length != 0);
		
		var color:Rgba = computeColor(target, current, lines, alpha); // Calculate best color for areas covered by the scanlines
		Rasterizer.copyLines(buffer, current, lines); // Copy area covered by scanlines to buffer bitmap
		Rasterizer.drawLines(buffer, color, lines); // Blend scanlines into the buffer using the color calculated earlier
		return differencePartial(target, current, buffer, score, lines); // Get error measure between areas of current and modified buffers covered by scanlines
	}
}