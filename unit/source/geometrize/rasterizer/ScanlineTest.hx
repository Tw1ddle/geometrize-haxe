package geometrize.rasterizer;

import massive.munit.Assert;
import geometrize.rasterizer.Scanline;

class ScanlineTest {
	@Test
	function testCreateScanline() {
		var scanline:Scanline = new Scanline(50, 10, 20);
		Assert.areEqual(scanline.y, 50);
		Assert.areEqual(scanline.x1, 10);
		Assert.areEqual(scanline.x2, 20);
	}
	
	@Test
	function testTrim() {
		var scanlines = [];
		for (i in 0...20) {
			scanlines.push(new Scanline(i, i, i * 2));
		}
		
		var trimmedLines = Scanline.trim(scanlines, 100, 100);
		
		Assert.areEqual(scanlines.length, trimmedLines.length);
		
		for (i in 0...scanlines.length) {
			Assert.areEqual(scanlines[i], trimmedLines[i]);
		}
	}
}