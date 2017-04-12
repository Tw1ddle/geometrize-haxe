package primitive.runner;

import primitive.runner.ImageRunner;
import primitive.shape.ShapeType;

/**
 * Encapsulates the parameters that may be passed to the image runner.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class ImageRunnerOptions {
	/**
	 * Creates a new set of image runner options.
	 * @param	shapeTypes	The types of shapes to use when generating the image.
	 * @param	alpha	The opacity of the shapes (0-255).
	 * @param	candidateShapesPerStep	The number of candidate shapes to try per model step.
	 * @param	shapeMutationsPerStep	The number of times to mutate each candidate shape.
	 */
	public function new(?shapeTypes:Array<ShapeType>, alpha:Int = 128, candidateShapesPerStep:Int = 100, shapeMutationsPerStep:Int = 50) {
		if (shapeTypes == null) {
			shapeTypes = [ ShapeType.RECTANGLE ];
		}
		this.shapeTypes = shapeTypes;
		this.alpha = alpha;
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
}