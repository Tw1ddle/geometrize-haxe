package geometrize;

import massive.munit.Assert;
import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;
import geometrize.Util;

class UtilTest {
	@Test
	function testClamp() {
		Assert.areEqual(Util.clamp(10, 0, 20), 10);
		Assert.areEqual(Util.clamp(-10, -20, 0), -10);
		Assert.areEqual(Util.clamp(500000, 0, 1000000), 500000);
		Assert.areEqual(Util.clamp(-500000, -1000000, 0), -500000);
		
		Assert.areEqual(Util.clamp(10, 0, 5), 5);
		Assert.areEqual(Util.clamp(10, -5, 5), 5);
		
		Assert.areEqual(Util.clamp(-10, 0, 5), 0);
		Assert.areEqual(Util.clamp(-10, -5, 5), -5);
	}
	
	@Test
	function testGetAverageImageColor() {
		var color:Rgba = Rgba.create(10, 50, 90, 255);
		var image:Bitmap = Bitmap.create(50, 50, color);
		Assert.areEqual(color, Util.getAverageImageColor(image));
		
		var color2:Rgba = Rgba.create(20, 30, 40, 255);
		var image2:Bitmap = Bitmap.create(2, 1, color2);
		image2.setPixel(0, 0, Rgba.create(40, 100, 120, 255));
		Assert.areEqual(Rgba.create(30, 65, 80, 255), Util.getAverageImageColor(image2));
	}
	
	@Test
	function testMin() {
		Assert.areEqual(Util.min(-5, -10), -10);
		Assert.areEqual(Util.min(0, 0), 0);
		Assert.areEqual(Util.min(-5, 5), -5);
		Assert.areEqual(Util.min(10, 20), 10);
	}
	
	@Test
	function testMax() {
		Assert.areEqual(Util.max(-5, -10), -5);
		Assert.areEqual(Util.max(0, 0), 0);
		Assert.areEqual(Util.max(-5, 5), 5);
		Assert.areEqual(Util.max(10, 20), 20);
	}
	
	@Test
	function testToRadians() {
		Assert.areEqual(Util.toRadians(0), 0);
		Assert.areEqual(Util.toRadians(180), Math.PI);
	}
	
	@Test
	function testToDegrees() {
		Assert.areEqual(Util.toDegrees(0), 0);
		Assert.areEqual(Util.toDegrees(Math.PI), 180);
	}
	
	@Test
	function testRandom() {
		for (i in 0...10000) {
			var random = Util.random(-i, i);
			Assert.isTrue(random >= -i && random <= i);
		}
	}
}