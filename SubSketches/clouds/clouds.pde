
ArrayList particles;
PImage sky;

void setup()
{
  size(800, 600, P2D);
  frameRate(60);
  rectMode(CENTER);
  noStroke();

  sky = createImage(width, height, RGB);

  // Calculate background fade
  for (int i = 0; i < width; i++)
  {
    for (int j = 0; j < height; j++)
    {
      sky.pixels[i + j * width] = lerpColor(#157ABD, #66B9F1, (float)j/height);
    }
  }
  restart();
}

// Redraw background and clear Particles
void restart()
{
  particles = new ArrayList();
  background(sky);
}

// Add cloud/Particle on mouse-release
void mouseReleased()
{
  particles.add(new Particle(mouseX, mouseY, 50, color(255), 12)); // Params: positionX, positionY, width of cloud, color, opacity
}

// Reset the canvas on ENTER, else blur everything (smoother clouds)
void keyReleased()
{
  if (key == 32)
    restart();
  else
    filter(BLUR);
}

// Redraw all particles/clouds every frame
void draw()
{
  for (int i = 0; i < particles.size(); i++)
  {
    Particle p = (Particle) particles.get(i);
    if (p.alive) // Is cloud being drawn?
    {
      p.drawParticle();
      p.reproduce();
    } else
      particles.remove(i); // Remove this cloud
  }
}
