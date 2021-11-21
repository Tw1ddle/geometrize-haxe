package geometrize;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.Tools;

#end

/**
 * Abstract enum tools.
 * Based on https://code.haxe.org/category/macros/enum-abstract-values.html by Dan Korostelev
 */
class AbstractEnumTools {
	/**
	 * Extracts the values of an enum abstract and returns them in an array.
	 * For example, passing an enum abstract MyInts(Int) { var a = 1; var b = 2; var c = 3; } would yield [1, 2, 3].
	 * @param	typePath	The type path of the enum abstract.
	 * @return	An array containing the values defined by the enum abstract.
	 */
	public static macro function getValues(typePath:Expr):Expr {
		// Get the type from a given expression converted to string.
		// This will work for identifiers and field access which is what we need, it will also consider local imports.
		// If expression is not a valid type path or type is not found, compiler will give a error here.
		var type = Context.getType(typePath.toString());
		
		// Switch on the type and check if it's an abstract with @:enum metadata
		switch (type.follow()) {
			case TAbstract(_.get() => ab, _) if (ab.meta.has(":enum")):
				// @:enum abstract values are actually static fields of the abstract implementation class, marked with @:enum and @:impl metadata.
				// We generate an array of expressions that access those fields.
				// Note that this is a bit of implementation detail, so it can change in future Haxe versions, but it's been stable so far.
				var valueExprs = [];
				for (field in ab.impl.get().statics.get()) {
					if (field.meta.has(":enum") && field.meta.has(":impl")) {
						var fieldName = field.name;
						valueExprs.push(macro $typePath.$fieldName);
					}
				}
				
				if (valueExprs.length == 0) {
					throw new Error("No values found on this enum abstract, assuming this is because this macro is broken", typePath.pos);
				}
				return macro $a{valueExprs}; // Return collected expressions as an array declaration.
			
			default:
				// The given type is not an abstract, or doesn't have @:enum metadata, show a nice error message.
				throw new Error(type.toString() + " should be @:enum abstract, or the macro's abstract enum checking logic is broken", typePath.pos);
		}
	}
}