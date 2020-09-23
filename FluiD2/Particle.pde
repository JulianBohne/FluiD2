class Particle extends Vec2{
  Vec2 vel, acc;
  
  public Particle(float x, float y){
    super(x, y);
    this.vel = new Vec2(0, 0);
    this.acc = new Vec2(0, 0);
  }
  public Particle(Vec2 pos){
    super(pos);
    this.vel = new Vec2(0, 0);
    this.acc = new Vec2(0, 0);
  }
  
  public void addForce(Vec2 force){
    acc.add(force);
  }
  
  public void update(){
    vel.add(acc);
    this.add(vel);
    if(x < 0){
      x = 0;
      vel.x *= -0.5;
    }else if (x > width){
      x = width;
      vel.x *= -0.5;
    }
    if(y < 0){
      y = 0;
      vel.y *= -0.5;
    }else if(y > height){
      y = height;
      vel.y *= -0.5;
    }
    acc.set(0,0);
  }
  
  public void render(){
    strokeWeight(5);
    stroke(0);
    point(x, y);
  }
}
