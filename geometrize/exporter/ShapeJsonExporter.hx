package geometrize.exporter;

import geometrize.Model.ShapeResult;
import geometrize.bitmap.Rgba;
import geometrize.shape.ShapeType;

/**
 * Exports the shape data as JSON.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
@:expose
class ShapeJsonExporter {
	/**
	 * Exports an array of shapes to JSON.
	 * @param	shapes	The shape data to export.
	 * @return	A string representing the JSON shape data for the shapes.
	 */
	public static function export(shapes:Array<ShapeResult>):String {
		return "[\n" + exportShapes(shapes) + "\n]";
	}
	
	/**
	 * Exports an array of shapes to JSON.
	 * @param	shapes	The shape data to export.
	 * @return	A string representing the JSON shape data for the shapes.
	 */
	public static function exportShapes(shapes:Array<ShapeResult>):String {
		var results:String = "";
		for (i in 0...shapes.length) {
			results += exportShape(shapes[i]);
			if (i != shapes.length - 1) {
				results += ",\n";
			}
		}
		return results;
	}
	
	/**
	 * Exports a shape to JSON
	 * @param	shape	The shape data to export.
	 * @return	A string representing the JSON shape data for the shape.
	 */
	public static function exportShape(shape:ShapeResult):String {
		var result:String = "    {\n";
		
		var type:ShapeType = shape.shape.getType();
		var data:Array<Float> = shape.shape.getRawShapeData();
		var color:Rgba = shape.color;
		var score:Float = shape.score;
		result += "        \"type\":" + type + ",\n";
		result += "        \"data\":" + "[";
		
		for (item in 0...data.length) {
			result += data[item];
			if (item <= data.length - 2) {
				result += ",";
			}
		}
		result += "],\n";
		
		result += "        \"color\":" + "[";
		result += color.r + ",";
		result += color.g + ",";
		result += color.b + ",";
		result += color.a;
		result += "],\n";
		
		result += "        \"score\":" + score + "\n";
		
		result += "    }";
		
		return result;
	}
}