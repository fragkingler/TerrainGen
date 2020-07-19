class Block {
  float x, y, z, size;

  color stone = color(100, 90, 110);
  color dirt = color(120, 70, 20);
  color grass = color(60, 180, 40);
  color activeColor;

  boolean colorSet = false;

  // Constructor 
  Block(float x, float y, float z, float size) {
    this.x=x;
    this.y=-y;
    this.z=z;
    this.size=size;
  }

  void displayBox() {
    pushMatrix();
    noStroke();
    if (colorSet == false) { // Choose color of the block if no color has yet been set
      if (-y/blockSize<(colsY-2+random(-1.5, 1.3))) {
        activeColor = stone; // Basement is stone
      } else {
        if (random(0, 1) <=0.5) { // Else it's randomly grass or dirt
          activeColor = dirt;
        } else {
          activeColor = grass;
        }
      }
      colorSet = true;
    }
    fill(activeColor);
    translate(x, y, z);
    box(size);
    popMatrix();
  }
}
