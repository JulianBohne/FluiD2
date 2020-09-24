class Blob extends Polygon {
  Vec2 grav = new Vec2(0, 0.05);

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
    reset();
    setArea(area);
    /*float expAm = getExpansion(area);
    for (int i = 0; i < particles.size(); i ++) {
      particles.get(i).addForce(vertexNormals[i].times(expAm));
    }*/
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
    stroke(0, 255, 0);
    strokeWeight(3);
    for(int i = 0; i < vertices.size(); i ++){
      Vec2 a = vertices.get(i);
      Vec2 vNorm = a.plus(vertexNormals[i].times(20));
      Vec2 halfB = a.plus(vertices.get((i + 1)%vertices.size())).dividedBy(2);
      Vec2 eNorm = halfB.plus(edgeNormals[i].times(20));
      line(a.x, a.y, vNorm.x, vNorm.y);
      line(halfB.x, halfB.y, eNorm.x, eNorm.y);
    }
  }
}
