class Blob extends Polygon {
  Vec2 grav = new Vec2(0, 0.01);

  ArrayList<Particle> particles;
  float area;

  public Blob(int vertices) {
    super();
    this.particles = new ArrayList<Particle>();
    Vec2 center = new Vec2(width / 2, height / 2);
    for (int i = 0; i < vertices; i ++) {
      this.add(new Particle(Vec2.fromAngle((float)i / vertices * TWO_PI).mult(200).add(center)));
    }
    this.area = this.signedArea();
  }

  void update() {
    for (Particle p : particles) p.addForce(grav);
    for (Particle p : particles) p.update();
    float expAm = getExpansion(area);
    println(expAm);
    for (int i = 0; i < particles.size(); i ++) {
      particles.get(i).addForce(vertexNormals[i].times(expAm).dividedBy(10));
    }
    reset();
  }

  void add(int index, Particle p) {
    particles.add(index, p);
    vertices.add(index, p);
  }

  void add(Particle p) {
    particles.add(p);
    vertices.add(p);
  }

  void remove(int index) {
    particles.remove(index);
    vertices.remove(index);
  }

  void render() {
    fill(255);
    noStroke();
    beginShape();
    for (Vec2 vec : vertices) vertex(vec.x, vec.y);
    endShape();
    for (Particle p : particles) p.render();
  }
}
