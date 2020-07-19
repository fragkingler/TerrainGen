Noise noise;

int colsX = 10;
int colsZ = 10;
int colsY = 10;
color b1, b2;
float lightX = 500, lightY = 1250, lightZ=1300;
float rX = 0;
float rY = 0; 
float rZ = 0;
int blockSize = 40;
int xMod, yMod = -50, zMod = -200;
float noiseScale = 0.02;
float noiseIncrement = 0.002;
float noiseZIncrement = 0.0; // animation rate of noise. 0 = no animation

boolean mouseRotate = false;

ArrayList<Block> blocks;



void setup() {
  hint(ENABLE_KEY_REPEAT); // Holding key counts as multiple key presses
  blocks = new ArrayList<Block>();
  noise = new Noise(noiseIncrement, noiseZIncrement); // New noise generator that creates animated noise. Not used for this terrain since this was already an experiment regarding the next (and final) sketch
  size(1000, 800, P3D);
  b1 = color(30, 151, 235);
  b2 = color(125, 214, 251);
  calcBoxes();
}

void draw() {
  lights(); // Enable 3D-lightning
  setGradient(0, 0, -4000, width, height, b1, b2); // draw gradient Background
  //noise.drawNoise(); // draw noise with animation
  // Translations for block-drawing
  translate(width/1.5, height/1.4, 0);
  translate(xMod-colsY*blockSize/2, yMod+colsX*blockSize/4, zMod+colsZ*blockSize/4);
  rotateX(rX);
  rotateY(rY);
  rotateZ(rZ);
  if (mouseRotate) { // Rotation via mouse_movement
    rotateY(map(mouseX, 0, width, -PI, PI));
    rotateX(map(mouseY, 0, height, -HALF_PI, HALF_PI));
    rotateZ(map(mouseY, 0, height, -HALF_PI, HALF_PI));
  }
  translate(xMod-colsY*blockSize/2, yMod+colsX*blockSize/4, zMod+-colsZ*blockSize/2);
  directionalLight(126, 126, 126, lightX, lightY, lightZ);
  for (Block blocks : blocks) { // Iterate through all blocks
    blocks.displayBox(); // Display them individually
  }
}

void mouseReleased() {
  calcBoxes();
}

// Calculate current block position and add a new block for each "cell"
void calcBoxes() {
  blocks.clear();
  for (int i = 0; i < colsX; i++) {
    for (int j = 0; j < colsZ; j++) {
      for (int k = 0; k < colsY+ floor(random(-1.3, 2.3)); k++) {
        blocks.add(new Block(i*blockSize, k*blockSize, j*blockSize, blockSize));
      }
      blocks.add(new Block(i*blockSize, 0, j*blockSize, blockSize));
    }
    blocks.add(new Block(i*blockSize, 0, 0, blockSize));
  }
}

void keyPressed() {
  if (key == 'd') { // Rotate Axis via keypresses
    rX += 0.01;
  } else if (key == 'a') {
    rX -= 0.01;
  } else if (key == 'w') {
    rY += 0.01;
  } else if (key == 's') {
    rY -= 0.01;
  } else if (key == 'e') {
    rZ += 0.01;
  } else if (key == 'q') {
    rZ -= 0.01;
  } else if (key == ' ') { // Pre-saved rotation to see the top-face of the cube
    rX = QUARTER_PI;
    rY = -QUARTER_PI+(-QUARTER_PI/1.2); 
    rZ = HALF_PI*1.2;
    xMod = -200;
  } else if (key == 'm') { // Enable/Disable rotation via mouse_movement
    mouseRotate = !mouseRotate;
  } else if (keyCode == ENTER) { // Reset rotations
    rX = 0;
    rY = 0;
    rZ = 0;
  } else if ( keyCode == BACKSPACE) { // Reset position-offsets
    xMod = 0; 
    yMod = -50; 
    zMod = -200;
  } else if (key== CODED) { // Position-offset of the cube via keyboard-Arrows
    if (keyCode == UP) {
      xMod -= 1;
    } else if (keyCode == DOWN) 
    {
      xMod += 1;
    } else if (keyCode == LEFT) 
    {
      zMod += 1;
    } else if (keyCode == RIGHT) 
    {
      zMod -= 1;
    }
  }
}

// Draw gradient background via color-stroked lines
void setGradient(int x, int y, int z, float w, float h, color c1, color c2) {
  pushMatrix();
  translate(-3000, -3000, 000);
  noFill();
  for (int i = y; i <= y+h*10; i++) {
    float inter = map(i, y, y+h*10, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(x, i, z, x+w*10, i, z);
  }
  popMatrix();
}
