ArrayList<Vec2> points = new ArrayList<Vec2>();
Blob b;

void setup(){
  frameRate(30);
  size(800, 600);
  b = new Blob(100);
  /*
  float area = b.signedArea();
  println(area);
  b.setArea(150);
  println(b.signedArea());
  b.setArea(150);
  println(b.signedArea());
  b.setArea(area);
  println(b.signedArea());*/
}
void draw(){
  background(125);
  b.update();
  b.render();
}
