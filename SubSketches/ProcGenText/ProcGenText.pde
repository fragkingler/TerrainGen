PGraphics buffer;
PGraphics buffer2;

// Credit to "PurePixel" and "MadPixel" for creating the font
PFont font;

int frame = 6560; // Frame for nice looking output
int textX, textY;

void setup() {
  hint(ENABLE_KEY_REPEAT); // Enable a key that's held pressed will count as multiple key-presses
  // Setup-variables and text-settings
  size(800, 800, P2D);
  buffer = createGraphics(width, height, P2D);
  buffer2 = createGraphics(width, height, P2D);
  font = createFont("Minecrafter.Reg.ttf", 32); // Load font
}

void draw() {
  background(255);
  
  // Call drawbuffer functions with position of text. Default is 0 and will be positioned in center because of translation in the drawbuffer-function
  drawBuffer(textX, textY);

  int cells = 50; // Amount of cells that will be "buffered"
  int spacing = width / cells; // Calculate spacing based on width of canvas and amount of cells

  buffer2.beginDraw();
  buffer2.clear(); // Clear previously drawn frame from the graphics-instance
  buffer2.noFill();
  //buffer2.stroke(255);
  buffer2.noStroke();
  //Iterate through every cell and copy the pixels
  for (int y = 0; y < cells; y++) { 
    for (int x = 0; x < cells; x++) {
      int wave = floor(sin(radians(frame + x/2*y/2)) * 1000/cells);

      int sx = x * spacing + wave;
      int sy = y * spacing;
      int sw = spacing;
      int sh = spacing;

      int dx = x * spacing;
      int dy = y * spacing;
      int dw = spacing;
      int dh = spacing;

      buffer2.copy(buffer, sx, sy, sw, sh, dx, dy, dw, dh);
      buffer2.rect(x * spacing, y * spacing, spacing, spacing);
    }
  }
  buffer2.endDraw();

  // Draw actual image
  image(buffer2, 0, 0);
}


void drawBuffer(int textX, int textY) {
  buffer.beginDraw();
  buffer.clear(); // Clear previously drawn frame from the graphics-instance
  buffer.translate(width/2, height/2); // Get mid of canvas
  buffer.noStroke();
  buffer.fill(0);
  buffer.textFont(font);
  buffer.textSize(height/24);
  buffer.textAlign(CENTER, CENTER); 
  buffer.text("Procedural Generation", textX, textY); // Text that will be modified
  buffer.endDraw();
}

void keyPressed() {
  if (key == ' ') {
    frame++; // Increase frame to be drawn
    //println(frame);
  }
}

void keyReleased() {
  if (key == 's') {
    buffer2.save("procGenText.png"); // Save current state of Graphics-instance as transparent png
  }
}
