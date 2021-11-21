package geometrize.exporter;

import geometrize.Model.ShapeResult;
import geometrize.bitmap.Rgba;
import geometrize.shape.ShapeType;

/**
 * Exports the shape data as SVG.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
@:expose
class SvgExporter {
	/**
	* A hook that an SVG exporter should use to augment shape styling produced by the getSvgShapeData method.
	* Note that shape subclasses should include this in shape data - so an SVG exporter implementation must remove/replace this hook string to produce correct SVG files.
	*/
	public static var SVG_STYLE_HOOK:String = "::svg_style_hook::";
	
	/**
	 * Exports the shapes to an SVG image.
	 * @param	shapes	The shape data to export.
	 * @param	width	The width of the SVG image.
	 * @param	height	The height of the SVG image.
	 * @return	A string representing the SVG image.
	 */
	public static function export(shapes:Array<ShapeResult>, width:Int, height:Int):String {
		var results:String = getSvgPrelude();
		results += getSvgNodeOpen(width, height);
		results += exportShapes(shapes);
		results += getSvgNodeClose();
		return results;
	}
	
	/**
	 * Exports an array of shapes to SVG.
	 * @param	shapes	The shape data to export.
	 * @return	A string representing the SVG shape data for the shapes.
	 */
	public static function exportShapes(shapes:Array<ShapeResult>):String {
		var results:String = "";
		for (i in 0...shapes.length) {
			results += exportShape(shapes[i]);
			if (i != shapes.length - 1) {
				results += "\n";
			}
		}
		return results;
	}
	
	/**
	 * Exports a single shape to SVG.
	 * @param	shape The shape data to export.
	 * @return	A string representing the SVG shape data for the shape.
	 */
	public static function exportShape(shape:ShapeResult):String {
		return StringTools.replace(shape.shape.getSvgShapeData(), SVG_STYLE_HOOK, stylesForShape(shape));
	}
	
	public static function getSvgPrelude():String {
		return "<?xml version=\"1.0\" standalone=\"no\"?>\n";
	}
	
	public static function getSvgNodeOpen(width:Int, height:Int):String {
		return "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.2\" baseProfile=\"tiny\" width=\"" + width + "\" height=\"" + height + "\">\n";
	}
	
	public static function getSvgNodeClose():String {
		return "</svg>";
	}
	
	private static function stylesForShape(shape:ShapeResult):String {
		return switch (shape.shape.getType()) {
			case ShapeType.LINE, ShapeType.QUADRATIC_BEZIER:
				strokeForColor(shape.color) + " stroke-width=\"1\" fill=\"none\" " + strokeOpacityForAlpha(shape.color.a);
			default:
				fillForColor(shape.color) + " " + fillOpacityForAlpha(shape.color.a);
		}
	}
	
	private static function rgbForColor(color:Rgba):String {
		return "rgb(" + color.r + "," + color.g + "," + color.b + ")";
	}
	
	private static function strokeForColor(color:Rgba):String {
		return "stroke=\"" + rgbForColor(color) + "\"";
	}
	
	private static function fillForColor(color:Rgba):String {
		return "fill=\"" + rgbForColor(color) + "\"";
	}
	
	private static function fillOpacityForAlpha(alpha:Float):String {
		return "fill-opacity=\"" + alpha / 255.0 + "\"";
	}
	
	private static function strokeOpacityForAlpha(alpha:Float):String {
		return "stroke-opacity=\"" + alpha / 255.0 + "\"";
	}
}