package;

import geometrize.ArraySetTest;
import geometrize.CoreTest;
import geometrize.ModelTest;
import geometrize.StateTest;
import geometrize.UtilTest;
import geometrize.bitmap.BitmapTest;
import geometrize.bitmap.RgbaTest;
import geometrize.exporter.ShapeJsonExporterTest;
import geometrize.exporter.SvgExporterTest;
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
import utest.Runner;
import utest.ui.Report;

class TestMain {
	static function main() {
		var runner = new Runner();
		runner.addCase(new BitmapTest());
		runner.addCase(new RgbaTest());
		runner.addCase(new ShapeJsonExporterTest());
		runner.addCase(new SvgExporterTest());
		runner.addCase(new RasterizerTest());
		runner.addCase(new ScanlineTest());
		runner.addCase(new ImageRunnerOptionsTest());
		runner.addCase(new ImageRunnerTest());
		runner.addCase(new CircleTest());
		runner.addCase(new EllipseTest());
		runner.addCase(new LineTest());
		runner.addCase(new RectangleTest());
		runner.addCase(new RotatedEllipseTest());
		runner.addCase(new RotatedRectangleTest());
		runner.addCase(new ShapeFactoryTest());
		runner.addCase(new TriangleTest());
		runner.addCase(new ArraySetTest());
		runner.addCase(new CoreTest());
		runner.addCase(new ModelTest());
		runner.addCase(new StateTest());
		runner.addCase(new UtilTest());
		Report.create(runner);
		runner.run();
	}
}