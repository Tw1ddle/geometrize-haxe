package geometrize;

import massive.munit.Assert;
import geometrize.State;
import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;
import geometrize.shape.Rectangle;

class StateTest {
	function makeState():State {
		var bitmap:Bitmap = Bitmap.create(50, 50, Rgba.create(128, 128, 128, 128));
		return new State(new Rectangle(100, 100), 128, bitmap, bitmap.clone(), bitmap.clone());
	}
	
	@Test
	function testMutate() {
		var state:State = makeState();
		var oldState:State = state.mutate();
		
		Assert.areNotEqual(state, oldState);
		
		Assert.areEqual(state.score, oldState.score);
	}
	
	@Test
	function testClone() {
		var state:State = makeState();
		var clone:State = state.clone();
		
		Assert.areNotEqual(state, clone);
	}
}