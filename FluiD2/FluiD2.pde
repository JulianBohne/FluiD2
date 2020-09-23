ArrayList<Vec2> points = new ArrayList<Vec2>();
Blob b;

void setup(){
  size(800, 600);
  b = new Blob(100);
  
}
void draw(){
  background(125);
  b.update();
  b.render();
}
