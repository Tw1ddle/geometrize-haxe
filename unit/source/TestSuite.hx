import massive.munit.TestSuite;

import geometrize.ArraySetTest;
import geometrize.bitmap.BitmapTest;
import geometrize.bitmap.RgbaTest;
import geometrize.CoreTest;
import geometrize.exporter.ShapeJsonExporterTest;
import geometrize.exporter.SvgExporterTest;
import geometrize.ModelTest;
import geometrize.rasterizer.RasterizerTest;
import geometrize.rasterizer.ScanlineTest;
import geometrize.runner.ImageRunnerOptionsTest;
import geometrize.runner.ImageRunnerTest;
import geometrize.shape.CircleTest;
import geometrize.shape.EllipseTest;
import geometrize.shape.LineTest;
import geometrize.shape.RectangleTest;
import geometrize.shape.RotatedEllipseTest;
import geometrize.shape.RotatedRectangleTest;
import geometrize.shape.ShapeFactoryTest;
import geometrize.shape.TriangleTest;
import geometrize.StateTest;
import geometrize.UtilTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(geometrize.ArraySetTest);
		add(geometrize.bitmap.BitmapTest);
		add(geometrize.bitmap.RgbaTest);
		add(geometrize.CoreTest);
		add(geometrize.exporter.ShapeJsonExporterTest);
		add(geometrize.exporter.SvgExporterTest);
		add(geometrize.ModelTest);
		add(geometrize.rasterizer.RasterizerTest);
		add(geometrize.rasterizer.ScanlineTest);
		add(geometrize.runner.ImageRunnerOptionsTest);
		add(geometrize.runner.ImageRunnerTest);
		add(geometrize.shape.CircleTest);
		add(geometrize.shape.EllipseTest);
		add(geometrize.shape.LineTest);
		add(geometrize.shape.RectangleTest);
		add(geometrize.shape.RotatedEllipseTest);
		add(geometrize.shape.RotatedRectangleTest);
		add(geometrize.shape.ShapeFactoryTest);
		add(geometrize.shape.TriangleTest);
		add(geometrize.StateTest);
		add(geometrize.UtilTest);
	}
}
