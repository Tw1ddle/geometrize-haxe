package geometrize.runner;

import geometrize.Model;
import geometrize.Model.ShapeResult;
import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;
import geometrize.runner.ImageRunnerOptions.Default;

/**
 * Helper class for creating a set of shapes that approximate a source image.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
@:expose
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
		var finalOptions:ImageRunnerOptions = {
			shapeTypes: options.shapeTypes != null && options.shapeTypes.length != 0 ? options.shapeTypes : Default.options.shapeTypes,
			alpha: options.alpha != null ? options.alpha : Default.options.alpha,
			candidateShapesPerStep: options.candidateShapesPerStep != null ? options.candidateShapesPerStep : Default.options.candidateShapesPerStep,
			shapeMutationsPerStep: options.shapeMutationsPerStep != null ? options.shapeMutationsPerStep : Default.options.shapeMutationsPerStep
		};
		return model.step(finalOptions.shapeTypes, finalOptions.alpha, finalOptions.candidateShapesPerStep, finalOptions.shapeMutationsPerStep);
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