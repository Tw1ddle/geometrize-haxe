package primitive.bitmap;

import haxe.io.Bytes;

/**
 * Pixel format conversion helper functions.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class PixelFormat {
	/**
	 * Converts a buffer of image data in ARGB format to RGBA in-place.
	 * @param	bytes	The byte buffer to convert.
	 * @return	The bytes converted to RGBA format.
	 */
	public static inline function argbToRgba(bytes:Bytes):Bytes {
		Sure.sure(bytes != null);
		Sure.sure(bytes.length % 4 == 0);
		
		var length:Int = bytes.length;
		var i:Int = 0;
		while (i < length) {
			var a = bytes.get(i);
			var r = bytes.get(i + 1);
			var g = bytes.get(i + 2);
			var b = bytes.get(i + 3);
			bytes.set(i, r);
			bytes.set(i + 1, g);
			bytes.set(i + 2, b);
			bytes.set(i + 3, a);
			i += 4;
		}
		return bytes;
	}
	
	/**
	 * Converts a buffer of image data in RGBA format to ARGB in-place.
	 * @param	bytes	The byte buffer to convert.
	 * @return	The bytes converted to ARGB format.
	 */
	public static inline function rgbaToArgb(bytes:Bytes):Bytes {
		Sure.sure(bytes != null);
		Sure.sure(bytes.length % 4 == 0);
		
		var length:Int = bytes.length;
		var i:Int = 0;
		while (i < length) {
			var r = bytes.get(i);
			var g = bytes.get(i + 1);
			var b = bytes.get(i + 2);
			var a = bytes.get(i + 3);
			bytes.set(i, a);
			bytes.set(i + 1, r);
			bytes.set(i + 2, g);
			bytes.set(i + 3, b);
			i += 4;
		}
		return bytes;
	}
	
	/**
	 * Converts a buffer of image data in BRGA format to RGBA in-place.
	 * @param	bytes	The byte buffer to convert.
	 * @return	The bytes converted to RGBA format.
	 */
	public static inline function brgaToRgba(bytes:Bytes):Bytes {
		Sure.sure(bytes != null);
		Sure.sure(bytes.length % 4 == 0);
		
		var length:Int = bytes.length;
		var i:Int = 0;
		while (i < length) {
			var b = bytes.get(i);
			var r = bytes.get(i + 1);
			var g = bytes.get(i + 2);
			var a = bytes.get(i + 3);
			bytes.set(i, r);
			bytes.set(i + 1, g);
			bytes.set(i + 2, b);
			bytes.set(i + 3, a);
			i += 4;
		}
		return bytes;
	}
	
	/**
	 * Converts a buffer of image data in RGBA format to BGRA in-place.
	 * @param	bytes	The byte buffer to convert.
	 * @return	The bytes converted to BGRA format.
	 */
	public static inline function rgbaToBgra(bytes:Bytes):Bytes {
		Sure.sure(bytes != null);
		Sure.sure(bytes.length % 4 == 0);
		
		var length:Int = bytes.length;
		var i:Int = 0;
		while (i < length) {
			var r = bytes.get(i);
			var g = bytes.get(i + 1);
			var b = bytes.get(i + 2);
			var a = bytes.get(i + 3);
			bytes.set(i, b);
			bytes.set(i + 1, g);
			bytes.set(i + 2, r);
			bytes.set(i + 3, a);
			i += 4;
		}
		return bytes;
	}
}