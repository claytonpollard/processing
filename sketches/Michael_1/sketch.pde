/*  Julia set derived from MANDELBROT fractal!
https://en.wikipedia.org/wiki/Julia_set (must check out. Super cool theories)
Used equation from the quadratic polynomial section (wikipedia). Check it out!
Julia set for fc, vc = −0.7269 + 0.1889i
Unfortunately could not figure out in time how to do the 3D crosssection of the - 
fractal on 4D/Imaginary Plane.
*/

/* note:
   Remember to use camel case, Michael. Don't forget! :(
*/

int maxIterations = 100000; 
float zoom = 0.002; 

// Custom parameters for equations
// Julia set for fc, vc = −0.7269 + 0.1889i
float cReal = -.7269; 
float cImaginary = 0.1886;

void setup() {
  size(800, 800);
  pixelDensity(1);
}

void draw() {
  loadPixels();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float zx = map(x, 0, width, -zoom, zoom); 
      float zy = map(y, 0, height, -zoom, zoom);

      int iteration = 0;
      while (iteration < maxIterations) {
        float tempZx = zx * zx - zy * zy + cReal;
        float tempZy = 2 * zx * zy + cImaginary;
        zx = tempZx;
        zy = tempZy;

        if (dist(zx, zy, 0, 0) > 16) {
          break;
        }

        iteration++;
      }

      // Apply gradient color mapping with sin and cos variations (IMPORTANT)
      // Self note: Practice this maybe next week
      float bright = map(iteration, 0, maxIterations / 30, 0, 10);
      float sinColor = map(sin(bright * TWO_PI), -2, 1, 3, 255);
      float cosColor = map(cos(bright * TWO_PI), -2, 1, 4, 255);
      
      int pix = x + y * width;
      pixels[pix] = color(sinColor, cosColor, bright * 255);
    }
  }

  updatePixels();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom *= (e > 0) ? 1.1 : 0.9;
}
