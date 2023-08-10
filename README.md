# GLSL Pixel Clipper

## Overview
This is a simple pixel clipper for mpv. You can use it alongside resampling filters to limit the amount of ringing after resampling.

~~The main difference between this and the built-in anti-ringing functionality is that this shader works with polar filters.~~ 
[Looks like polar AR is now supported in libplacebo](https://code.videolan.org/videolan/libplacebo/-/merge_requests/505), so this shader shouldn't really be needed anymore unless you don't like the native solution.

Set `TWELVE_TAP_AR 1` if you don't want a "cut-off" impulse response with larger filters. The standard 4-tap shader is marginally better at eliminating ringing though. You can also just remove the downsampling pass if you're 
only interested in upsampling AR.

## Instructions
Add something like this to your mpv config:
```c
glsl-shader="path/to/shader/PixelClipper.glsl"
```

## Inputs
You can set the following parameters:
- `strength`: Controls the strength of the clipping. Accepts floats between `[0.0, 1.0]`, defaults to `1.0` (100% strength).

## Example
![Pixel Clipper Example](./example.png "Pixel Clipper Example")
