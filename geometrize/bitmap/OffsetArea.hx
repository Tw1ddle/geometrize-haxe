package geometrize.bitmap;

import geometrize.Util;

/**
 * Base class implementing a rectangular area (originalWidth, originalHeight) with an 
 * internal rectangular offset (offsetX, offsetY, width, height). 
 **/
class OffsetArea {

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
	@:optional private var savedOffset:Util.Rect;

  /**
   * The algorithm will only consider a region of the entire bitmap. 
   * If null is passed it will reset the offset (default behaviour)
   * New shapes will be generated randombly but only inside this region.
  **/
	public inline function setOffset(?offset:Util.Rect):Void {
		if (offset == null) {
			width = originalWidth;
			height = originalHeight;
			offsetX = 0;
			offsetY = 0;
		} else {
			Sure.sure(offset.width > 0);
			Sure.sure(offset.x + offset.width <= originalWidth);
			Sure.sure(offset.height > 0);
			Sure.sure(offset.y + offset.height <= originalHeight);
			Sure.sure(offset.x >= 0);
			Sure.sure(offset.y >= 0);
			width = offset.width;
			height = offset.height;
			offsetX = offset.x;
			offsetY = offset.y;
		}
	}

	/**
	 * @returns current offset or null if none.
	**/
	public inline function getOffSet() {
		if (width != originalWidth || height != originalHeight || offsetX != 0 || offsetY != 0) {
			return {
				x: offsetX,
				y: offsetY,
				width: width,
				height: height
			};
		}
		return null;
	}

	/**
	 * Saves current offset overriding previous saves.
	 * @param reset if given it will also remove current offset.
	 */
	public function saveOffSet(?reset:Bool) {
		savedOffset = getOffSet();
		if (reset) {
			setOffset();
		}
	}

	/**
	 * Restores previously saved offset, if any.
	 */
	public function restoreOffset() {
		if (savedOffset != null) {
			setOffset(savedOffset);
		}
	}

  /**
   * Convert coordinates relative to the offset into absolute coordinates in array index coordinates.
   **/
	public inline function getCoordsIndex(x:Int, y:Int) {
		var absoluteStart = offsetY * originalWidth + offsetX;
		var absoluteIndex = (originalWidth * y) + x;
		var index = absoluteStart + absoluteIndex;
		return index;
	}
}
