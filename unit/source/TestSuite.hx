import massive.munit.TestSuite;

import primitive.bitmap.BitmapTest;
import primitive.bitmap.PixelFormatTest;
import primitive.bitmap.RgbaTest;
import primitive.ModelTest;
import primitive.PrimitiveTest;
import primitive.runner.ImageRunnerTest;
import primitive.ScanlineTest;
import primitive.shape.CircleTest;
import primitive.shape.EllipseTest;
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

		add(primitive.bitmap.BitmapTest);
		add(primitive.bitmap.PixelFormatTest);
		add(primitive.bitmap.RgbaTest);
		add(primitive.ModelTest);
		add(primitive.PrimitiveTest);
		add(primitive.runner.ImageRunnerTest);
		add(primitive.ScanlineTest);
		add(primitive.shape.CircleTest);
		add(primitive.shape.EllipseTest);
		add(primitive.shape.RectangleTest);
		add(primitive.shape.RotatedEllipseTest);
		add(primitive.shape.RotatedRectangleTest);
		add(primitive.shape.ShapeFactoryTest);
		add(primitive.shape.TriangleTest);
		add(primitive.StateTest);
		add(primitive.UtilTest);
	}
}
