# Godot ATL

> Experimental code alert.

A simple Visual Editor for Ren'Py ATL system using Godot Engine 3.
If you don't know Godot Engine: it's a free and open-source multi-platform game engine -> https://godotengine.org/


Since Ren'Py doesn't have a built-in visual editor (only an [image location picker](https://lemmasoft.renai.us/forums/viewtopic.php?f=51&t=46229&p=467929#p467929)), it's a bit difficult to position images sometimes.

So, this project was created to facilitate some things related to image placement in Ren'Py development.


# What is ATL?

ATL is the built-in Animation and Transformation Language in Ren'Py Engine. It's used for image positioning, resizing, rotation etc.

It's a high-level API, so it's easy to use. See the ATL docs here: https://www.renpy.org/doc/html/atl.html

As I said above, there is no built-in visual editor, so you need some workaround to get values more easily to use in ATL.


# How to Use

First of all, this project was meant to be used only in the Godot editor, so you don't need to download export templates but you need to know how Godot editor works (no code is needed, just the editor workflow).

When opening the project, the main scene will be a simple sample. Run the scene and it will generate some ATL code to use in Ren'Py.

>TODO: More 'How to use' info

# API compatibility

The Displayable node wraps some Sprite properties to be compatible with ATL properties.

## Sprite/ATL compatibility list:

| Godot Sprite     | ATL                   |
|------------------|-----------------------|
| position         | pos                   |
| rotation_degrees | rotate                |
| scale            | zoom, xzoom and yzoom |
| modulate.a       | alpha                 |
| region_rect      | crop                  |

## Custom properties

Some custom properties are exposed in the inspector.

* Factor position - You can set the sprite position using a factor value, the same as passing a float in ATL code.
* Factor anchor - Same as above but for sprite anchor.
* Pos mode - Toggle between Factor and Pixel positioning (for code generation only).
* Name - Optional name to be used in code generation.
* Mode - Code generation mode: IMAGE (`image name:`), SHOW (`show name:`), TRANSFORM (`transform name:`), ATL_ONLY (ATL properties only).
* Print ATL - Generates ATL code and prints it in the debugger console.
