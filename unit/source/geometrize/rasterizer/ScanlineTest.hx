package geometrize.rasterizer;

import geometrize.rasterizer.Scanline;
import utest.Assert;

class ScanlineTest {
	public function new() {}
	
	public function testCreateScanline() {
		var scanline:Scanline = new Scanline(50, 10, 20);
		Assert.equals(scanline.y, 50);
		Assert.equals(scanline.x1, 10);
		Assert.equals(scanline.x2, 20);
	}
	
	public function testTrim() {
		var scanlines = [];
		for (i in 0...20) {
			scanlines.push(new Scanline(i, i, i * 2));
		}
		
		var trimmedLines = Scanline.trim(scanlines, 100, 100);
		
		Assert.equals(scanlines.length, trimmedLines.length);
		
		for (i in 0...scanlines.length) {
			Assert.equals(scanlines[i], trimmedLines[i]);
		}
	}
}