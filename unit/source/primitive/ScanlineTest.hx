package primitive;

import massive.munit.Assert;
import primitive.Scanline;

class ScanlineTest {
	@Test
	function testCreateScanline() {
		var scanline:Scanline = new Scanline(50, 10, 20, 255);
		Assert.areEqual(scanline.y, 50);
		Assert.areEqual(scanline.x1, 10);
		Assert.areEqual(scanline.x2, 20);
		Assert.areEqual(scanline.alpha, 255);
	}
	
	@Test
	function testTrim() {
		var scanlines = [];
		for (i in 0...20) {
			scanlines.push(new Scanline(i, i, i * 2, 255));
		}
		
		var trimmedLines = Scanline.trim(scanlines, 100, 100);
		
		Assert.areEqual(scanlines.length, trimmedLines.length);
		
		for (i in 0...scanlines.length) {
			Assert.areEqual(scanlines[i], trimmedLines[i]);
		}
	}
}