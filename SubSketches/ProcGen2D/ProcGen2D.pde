// set text to draw on the grass
//String[] text = {"P", "r", "o", "c", "e", "d", "u", "r", "a", "l", " ", "L", "a", "n", "d", "s", "c", "a", "p", "e", "s"};

// calculators for text-position
//int textLength;
//int startTextAt;

//int getChar; // text-related; was increased with every line of blocks

int blockSize;
int calcedHeight;


color b1, b2;

ArrayList <Blocks> blocksOld;
ArrayList <Block> blocks;


void setup() {
  size(1000, 800);
   blocksOld = new ArrayList<Blocks>();
  blocks = new ArrayList<Block>();
  blockSize = 40;
  b1 = color(30, 151, 235);
  b2 = color(125, 214, 251);
  blocksOld.add(new Blocks(blockSize));
  // draw background
  setGradient(0, 0, width, height, b1, b2);
  for (Blocks block : blocksOld) {
    block.drawBlock();
  }

  //for (int i = 0; i < width; i += blockSize) {
  //  if (i != 0) {
  //    calcedHeight = blocks.get(i/blockSize-1).calcHeight(blocks);
  //  }
  //  blocks.add(new Block(blockSize, i, calcedHeight));
  //  blocks.get(i/blockSize).drawBlock();
  //}


  //textLength = text.length;
  //get amount of blocks for text-calculation
  //startTextAt = width / blockSize;

  // calculate the first block at which the text should start
  //startTextAt = (int)random(0, startTextAt - textLength);




  //if (getChar >= startTextAt && getChar < startTextAt + textLength) {
  //  fill(0);
  //  textSize(64);
  //  textAlign(CENTER);
  //  if (getChar-startTextAt == 18) {
  //    text(text[getChar-startTextAt], getChar*blockSize+blockSize/2, bY-12);
  //  } else {
  //    text(text[getChar-startTextAt], getChar*blockSize+blockSize/2, bY);
  //  }
  //}
}

void setGradient(int x, int y, float w, float h, color c1, color c2) {

  noFill();
  for (int i = y; i <= y+h; i++) {
    float inter = map(i, y, y+h, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(x, i, x+w, i);
  }
}
