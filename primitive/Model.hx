package primitive;

import primitive.Model.ShapeResult;
import primitive.bitmap.Bitmap;
import primitive.bitmap.Rgba;
import primitive.shape.Shape;
import primitive.shape.ShapeType;

/**
 * Container for info about a shape added to the model.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
typedef ShapeResult = {
	var score:Float;
	var color:Rgba;
	var shape:Shape;
}

/**
 * Model for the primitive optimization/fitting algorithm.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class Model {
	/**
	 * Width of the target bitmap.
	 */
	public var width(default, null):Int;
	/**
	 * Height of the target bitmap.
	 */
	public var height(default, null):Int;
	
	/**
	 * Starting background color of the input bitmap.
	 */
	public var backgroundColor(default, null):Rgba;
	/**
	 * The target bitmap, the bitmap we aim to approximate.
	 */
	public var target(default, null):Bitmap;
	/**
	 * The current bitmap.
	 */
	public var current(default, null):Bitmap;
	/**
	 * Buffer bitmap.
	 */
	public var buffer(default, null):Bitmap;
	
	/**
	 * Score derived from calculating the difference between bitmaps.
	 */
	private var score(default, null):Float;
	
	/**
	 * Creates a new model.
	 * @param	target	The target bitmap.
	 * @param	backgroundColor	The starting background color.
	 * @param	outputSize	The desired size of the output bitmap.
	 */
	public function new(target:Bitmap, backgroundColor:Rgba, outputSize:Int) {
		Sure.sure(target != null);
		
		this.width = target.width;
		this.height = target.height;
		this.backgroundColor = backgroundColor;
		this.target = target;
		this.current = Bitmap.create(target.width, target.height, backgroundColor);
		this.buffer = Bitmap.create(target.width, target.height, backgroundColor);
		
		this.score = Primitive.differenceFull(target, current);
	}
	
	/**
	 * Steps the primitive optimization/fitting algorithm.
	 * @param	shapeType	The shape types to use.
	 * @param	alpha	The alpha of the shape.
	 * @param	repeats	How many times to repeat the stepping process with reduced search (per step), possibly adding additional shapes
	 * @param	n The number of shapes to try.
	 * @param	age The number of mutations to apply to each shape.
	 * @return	An array containing data about the shapes added to the model in this step.
	 */
	public function step(shapeTypes:Array<ShapeType>, alpha:Int, repeats:Int, n:Int, age:Int):Array<ShapeResult> {
		var state = Primitive.bestHillClimbState(shapeTypes, alpha, n, age, repeats, target, current, buffer, score);
		
		var results:Array<ShapeResult> = [];
		results.push(addShape(state.shape, state.alpha));
		
		for (i in 0...repeats) {
			var before:Float = state.energy(score);
			state = Primitive.hillClimb(state, 100, score);
			var after:Float = state.energy(score);
			if (before == after) {
				break;
			}
			results.push(addShape(state.shape, state.alpha));
		}
		
		return results;
	}
	
	/**
	 * Adds a shape to the model.
	 * @param	shape	The shape to add.
	 * @param	alpha	The alpha/opacity of the shape.
	 * @return	Data about the shape just added to the model.
	 */
	public function addShape(shape:Shape, alpha:Int):ShapeResult {
		Sure.sure(shape != null);
		
		var before:Bitmap = current.clone();
		var lines:Array<Scanline> = shape.rasterize();
		var color:Rgba = Primitive.computeColor(target, current, lines, alpha);
		Primitive.drawLines(current, color, lines);
		
		score = Primitive.differencePartial(target, before, current, score, lines);
		
		var result:ShapeResult = {
			score: score, color: color, shape: shape
		};
		return result;
	}
}