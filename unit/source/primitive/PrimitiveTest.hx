package primitive;

import massive.munit.Assert;
import primitive.State;
import primitive.bitmap.Bitmap;
import primitive.bitmap.Rgba;
import primitive.shape.Rectangle;
import primitive.Scanline;

class PrimitiveTest {
	private function computeScanlinesColor(targetColor:Rgba, currentColor:Rgba, alpha:Int):Rgba {
		var target = Bitmap.create(10, 10, targetColor);
		var current = Bitmap.create(10, 10, currentColor);
		var lines:Array<Scanline> = [ for (y in 0...10) new Scanline(y, 0, 10, 0) ];
		
		trace(Primitive.computeColor(target, current, lines, alpha));
		
		// Note the only alpha term used is the scanline alpha
		return Primitive.computeColor(target, current, lines, alpha);
	}
	
	@Test
	function testComputeScanlinesColorWholeImage() {
		Assert.areEqual(Rgba.create(23, 0, 0, 128),
		computeScanlinesColor(Rgba.create(12, 12, 12, 0), Rgba.create(0, 212, 62, 0), 128));
	}
	
	@Test
	function testDrawLines() {
		var image = Bitmap.create(50, 50, Rgba.create(10, 20, 30, 128));
		var lines:Array<Scanline> = [ for (y in 10...50) new Scanline(y, 0, 50, 255) ];
		
		Primitive.drawLines(image, Rgba.create(10, 20, 30, 128), lines);
		
		// TODO check drawn lines
	}
	
	@Test
	function testCopyLines() {
		var color:Rgba = Rgba.create(128, 64, 32, 200);
		
		var width:Int = 10;
		var height:Int = 10;
		
		var source = Bitmap.create(width, height, color);
		var destination = Bitmap.create(width, height, Rgba.create(0, 0, 0, 0));
		
		var lines:Array<Scanline> = [ for (y in 3...7) new Scanline(y, 3, 7, 255) ];
		
		Primitive.copyLines(destination, source, lines);
		
		for (line in lines) {
			var y:Int = line.y;
			for (x in line.x1...line.x2) {
				Assert.areEqual(destination.getPixel(x, y), color);
			}
		}
	}
	
	@Test
	function testDifferencePartial() {
		
	}
	
	@Test
	function testEnergy() {
		
	}
	
	@Test
	function testBestHillClimbState() {
		
	}
	
	@Test
	function testBestRandomState() {
		
	}
	
	@Test
	function testHillClimb() {
		
	}
	
	@Test
	function testGetAverageImageColor() {
		var color:Rgba = Rgba.create(10, 50, 90, 255);
		var image:Bitmap = Bitmap.create(50, 50, color);
		Assert.areEqual(color, Primitive.getAverageImageColor(image));
		
		var color2:Rgba = Rgba.create(20, 30, 40, 255);
		var image2:Bitmap = Bitmap.create(2, 1, color2);
		image2.setPixel(0, 0, Rgba.create(40, 100, 120, 255));
		Assert.areEqual(Rgba.create(30, 65, 80, 255), Primitive.getAverageImageColor(image2));
	}
}