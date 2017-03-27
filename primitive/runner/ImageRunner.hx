package primitive.runner;

import primitive.Model;
import primitive.Model.ShapeResult;
import primitive.bitmap.Bitmap;
import primitive.bitmap.Rgba;
import primitive.shape.ShapeType;

/**
 * Encapsulates the parameters that may be passed to the image runner.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class ImageRunnerOptions {
	public function new() {
		shapeTypes = [
			ShapeType.RECTANGLE
		];
		alpha = 128;
		repeats = 1;
		candidateShapesPerStep = 100;
		shapeMutationsPerStep = 50;
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

/**
 * Helper class for creating a set of primitives from a single source image.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class ImageRunner {
	/**
	 * The model for the primitive optimization/fitting algorithm.
	 */
	public var model(default, null):Model = null;
	/**
	 * The average background color of the input image.
	 */
	public var backgroundColor(get, never):Rgba;
	
	/**
	 * Creates a new runner.
	 * @param	inputImage	The input image, the image that the primitive algorithm will optimize for.
	 */
	public function new(inputImage:Bitmap) {
		model = new Model(inputImage, Primitive.getAverageImageColor(inputImage), inputImage.width); // TODO is outputsize used?
	}
	
	/**
	 * Updates the model once.
	 * @return	An array containing data about the shapes just added to the model.
	 */
	public function step(options:ImageRunnerOptions):Array<ShapeResult> {
		return model.step(options.shapeTypes, options.alpha, options.repeats, options.candidateShapesPerStep, options.shapeMutationsPerStep);
	}
	
	/**
	 * Gets the current bitmap with the primitives drawn on it.
	 * @return	The current bitmap.
	 */
	public function getImageData():Bitmap {
		Sure.sure(model != null);
		return model.current;
	}
	
	private function get_backgroundColor():Rgba {
		return model.backgroundColor;
	}
}