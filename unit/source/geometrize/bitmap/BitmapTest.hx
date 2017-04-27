package geometrize.bitmap;

import geometrize.Util;
import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;
import haxe.io.Bytes;
import utest.Assert;

class BitmapTest {
	public function new() {}
	
	public function testCreateBitmap() {
		var color = Rgba.create(10, 20, 30, 40);
		var bitmap = Bitmap.create(100, 100, color);
		
		for (y in 0...bitmap.height) {
			for (x in 0...bitmap.width) {
				Assert.equals(bitmap.getPixel(x, y), color);
			}
		}
	}
	
	public function testCreateBitmapFromData() {
		var makeBitmap = function(width:Int, height:Int):Bitmap {
			var data = Bytes.alloc(width * height * 4);
			for (i in 0...data.length) {
				data.set(i, Util.random(0, 255));
			}
			return Bitmap.createFromBytes(width, height, data);
		}
		
		for (i in 0...10) {
			var bitmap = makeBitmap(50, 50);
			Assert.notEquals(bitmap, null);
		}
	}
	
	public function testCloneBitmap() {
		var bitmap = Bitmap.create(50, 50, Rgba.create(10, 20, 30, 40));
		var clone = bitmap.clone();
		
		Assert.notEquals(bitmap, clone);
		
		for (y in 0...bitmap.height) {
			for (x in 0...bitmap.width) {
				Assert.equals(bitmap.getPixel(x, y), clone.getPixel(x, y));
			}
		}
	}
	
	public function testGetSetPixel() {
		var bitmap = Bitmap.create(50, 50, Rgba.create(10, 20, 30, 40));
		
		var color = Rgba.create(10, 30, 40, 70);
		bitmap.setPixel(0, 0, color);
		Assert.equals(bitmap.getPixel(0, 0), color);
	}
	
	public function testGetWidth() {
		var bitmap = Bitmap.create(250, 10, Rgba.create(10, 20, 30, 40));
		Assert.equals(bitmap.width, 250);
	}
	
	public function testGetHeight() {
		var bitmap = Bitmap.create(10, 250, Rgba.create(10, 20, 30, 40));
		Assert.equals(bitmap.height, 250);
	}
}