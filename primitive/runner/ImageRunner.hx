package primitive.runner;

import primitive.Model;
import primitive.Model.ShapeResult;
import primitive.bitmap.Bitmap;
import primitive.bitmap.Rgba;
import primitive.shape.ShapeType;

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
}