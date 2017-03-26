package primitive.bitmap;

import haxe.io.Bytes;
import massive.munit.Assert;
import primitive.Util;
import primitive.bitmap.Bitmap;
import primitive.bitmap.PixelFormat;
import primitive.bitmap.Rgba;

class PixelFormatTest {
	@Test
	function testArgbToRgba() {
		var color = Rgba.create(10, 20, 30, 40);
		var bitmap = Bitmap.create(100, 100, color);
		
		var bytes:Bytes = bitmap.getBytes();
		
	}
}