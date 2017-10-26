package geometrize.runner;

import geometrize.shape.ShapeType;

/**
 * Encapsulates the parameters that may be passed to an image runner.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
typedef ImageRunnerOptions = {
	/**
	 * The types of shapes to use when generating the image.
	 */
	var shapeTypes:Array<ShapeType>;
	
	/**
	 * The opacity of the shapes (0-255).
	 */
	var alpha:Int;
	
	/**
	 * The number of candidate shapes to try per model step.
	 */
	var candidateShapesPerStep:Int;
	
	/**
	 * The number of times to mutate each candidate shape.
	 */
	var shapeMutationsPerStep:Int;
}