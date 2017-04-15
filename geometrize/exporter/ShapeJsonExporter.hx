package geometrize.exporter;

import geometrize.Model.ShapeResult;
import geometrize.bitmap.Rgba;
import geometrize.shape.ShapeType;

/**
 * Exports the shape data as JSON.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class ShapeJsonExporter {
	public static function export(shapes:Array<ShapeResult>):String {
		var result:String = "";
		
		for (i in 0...shapes.length) {
			var shape:ShapeResult = shapes[i];
			var type:ShapeType = shape.shape.getType();
			var data:Array<Float> = shape.shape.getRawShapeData();
			var color:Rgba = shape.color;
			var score:Float = shape.score;
			result += "    shape_" + i + "\":{\n";
			result += "        \"type\":" + type + ",\n";
			result += "        \"data\":" + "[";
			
			for (item in 0...data.length) {
				if (item <= data.length - 2) {
					result += data[item] + ",";
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
			
			if (i <= shapes.length - 2) {
				result += ",\n";
			}
		}
		
		result += "\n}";
		return result;
	}
}