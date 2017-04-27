package geometrize;

import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;
import geometrize.rasterizer.Rasterizer;
import geometrize.rasterizer.Scanline;
import utest.Assert;

class CoreTest {
	public function new() {}
	
	private function computeScanlinesColor(targetColor:Rgba, currentColor:Rgba, alpha:Int):Rgba {
		var target = Bitmap.create(10, 10, targetColor);
		var current = Bitmap.create(10, 10, currentColor);
		var lines:Array<Scanline> = [ for (y in 0...10) new Scanline(y, 0, 10) ];
		
		trace(Core.computeColor(target, current, lines, alpha));
		
		// Note the only alpha term used is the scanline alpha
		return Core.computeColor(target, current, lines, alpha);
	}
	
	public function testComputeScanlinesColorWholeImage() {
		Assert.equals(Rgba.create(23, 0, 0, 128),
		computeScanlinesColor(Rgba.create(12, 12, 12, 0), Rgba.create(0, 212, 62, 0), 128));
	}
	
	public function testDrawLines() {
		var image = Bitmap.create(50, 50, Rgba.create(10, 20, 30, 128));
		var lines:Array<Scanline> = [ for (y in 10...50) new Scanline(y, 0, 50) ];
		
		Rasterizer.drawLines(image, Rgba.create(10, 20, 30, 128), lines);
		
		// TODO check drawn lines
	}
	
	public function testCopyLines() {
		var color:Rgba = Rgba.create(128, 64, 32, 200);
		
		var width:Int = 10;
		var height:Int = 10;
		
		var source = Bitmap.create(width, height, color);
		var destination = Bitmap.create(width, height, Rgba.create(0, 0, 0, 0));
		
		var lines:Array<Scanline> = [ for (y in 3...7) new Scanline(y, 3, 7) ];
		
		Rasterizer.copyLines(destination, source, lines);
		
		for (line in lines) {
			var y:Int = line.y;
			for (x in line.x1...line.x2) {
				Assert.equals(destination.getPixel(x, y), color);
			}
		}
	}
	
	public function testDifferencePartial() {
		Assert.equals("TODO", "TODO");
	}
	
	public function testEnergy() {
		Assert.equals("TODO", "TODO");
	}
	
	public function testBestHillClimbState() {
		Assert.equals("TODO", "TODO");
	}
	
	public function testBestRandomState() {
		Assert.equals("TODO", "TODO");
	}
	
	public function testHillClimb() {
		Assert.equals("TODO", "TODO");
	}
}