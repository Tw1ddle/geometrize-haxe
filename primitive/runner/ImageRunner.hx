package primitive.runner;

import primitive.Model;
import primitive.Model.ShapeResult;
import primitive.bitmap.Bitmap;
import primitive.bitmap.Rgba;
import primitive.shape.ShapeType;

/**
 * Encapsulates the parameters that may be passed to the runner.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class RunParams {
	public function new() {
		shapeTypes = [
			ShapeType.RECTANGLE
		];
	}
	
	/**
	 * The types of shapes to use when generating the image (required).
	 */
	public var shapeTypes:Array<ShapeType>;
}

/**
 * Helper class for creating a set of primitives from a single source image.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class ImageRunner {
	/**
	 * Runtime configuration parameters for the runner.
	 */
	public var options(default, null) = new RunParams();
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
	public function step():Array<ShapeResult> {
		return model.step(options.shapeTypes, 128, 0); // TODO alpha, repeat params from config etc
	}
	
	/**
	 * Gets the current bitmap with the primitives drawn on it.
	 * @return	The current bitmap.
	 */
	public function getImageData():Bitmap {
		Sure.sure(model != null);
		return model.current;
	}
	
	/**
	 * Gets data about the shapes added to the model so far.
	 * @return	The shape results.
	 */
	public function getShapeResults():Array<ShapeResult> {
		Sure.sure(model != null);
		return model.shapeResults;
	}
	
	private function get_backgroundColor():Rgba {
		return model.backgroundColor;
	}
}