package geometrize;

import geometrize.State;
import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;
import geometrize.shape.Rectangle;
import utest.Assert;

class StateTest {
	public function new() {}
	
	public function makeState():State {
		var bitmap:Bitmap = Bitmap.create(50, 50, Rgba.create(128, 128, 128, 128));
		return new State(new Rectangle(100, 100), 128, bitmap, bitmap.clone(), bitmap.clone());
	}
	
	public function testMutate() {
		var state:State = makeState();
		var oldState:State = state.mutate();
		
		Assert.notEquals(state, oldState);
		
		Assert.equals(state.score, oldState.score);
	}
	
	public function testClone() {
		var state:State = makeState();
		var clone:State = state.clone();
		
		Assert.notEquals(state, clone);
	}
}