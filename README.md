# GLSL Pixel Clipper

## Overview
This is a simple pixel clipper for mpv. You can use alongside resampling filters to limit the amount of ringing after resampling. It's designed to dering filters that only ring once (filters without positive lobes outside the centre).

## Instructions
Add something like this to your mpv config:
```
profile=gpu-hq
scale=sinc
scale-radius=2
glsl-shader="path/to/shader/pixel-clipper.glsl"
```
The examples uses "sinc2" because it's the sharpest option, but feel free to change this into a different filter if you prefer a softer result.