package geometrize.bitmap;

import haxe.ds.Vector;
import haxe.io.Bytes;
import geometrize.Util;

/**
 * Helper class for working with bitmap data.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
@:expose
class Bitmap {
	/**
	 * The width of the bitmap considering its offset, if any.
	 */
	public var width:Int;

	/**
	 * The height of the bitmap considering its offset, if any.
	 */
	public var height:Int;

	private var originalWidth:Int;
	private var originalHeight:Int;
	private var offsetX:Int;
	private var offsetY:Int;

	/**
	 * Sets the bitmap offset, this is, a region inside relative to which pixel read and write operations are made.
	 * Calling this method without parameters will remove the offset and reset to default behavior.
	**/
	public function setOffset(?offset:Util.Rect):Void {
		if (offset == null) {
			width = originalWidth;
			height = originalHeight;
			offsetX = 0;
			offsetY = 0;
		} else {
      Sure.sure(offset.width>0 && offset.x+offset.width<=originalWidth);
      Sure.sure(offset.height>0 && offset.y+offset.height<=originalHeight);
      Sure.sure(offset.x>=0);
      Sure.sure(offset.y>=0);
			width = offset.width;
			height = offset.height;
			offsetX = offset.x;
			offsetY = offset.y;
		}
	}

	/**
	 * Internal method used to create a bitmap instance of given amount of pixels.
	 * @param length mount of pixels in the new bitmap (width * height).
	**/
	static function createBitmapOfLength(w:Int, h:Int, length:Int):Bitmap {
		var bitmap = new Bitmap();
		bitmap.width = w;
		bitmap.height = h;
		bitmap.originalWidth = w;
		bitmap.originalHeight = h;
    bitmap.offsetX=0;
    bitmap.offsetY=0;
		bitmap.data = new Vector(length);
		return bitmap;
	}

	/**
	 * The bitmap data.
	 */
	private var data:Vector<Rgba>;

	/**
	 * Creates a new bitmap, filled with the given color.
	 * @param	w		The width of the bitmap.
	 * @param	h		The height of the bitmap.
	 * @param	color	The starting background color of the bitmap.
	 * @return	The new bitmap.
	 */
	public static inline function create(w:Int, h:Int, color:Rgba):Bitmap {
		var bitmap = createBitmapOfLength(w, h, w * h);
		var i:Int = 0;
		while (i < bitmap.data.length) {
			bitmap.data.set(i, color);
			i++;
		}
		return bitmap;
	}

	/**
	 * Creates a new bitmap from the supplied byte data.
	 * @param	w		The width of the bitmap.
	 * @param	h		The height of the bitmap.
	 * @param	bytes	The byte data to fill the bitmap with, must be width * height * depth long.
	 * @return	The new bitmap.
	 */
	public static inline function createFromBytes(w:Int, h:Int, bytes:Bytes):Bitmap {
		Sure.sure(bytes != null);
		Sure.sure(bytes.length == w * h * 4); // Assume 4-byte RGBA8888 pixel format
		var bitmap = createBitmapOfLength(w, h, Std.int(bytes.length / 4));
		var i:Int = 0;
		var x:Int = 0;
		while (i < bytes.length) {
			bitmap.data.set(x, Rgba.create(bytes.get(i), bytes.get(i + 1), bytes.get(i + 2), bytes.get(i + 3)));
			i += 4;
			x++;
		}
		return bitmap;
	}

	/**
	 * Creates a new bitmap from the supplied array of bytes. Useful for target language consumers
	 * that don't have direct access to the Bytes Haxe standard library class.
	 * @param	w		The width of the bitmap.
	 * @param	h		The height of the bitmap.
	 * @param	bytes	The byte data to fill the bitmap with, must be width * height * depth long.
	 * @return	The new bitmap.
	 */
	public static inline function createFromByteArray(w:Int, h:Int, bytes:Array<Int>):Bitmap {
		var data:Bytes = Bytes.alloc(bytes.length);
		var i:Int = 0;
		while (i < bytes.length) {
			data.set(i, bytes[i]);
			i++;
		}
		return Bitmap.createFromBytes(w, h, data);
	}

	/**
	 * Gets a pixel at the given coordinate considering its offset, if any.
	 * @param	x	The x-coordinate.
	 * @param	y	The y-coordinate.
	 * @return	The pixel color value.
	 */
	public inline function getPixel(x:Int, y:Int):Rgba {
		return data.get(getCoordsIndex(x,y));
	}

	/**
	 * Sets a pixel at the given coordinate considering its offset, if any.
	 * @param	x	The x-coordinate.
	 * @param	y	The y-coordinate.
	 * @param	color	The color value to set at the given coordinate.
	 */
	public inline function setPixel(x:Int, y:Int, color:Rgba):Void {
		data.set(getCoordsIndex(x,y), color);
	}

private inline function getCoordsIndex(x:Int, y:Int){
		var absoluteStart = offsetY * originalWidth + offsetX;
		var absoluteXDiff = (originalWidth * y) + x + offsetX;// + ()  (originalWidth - width) * y; // TODO: maybe *(y-1)
		var relativeIndex = 0;//width * y + x;
		var index = absoluteStart + relativeIndex + absoluteXDiff - offsetX;
    return index;
}
	/**
	 * Makes a deep copy of the bitmap whole data (without considering its offset).
	 * @return	The deep copy of the bitmap data.
	 */
	public inline function clone():Bitmap {
		var bitmap = createBitmapOfLength(originalWidth, originalHeight, data.length);
		for (i in 0...data.length) {
			bitmap.data.set(i, data.get(i));
		}
		return bitmap;
	}

	/**
	 * Fills the whole bitmap with the given color without consider its offset.
	 * @param	color The color to fill the bitmap with.
	 */
	public inline function fill(color:Rgba):Void {
		var idx:Int = 0;
		while (idx < data.length) {
			data.set(idx, color.r);
			data.set(idx + 1, color.g);
			data.set(idx + 2, color.b);
			data.set(idx + 3, color.a);
			idx += 4;
		}
	}

	/**
	 * Gets the raw bitmap data bytes of the whole bitmap without considering its offset.
	 * @return	The bitmap data.
	 */
	public inline function getBytes():Bytes {
		var bytes:Bytes = Bytes.alloc(data.length * 4);
		var i:Int = 0;
		while (i < data.length) {
			var idx:Int = i * 4;
			bytes.set(idx, data.get(i).r);
			bytes.set(idx + 1, data.get(i).g);
			bytes.set(idx + 2, data.get(i).b);
			bytes.set(idx + 3, data.get(i).a);
			i++;
		}
		return bytes;
	}

	/**
	 * Private constructor.
	 */
	private function new():Void {
		// No implementation
	}
}
