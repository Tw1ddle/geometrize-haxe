package geometrize.rasterizer;

/**
 * Represents a scanline, a row of pixels running across a bitmap.
 * @author Sam Twidale (https://samcodes.co.uk/)
 */
class Scanline {
	/**
	 * The y-coordinate of the scanline.
	 */
	public var y(default, null):Int;
	/**
	 * The leftmost x-coordinate of the scanline.
	 */
	public var x1(default, null):Int;
	/**
	 * The rightmost x-coordinate of the scanline.
	 */
	public var x2(default, null):Int;

	/**
	 * Creates a new scanline.
	 * @param	y	The y-coordinate.
	 * @param	x1	The leftmost x-coordinate.
	 * @param	x2	The rightmost x-coordinate.
	 */
	public inline function new(y:Int, x1:Int, x2:Int) {
		//Sure.sure(x1 <= x2); // NOTE hot allocations, too expensive to check
		this.y = y;
		this.x1 = x1;
		this.x2 = x2;
	}
	
	/**
	 * Crops the scanning width of an array of scanlines so they do not scan outside of the given area.
	 * @param	scanlines	The scanlines to crop.
	 * @param	w	The width to crop.
	 * @param	h	The height to crop.
	 * @return	Array of the cropped scanlines.
	 */
	public static function trim(scanlines:Array<Scanline>, w:Int, h:Int):Array<Scanline> {
		Sure.sure(scanlines != null);
		
		return scanlines.filter(trimHelper.bind(_, w, h));
	}
	
	private static inline function trimHelper(line:Scanline, w:Int, h:Int):Bool {
		if (line.y < 0 || line.y >= h || line.x1 >= w || line.x2 < 0) {
			return false;
		}
		line.x1 = Util.clamp(line.x1, 0, w - 1);
		line.x2 = Util.clamp(line.x2, 0, w - 1);
		return (line.x1 <= line.x2);
	}
}