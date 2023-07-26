# GLSL Pixel Clipper

## Overview
This is a simple pixel clipper for mpv. You can use it alongside resampling filters to limit the amount of ringing after resampling.

The main difference between this and the built-in anti-ringing functionality is that this shader works with polar filters.

## Instructions
Add something like this to your mpv config:
```c
profile=gpu-hq
scale=ewa_lanczos
glsl-shader="path/to/shader/PixelClipper.glsl"
```
The example above uses "sinc2" because it's the sharpest option, but feel free to change this into a different filter if you prefer a softer result.

## Inputs
You can set the following parameters:
- `strength`: Controls the strength of the clipping. Accepts floats between `[0.0, 1.0]`, defaults to `1.0` (100% strength).

On `vo=gpu-next`, you can set these settings with `--glsl-shader-opts=param1=value1`.

## Example
![Pixel Clipper Example](./example.png "Pixel Clipper Example")
