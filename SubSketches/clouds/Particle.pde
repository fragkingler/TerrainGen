class Particle
{
  PVector position;
  float oppacity;
  float w;
  color clr;
  boolean alive;

  // Constructor
  Particle(float x, float y, float wth, color c, float o)
  {
    position = new PVector(x, y);
    w = wth;
    clr = c;
    oppacity = o;
    alive = true;
  }

  // Reproduce particle/cloud for realistic cloud-look / Actual cloud-particle positioning with random spreading around clicked-position
  void reproduce()
  {
    if (w > 1)
    {
      for (int i = 0; i < 2; i++)
      {
        float newX = position.x + random(-w, w);
        float newY = position.y + random(-w/2, w/4);
        float r = random(10); // Randomate width of cloud
        float newW = w - r;
        if (newW < 1) // Make sure cloud is never smaller than 1
          newW = 1;
        particles.add(new Particle(newX, newY, newW, clr, oppacity)); // Add new particle of this cloud that has just been calculated
        alive = false; // This particle has been drawn and reproduced itself, deactivate further reproduction
      }
    }
  }

  // Draw the actual particles
  void drawParticle()
  {
    fill(clr, oppacity);
    ellipse(position.x, position.y, w, w);
  }
}
