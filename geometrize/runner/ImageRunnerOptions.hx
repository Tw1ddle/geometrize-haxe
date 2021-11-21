package geometrize.runner;

import geometrize.shape.ShapeType;

/**
 * Encapsulates the parameters that may be passed to an image runner.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
@:expose
typedef ImageRunnerOptions = {
	/**
	 * The types of shapes to use when generating the image. By default `[ShapeType.TRIANGLE]`.
	 */
	@:optional var shapeTypes:Array<ShapeType>;

	/**
	 * The opacity of the shapes (0-255). By default `128`.
	 */
	@:optional var alpha:Int;

	/**
	 * The number of candidate shapes to try per model step. By default `50`.
	 */
	@:optional var candidateShapesPerStep:Int;

	/**
	 * The number of times to mutate each candidate shape. By default `100`.
	 */
	@:optional var shapeMutationsPerStep:Int;
}

class Default {
	public static var options:ImageRunnerOptions = {
		shapeTypes: [ShapeType.TRIANGLE],
		candidateShapesPerStep: 50,
		shapeMutationsPerStep: 100,
		alpha: 128
	};
}