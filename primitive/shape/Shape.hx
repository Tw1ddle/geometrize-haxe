package primitive.shape;

/**
 * Interface for shape rasterization and manipulation.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
interface Shape {
	/**
	 * Creates a raster scanline representation of the shape.
	 * @return	Array of raster scanlines representing the shape.
	 */
	public function rasterize():Array<Scanline>;
	/**
	 * Modifies the shape a little, typically with a random component.
	 * For improving the shape's fit to a bitmap (trial-and-error style).
	 */
	public function mutate():Void;
	/**
	 * Creates a deep copy of the shape.
	 * @return	A deep copy of the shape object.
	 */
	public function clone():Shape;
}