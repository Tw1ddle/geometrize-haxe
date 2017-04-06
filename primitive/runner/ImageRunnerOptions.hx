package primitive.runner;

import primitive.runner.ImageRunner;
import primitive.shape.ShapeType;

/**
 * Encapsulates the parameters that may be passed to the image runner.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class ImageRunnerOptions {
	public function new(?shapeTypes:Array<ShapeType>, alpha:Int = 128, repeats:Int = 1, candidateShapesPerStep:Int = 100, shapeMutationsPerStep:Int = 50) {
		if (shapeTypes == null) {
			shapeTypes = [ ShapeType.RECTANGLE ];
		}
		this.shapeTypes = shapeTypes;
		this.alpha = alpha;
		this.repeats = repeats;
		this.candidateShapesPerStep = candidateShapesPerStep;
		this.shapeMutationsPerStep = shapeMutationsPerStep;
	}
	
	/**
	 * The types of shapes to use when generating the image.
	 */
	public var shapeTypes:Array<ShapeType>;
	/**
	 * The opacity of the shapes (0-255).
	 */
	public var alpha:Int;
	/**
	 * The number of candidate shapes to try per model step.
	 */
	public var candidateShapesPerStep:Int;
	/**
	 * The number of times to mutate each candidate shape.
	 */
	public var shapeMutationsPerStep:Int;
	/**
	 * The number of times to repeat the algorithm with reduced search.
	 */
	public var repeats:Int;
}