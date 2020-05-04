/*

******************
9Slice Rectangles
    --by matharoo
******************

Draw rectangles using the 9slice technique.

-----------------------------------------------------------------

Use draw_9slice() to draw a sprite using 9slice.

    Args:
        (Arguments inside [] are optional)
		
        x: x position
        y: y position
        w: width of the rectangle
        h: height of the rectangle
        sprite: sprite to use
        subimg: sub-image (image_index)
        [color]: color of the sprite, c_white default
        [scale]: scale of the sprite, 1 default.
                 scale doesn't affect the rectangle,
                 just the sprite.

The sprite must be a square 3x3 grid of any size. Look to s9Slice (sprite) for reference.

-----------------------------------------------------------------

STRETCHING/TILING

There are two ways of 9slicing: stretching and tiling.

The corners remain intact, but the edges and center part
must be distorted to fit the rectangle.

So, they must either be stretched to fit the area,
or tiled repeatedly to cover it.

By default, the script is on tile mode. If you want to
turn on stretching, open the "slice_init" script
(inside the Internal folder) and set the "global.stretch9"
variable to true.


*/
