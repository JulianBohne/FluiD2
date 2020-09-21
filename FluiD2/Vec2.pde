public static class Vec2{
  public float x, y;
  
  public Vec2(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public void set(float x, float y){
    this.x = x;
    this.y = y;
  }
  public void set(Vec2 vec){
    this.x = vec.x;
    this.y = vec.y;
  }
  
  public Vec2 copy(){
    return new Vec2(this.x, this.y);
  }
  
  public static Vec2 add(Vec2 a, Vec2 b){
    return new Vec2(a.x + b.x, a.y + b.y);
  }
  public Vec2 add(Vec2 other){
    this.x += other.x;
    this.y += other.y;
    return this;
  }
  public Vec2 plus(Vec2 other){
    return new Vec2(this.x + other.x, this.y + other.y);
  }
  public static Vec2 sub(Vec2 a, Vec2 b){
    return new Vec2(a.x - b.x, a.y - b.y);
  }
  public Vec2 sub(Vec2 other){
    this.x -= other.x;
    this.y -= other.y;
    return this;
  }
  public Vec2 minus(Vec2 other){
    return new Vec2(this.x - other.x, this.y - other.y);
  }
  public static Vec2 mult(Vec2 vec, float multiplier){
    return new Vec2(vec.x * multiplier, vec.y * multiplier);
  }
  public Vec2 mult(float multiplier){
    this.x *= multiplier;
    this.y *= multiplier;
    return this;
  }
  public Vec2 times(float multiplier){
    return new Vec2(this.x * multiplier, this.y * multiplier);
  }
  public static Vec2 div(Vec2 vec, float divisor){
    return new Vec2(vec.x / divisor, vec.y / divisor);
  }
  public Vec2 div(float divisor){
    this.x /= divisor;
    this.y /= divisor;
    return this;
  }
  public Vec2 dividedBy(float divisor){
    return new Vec2(this.x / divisor, this.y / divisor);
  }
  public static float dot(Vec2 a, Vec2 b){
    return a.x * b.x + a.y * b.y;
  }
  public float dot(Vec2 other){
    return this.x * other.x + this.y * other.y;
  }
  public static float cross(Vec2 a, Vec2 b){
    return a.x * b.y - a.y * b.x;
  }
  public float cross(Vec2 other){
    return this.x * other.y - this.y * other.x;
  }
  public float sqrMag(){
    return x * x + y * y;
  }
  public float mag(){
    return sqrt(sqrMag());
  }
  public Vec2 normalize(){
    this.div(this.mag());
    return this;
  }
  public Vec2 normalized(){
    return this.copy().normalize();
  }
  public Vec2 setMag(float magnitude){
    this.normalize();
    this.mult(magnitude);
    return this;
  }
}
