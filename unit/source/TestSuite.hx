import massive.munit.TestSuite;

import primitive.ArraySetTest;
import primitive.bitmap.BitmapTest;
import primitive.bitmap.RgbaTest;
import primitive.CoreTest;
import primitive.exporter.ShapeJsonExporterTest;
import primitive.exporter.SvgExporterTest;
import primitive.ModelTest;
import primitive.rasterizer.RasterizerTest;
import primitive.rasterizer.ScanlineTest;
import primitive.runner.ImageRunnerOptionsTest;
import primitive.runner.ImageRunnerTest;
import primitive.shape.CircleTest;
import primitive.shape.EllipseTest;
import primitive.shape.LineTest;
import primitive.shape.RectangleTest;
import primitive.shape.RotatedEllipseTest;
import primitive.shape.RotatedRectangleTest;
import primitive.shape.ShapeFactoryTest;
import primitive.shape.TriangleTest;
import primitive.StateTest;
import primitive.UtilTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(primitive.ArraySetTest);
		add(primitive.bitmap.BitmapTest);
		add(primitive.bitmap.RgbaTest);
		add(primitive.CoreTest);
		add(primitive.exporter.ShapeJsonExporterTest);
		add(primitive.exporter.SvgExporterTest);
		add(primitive.ModelTest);
		add(primitive.rasterizer.RasterizerTest);
		add(primitive.rasterizer.ScanlineTest);
		add(primitive.runner.ImageRunnerOptionsTest);
		add(primitive.runner.ImageRunnerTest);
		add(primitive.shape.CircleTest);
		add(primitive.shape.EllipseTest);
		add(primitive.shape.LineTest);
		add(primitive.shape.RectangleTest);
		add(primitive.shape.RotatedEllipseTest);
		add(primitive.shape.RotatedRectangleTest);
		add(primitive.shape.ShapeFactoryTest);
		add(primitive.shape.TriangleTest);
		add(primitive.StateTest);
		add(primitive.UtilTest);
	}
}
