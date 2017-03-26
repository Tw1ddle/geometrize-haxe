package primitive;

/**
 * Utility functions.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class Util {
	/**
	 * Clamps a value within a range.
	 * @param	value	The value to clamp.
	 * @param	min	The lower bound of the range.
	 * @param	max	The upper bound of the range.
	 * @return	The clamped value.
	 */
	public static inline function clamp(value:Int, min:Int, max:Int):Int {
		Sure.sure(min <= max);
		return value < min ? min : value > max ? max : value;
	}
	
	/**
	 * Compares two values and returns the smaller one.
	 * @param	first	The first value.
	 * @param	second	The second value.
	 * @return	The smaller value.
	 */
	public static inline function min(first:Int, second:Int):Int {
		return first < second ? first : second;
	}
	
	/**
	 * Compare two values and returns the larger one.
	 * @param	first	The first value.
	 * @param	second	The second value.
	 * @return	The larger value.
	 */
	public static inline function max(first:Int, second:Int):Int {
		return first > second ? first : second;
	}
	
	/**
	 * Converts a value measured in degrees to radians.
	 * @param	degrees	Degrees value to convert to radians.
	 * @return	The value converted to radians.
	 */
	public static inline function toRadians(degrees:Float):Float {
		return degrees * Math.PI / 180;
	}
	
	/**
	 * Converts a value measured in radians to degrees.
	 * @param	radians	Radians value to convert to degrees.
	 * @return	The value converted to degrees.
	 */
	public static inline function toDegrees(radians:Float):Float {
		return radians * 180 / Math.PI;
	}
	
	/**
	 * Returns a random integer in the range (inclusive).
	 * @param	lower	The lower bound.
	 * @param	upper	The upper bound.
	 * @return	A random integer in the range [lower:upper] inclusive.
	 */
	public static inline function random(lower:Int, upper:Int):Int {
		Sure.sure(lower <= upper);
		return lower + Math.floor((upper - lower + 1) * Math.random());
	}
	
	/**
	 * Returns a random item from an array.
	 * @param	a	The array to pick a random item from.
	 * @return	A random item from the array.
	 */
	public static inline function randomArrayItem<T>(a:Array<T>):T {
		Sure.sure(a != null && a.length > 0);
		return a[random(0, a.length - 1)];
	}
}