class Polygon{
  public ArrayList<Vec2> vertices;
  public Vec2[] vertexNormals, edgeNormals;
  Float factorA, factorB, factorC;
  
  Polygon(){
    this.vertices = new ArrayList<Vec2>();
    this.reset();
  }
  Polygon(Vec2[] points){
    this.vertices = new ArrayList<Vec2>();
    this.addPoints(points);
    this.reset();
  }
  Polygon(ArrayList<Vec2> points){
    this.vertices = new ArrayList<Vec2>();
    this.addPoints(points);
    this.reset();
  }
  void addPoints(Vec2[] points){
    for(Vec2 vertex : points) this.vertices.add(vertex);
  }
  void addPoints(ArrayList<Vec2> points){
    this.vertices.addAll(points);
  }
  void reset(){
    this.vertexNormals = null;
    this.edgeNormals = null;
    this.factorA = null;
    this.factorB = null;
    this.factorC = null;
  }
  
  public float signedArea(){
    float area = 0;
    for(int i = 0; i < vertices.size(); i ++){
      area += vertices.get(i).cross(vertices.get((i+1)%vertices.size()));
    }
    return area/2;
  }
  
  public void expand(float amount){
    if(vertexNormals == null) calculateNormals();
    for(int i = 0; i < vertices.size(); i ++){
      vertices.get(i).add(vertexNormals[i].times(amount));
    }
    reset();
  }
  
  public void calculateNormals(){
    int numOVerts = vertices.size();
    vertexNormals = new Vec2[numOVerts];
    edgeNormals = new Vec2[numOVerts];
    for(int indexA = 0; indexA < numOVerts; indexA ++){
      int indexB = (indexA + 1) % numOVerts;
      int indexC = (indexA + 2) % numOVerts;
      Vec2 ab = vertices.get(indexB).minus(vertices.get(indexA)).normalize();
      Vec2 bc = vertices.get(indexC).minus(vertices.get(indexB)).normalize();
      float xSum = ab.x + bc.x;
      float ySum = ab.y + bc.y;
      if(xSum == 0 && ySum == 0) vertexNormals[indexB] = ab;
      else vertexNormals[indexB] = new Vec2(ySum, -xSum).normalize();
      edgeNormals[indexB] = new Vec2(ab.y, - ab.x);
    }
  }
  
  public void calcFactors(){
    if(vertexNormals == null || edgeNormals == null) calculateNormals();
    factorA = 0f;
    factorB = 0f;
    factorC = 0f;
    int numOVerts = vertices.size();
    for(int indexA = 0; indexA < numOVerts; indexA ++){
      int indexB = (indexA + 1) % numOVerts;
      Vec2 vertexA = vertices.get(indexA);
      Vec2 vertexB = vertices.get(indexB);
      
      ///// Sum A /////
      float vertexNormalAngle = vertexNormals[indexA].angleBetween(vertexNormals[indexB]);
      if(vertexNormals[indexA].cross(vertexNormals[indexB]) < 0) vertexNormalAngle *= -1;
      float a = sin(vertexNormalAngle / 2) * cos(vertexNormalAngle / 2);
      factorA += a;
      
      ///// Sum B /////
      float alpha = HALF_PI - vertexNormals[indexA].angleBetween(edgeNormals[indexB]);
      float beta  = HALF_PI - vertexNormals[indexB].angleBetween(edgeNormals[indexB]);
      if(edgeNormals[indexB].cross(vertexNormals[indexB]) < 0) beta  = PI - beta;
      if(vertexNormals[indexA].cross(edgeNormals[indexB]) < 0) alpha = PI - alpha;
      if(a == 0) factorB += vertexB.minus(vertexA).mag() * cos(vertexNormals[indexB].angleBetween(edgeNormals[indexB]));
      else{
        float sinConstant = vertexB.minus(vertexA).mag() / sin(PI - alpha - beta);
        factorB += (sinConstant * sin(alpha) + sinConstant * sin(beta)) * a;
      }
      ///// Sum C /////
      factorC += vertexA.cross(vertexB)/2;
    }
  }
  
  public float getExpansion(float targetArea){
    if(factorA == null || factorB == null || factorC == null) calcFactors();
    return (sqrt(abs(4 * factorA * (targetArea - factorC) + factorB * factorB)) - factorB) / (2 * factorA);
  }
  
  public void setArea(float targetArea){
    float e = getExpansion(targetArea);
    println(e);
    expand(e);
  }
}
