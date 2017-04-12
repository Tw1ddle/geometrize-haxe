package geometrize.bitmap;

import geometrize.bitmap.Rgba;
import massive.munit.Assert;

class RgbaTest {
	@Test
	function testCreateRgba() {
		Assert.areEqual(Rgba.create(0, 0, 0, 0), 0x00000000);
		Assert.areEqual(Rgba.create(255, 255, 255, 255), 0xFFFFFFFF);
		
		Assert.areEqual(Rgba.create(255, 255, 255, 255), Rgba.create(255, 255, 255, 255));
		Assert.areEqual(Rgba.create( -1, -1, -1, -1), Rgba.create( -1, -1, -1, -1));
		
		Assert.areNotEqual(Rgba.create(1, 2, 3, 4), Rgba.create(255, 254, 253, 252));
		Assert.areNotEqual(Rgba.create(1, 2, 3, 4), Rgba.create(4, 3, 2, 1));
		
		Assert.areEqual(0xFFFFFFFF, Rgba.create(9001, 9001, 9001, 9001));
		Assert.areEqual(0x00000000, Rgba.create(-9001, -9001, -9001, -9001));
		
		Assert.areEqual(Rgba.create(255, 0, 0, 0), 0xFF000000);
		Assert.areEqual(Rgba.create(0, 255, 0, 0), 0x00FF0000);
		Assert.areEqual(Rgba.create(0, 0, 255, 0), 0x0000FF00);
		Assert.areEqual(Rgba.create(0, 0, 0, 255), 0x000000FF);
		
		Assert.areEqual(Rgba.create(255, 0, 255, 0), 0xFF00FF00);
		Assert.areEqual(Rgba.create(0, 255, 0, 255), 0x00FF00FF);
	}
	
	@Test
	function testAddRgba() {
		Assert.areEqual(0xFFFFFFFF, Rgba.create(128, 128, 128, 128) + Rgba.create(127, 127, 127, 127));
		Assert.areEqual(0xFF00FF00, Rgba.create(255, 0, 0, 0) + Rgba.create(0, 0, 255, 0));
		
		Assert.areEqual(0xFFFFFFFF, Rgba.create(255, 255, 255, 255) + Rgba.create(255, 255, 255, 255) + Rgba.create(255, 255, 255, 255));
		Assert.areEqual(0xFFFFFFFF, Rgba.create(200, 200, 200, 200) + Rgba.create(300, 300, 300, 300));
		
		Assert.areEqual(0x10101010, Rgba.create(8, 8, 8, 8) + Rgba.create(4, 4, 4, 4) + Rgba.create(4, 4, 4, 4));
	}
	
	@Test
	function testSubtractRgba() {
		Assert.areEqual(0x00000000, Rgba.create(255, 255, 255, 255) - Rgba.create(255, 255, 255, 255) - Rgba.create(255, 255, 255, 255));
		Assert.areEqual(0x00FF00FF, Rgba.create(255, 255, 255, 255) - Rgba.create(255, 0, 255, 0));
		
		Assert.areEqual(0x00000000, Rgba.create(128, 128, 128, 128) - Rgba.create(128, 128, 128, 128));
		Assert.areEqual(0x00000000, Rgba.create(50, 50, 50, 50) - Rgba.create(100, 100, 100, 100));
		
		Assert.areEqual(0x10101010, Rgba.create(32, 32, 32, 32) - Rgba.create(16, 16, 16, 16));
	}
	
	@Test
	function testAccessors() {
		var color = Rgba.create(255, 127, 63, 31);
		Assert.areEqual(color.r, 255);
		Assert.areEqual(color.g, 127);
		Assert.areEqual(color.b, 63);
		Assert.areEqual(color.a, 31);
		
		Assert.areEqual(128, Rgba.fromInt(128));
		Assert.areEqual(-1, Rgba.fromInt(-1));
		Assert.areNotEqual(10, Rgba.fromInt(20));
	}
}