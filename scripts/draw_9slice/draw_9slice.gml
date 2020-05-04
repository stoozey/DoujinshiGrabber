/// @description  draw_9slice(x, y, w, h, sprite, subimg, [color, scale]);
/// @function  draw_9slice
/// @param x
/// @param  y
/// @param  w
/// @param  h
/// @param  sprite
/// @param  subimg
/// @param  [color
/// @param  scale]

//Args
var _x = argument[0];
var _y = argument[1];
var _w = argument[2];
var _h = argument[3];
var _sprite = argument[4];
var _subimg = argument[5];

//Color
var _color = c_white;
if (argument_count > 6) _color = argument[6];

//Scale
var _scale = 1;
if (argument_count > 7) _scale = argument[7];

//Scale if smaller
var spriteWidth = sprite_get_width(_sprite);
var smallerSize = min(_w, _h);
if (smallerSize < spriteWidth){
    _scale *= smallerSize/spriteWidth;
}

//Data
var cellSprSize = spriteWidth/3;
var cellSize = cellSprSize * _scale;

var edgeW = _w - cellSize*2;
var edgeH = _h - cellSize*2;

var edgeScaleW = edgeW/cellSize;
var edgeScaleH = edgeH/cellSize;

//Vars
var _stretch = global.stretch9;

//Draw
//Center
    //Stretched
    if (_stretch){
        draw_sprite_part_ext(_sprite, _subimg, cellSprSize, cellSprSize, cellSprSize, cellSprSize, _x + cellSize, _y + cellSize, edgeScaleW*_scale, edgeScaleH*_scale, _color, 1);
    }
    //Tiled
    else{
        for(var h=0; h<edgeH; h+=cellSize){
            for(var w=0; w<edgeW; w+=cellSize){
                var cX = _x + cellSize + w;
                var cY = _y + cellSize + h;
                
                var distW = max(0, (w+cellSize) - edgeW)/_scale;
                var distH = max(0, (h+cellSize) - edgeH)/_scale;
            
                draw_sprite_part_ext(_sprite, _subimg, cellSprSize, cellSprSize, cellSprSize - distW, cellSprSize - distH, cX, cY, _scale, _scale, _color, 1);
            }
        }
    }
    
//Edges
    //Stretched
    if (_stretch){
        //Top
        draw_sprite_part_ext(_sprite, _subimg, cellSprSize, 0, cellSprSize, cellSprSize, _x + cellSize, _y, edgeScaleW*_scale, _scale, _color, 1);
        
        //Bottom
        draw_sprite_part_ext(_sprite, _subimg, cellSprSize, cellSprSize*2, cellSprSize, cellSprSize, _x + cellSize, (_y + _h) - cellSize, edgeScaleW*_scale, _scale, _color, 1);
        
        //Left
        draw_sprite_part_ext(_sprite, _subimg, 0, cellSprSize, cellSprSize, cellSprSize, _x, _y + cellSize, _scale, edgeScaleH*_scale, _color, 1);
        
        //Right
        draw_sprite_part_ext(_sprite, _subimg, cellSprSize*2, cellSprSize, cellSprSize, cellSprSize, (_x + _w) - cellSize, _y + cellSize, _scale, edgeScaleH*_scale, _color, 1);
    }
    //Tiled
    else{
        //Top
        for(var i=0; i<edgeW; i+=cellSize){
            var cX = _x + cellSize + i;
            
            var dist = max(0, (i+cellSize) - edgeW)/_scale;
            
            draw_sprite_part_ext(_sprite, _subimg, cellSprSize, 0, cellSprSize - (dist), cellSprSize, cX, _y, _scale, _scale, _color, 1);
        }
        
        //Bottom
        for(var i=0; i<edgeW; i+=cellSize){
            var cX = _x + cellSize + i;
            
            var dist = max(0, (i+cellSize) - edgeW)/_scale;
            
            draw_sprite_part_ext(_sprite, _subimg, cellSprSize, cellSprSize*2, cellSprSize - (dist), cellSprSize, cX, (_y + _h) - cellSize, _scale, _scale, _color, 1);
        }
        
        //Left
        for(var i=0; i<edgeH; i+=cellSize){
            var cY = _y + cellSize + i;
            
            var dist = max(0, (i+cellSize) - edgeH)/_scale;
            
            draw_sprite_part_ext(_sprite, _subimg, 0, cellSprSize, cellSprSize, cellSprSize - (dist), _x, cY, _scale, _scale, _color, 1);
        }
        
        //Right
        for(var i=0; i<edgeH; i+=cellSize){
            var cY = _y + cellSize + i;
            
            var dist = max(0, (i+cellSize) - edgeH)/_scale;
            
            draw_sprite_part_ext(_sprite, _subimg, cellSprSize*2, cellSprSize, cellSprSize, cellSprSize - (dist), (_x + _w) - cellSize, cY, _scale, _scale, _color, 1);
        }
    }

//Corners
    //Top left
    draw_sprite_part_ext(_sprite, _subimg, 0, 0, cellSprSize, cellSprSize, _x, _y, _scale, _scale, _color, 1);
    
    //Top Right
    draw_sprite_part_ext(_sprite, _subimg, cellSprSize*2, 0, cellSprSize, cellSprSize, (_x + _w) - cellSize, _y, _scale, _scale, _color, 1);
    
    //Bottom left
    draw_sprite_part_ext(_sprite, _subimg, 0, cellSprSize*2, cellSprSize, cellSprSize, _x, (_y + _h) - cellSize, _scale, _scale, _color, 1);
    
    //Bottom Right
    draw_sprite_part_ext(_sprite, _subimg, cellSprSize*2, cellSprSize*2, cellSprSize, cellSprSize, (_x + _w) - cellSize, (_y + _h) - cellSize, _scale, _scale, _color, 1);
