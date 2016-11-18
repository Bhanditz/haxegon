// =================================================================================================
//
//	Starling Framework
//	Copyright Gamua GmbH. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package starling.utils
{
/** Returns the next power of two that is equal to or bigger than the specified number. */
public function getNextPowerOfTwo(number:Float):Int
{
    if (number is Int && number > 0 && (number & (number - 1)) == 0) // see: http://goo.gl/D9kPj
        return number;
    else
    {
        var result:Int = 1;
        number -= 0.000000001; // avoid floating point rounding errors

        while (result < number) result <<= 1;
        return result;
    }
}
}