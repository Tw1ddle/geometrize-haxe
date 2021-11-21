package geometrize.shape;

import geometrize.rasterizer.Scanline;

/**
 * Interface for shape rasterization and manipulation.
 * @author Sam Twidale (https://samcodes.co.uk/)
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
	
	/**
	 * Gets the ShapeType of the shape.
	 * @return The ShapeType of the shape.
	 */
	public function getType():ShapeType;
	
	/**
	 * Gets a vector of data that represents the shape geometry, the format varies depending on the ShapeType.
	 * @return The shape data.
	 */
	public function getRawShapeData():Array<Float>;
	
	/**
	 * Gets a string that represents a SVG element that describes the shape geometry.
	 * @return The SVG shape data that represents this shape.
	 */
	public function getSvgShapeData():String;
}