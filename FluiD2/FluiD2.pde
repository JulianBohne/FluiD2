ArrayList<Vec2> points = new ArrayList<Vec2>();
Polygon poly;

void setup(){
  size(10, 10);
  int vertices = 100;
  for(int i = 0; i < vertices; i ++){
    Vec2 vec= Vec2.fromAngle((float)i/vertices*TWO_PI);
    vec.x *= 2;
    vec.mult(10);
    points.add(vec);
  }
  poly = new Polygon(points);
  println(poly.signedArea());
  poly.setArea(670);
  println(poly.signedArea());
}
void draw(){
  
}
