// MIT License

// Copyright (c) 2023 João Chrisóstomo

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

//!PARAM radius
//!DESC Clipping Radius
//!TYPE int
//!MINIMUM 1
//!MAXIMUM 7
2

//!HOOK POSTKERNEL
//!BIND POSTKERNEL
//!BIND PREKERNEL
//!DESC Pixel Clipper (Anti-Ringing)
//!WHEN POSTKERNEL.w PREKERNEL.w / 1.000 > POSTKERNEL.h PREKERNEL.h / 1.000 > *
vec4 hook() {
    //Sample 5x5 low-res pixel cluster around high-res pixel
    vec4 min_pix = PREKERNEL_texOff(0);
    vec4 max_pix = min_pix;
    vec4 cur_pix;
    for (int y = -radius; y <= radius; y++) {
        for (int x = -radius; x <= radius; x++) {
            if (abs(x*y) <= radius) {
                cur_pix = PREKERNEL_texOff(vec2(y, x));
                min_pix = min(min_pix, cur_pix);
                max_pix = max(max_pix, cur_pix);
            }
        }
    }

    //Sample current high-res pixel
    vec4 hr_pix = POSTKERNEL_texOff(0);
    
    // Clamp the intensity so it doesn't ring
    hr_pix = clamp(hr_pix, min_pix, max_pix);
    return hr_pix;
}
