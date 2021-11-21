package geometrize;

import geometrize.bitmap.Bitmap;
import geometrize.shape.Shape;

/**
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class State {
	/**
	 * The geometric shape owned by the state.
	 */
	public var shape(default, null):Shape;
	/**
	 * The alpha of the shape.
	 */
	public var alpha(default, null):Int;
	/**
	 * The score of the state, a measure of the improvement applying the state to the current bitmap will have.
	 */
	public var score:Float;
	
	private var target:Bitmap;
	private var current:Bitmap;
	private var buffer:Bitmap;
	
	/**
	 * Create a new state.
	 * @param	shape	A geometric shape.
	 * @param	alpha	The color alpha of the geometric shape.
	 * @param	target	The target bitmap.
	 * @param	current	The current bitmap.
	 * @param	buffer	The buffer bitmap.
	 */
	public function new(shape:Shape, alpha:Int, target:Bitmap, current:Bitmap, buffer:Bitmap) {
		Sure.sure(shape != null);
		
		this.shape = shape;
		this.alpha = alpha;
		
		this.score = -1;
		
		this.target = target;
		this.current = current;
		this.buffer = buffer;
	}
	
	/**
	 * Calculates a measure of the improvement drawing the shape to the current bitmap will have.
	 * The lower the energy, the better. The score is cached, set it to < 0 to recalculate it.
	 * @param	lastScore	The last score recorded by the model.
	 * @return	The energy measure.
	 */
	public function energy(lastScore:Float):Float {
		if (score < 0) {
			score = Core.energy(shape, alpha, target, current, buffer, lastScore);
		}
		return score;
	}
	
	/**
	 * Modify the current state in a random fashion.
	 * @return	The old state - in case we want to go back to the old state.
	 */
	public function mutate():State {
		var oldState:State = clone();
		shape.mutate();
		return oldState;
	}
	
	/**
	 * Creates a copy of the state. Deep copy of the shape and alpha, shallow copy of the bitmap buffers. Score not copied.
	 * @return	The cloned state.
	 */
	public function clone():State {
		return new State(shape.clone(), alpha, target, current, buffer);
	}
}