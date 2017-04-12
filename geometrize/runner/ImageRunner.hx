package geometrize.runner;

import geometrize.Model;
import geometrize.Model.ShapeResult;
import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;

/**
 * Helper class for creating a set of shapes that approximate a source image.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class ImageRunner {
	/**
	 * The model for the optimization/fitting algorithm.
	 */
	public var model(default, null):Model = null;
	
	/**
	 * Creates a new runner.
	 * @param	inputImage	The input image, the image that the algorithm will optimize for.
	 */
	public function new(inputImage:Bitmap, backgroundColor:Rgba) {
		model = new Model(inputImage, backgroundColor);
	}
	
	/**
	 * Updates the model once.
	 * @return	An array containing data about the shapes just added to the model.
	 */
	public function step(options:ImageRunnerOptions):Array<ShapeResult> {
		return model.step(options.shapeTypes, options.alpha, options.candidateShapesPerStep, options.shapeMutationsPerStep);
	}
	
	/**
	 * Gets the current bitmap with the shapes drawn on it.
	 * @return	The current bitmap.
	 */
	public function getImageData():Bitmap {
		Sure.sure(model != null);
		return model.current;
	}
}