public class Deciduous3 {
  Deciduous3[] roots;
  int numRoots;
  int rootLevel;
  Line path;
  int numBranches;
  Deciduous3[] branches;
  int level;
  int endLevel;
  
  public Deciduous3(Vector3D position, int numRoots, int numBranches, int endLevel){
    this.roots = new Deciduous3[numRoots];
    this.numRoots = numRoots;
    this.numBranches = numBranches;
    this.endLevel = endLevel;
    this.roots[0] = new Deciduous3(position, numRoots, numBranches, endLevel, 0, 0);
    for(int i = 1; i < numRoots; i++){
        this.roots[i] = new Deciduous3(this.roots[i-1].path.end, numRoots, numBranches, endLevel, i, this.roots[i-1].path.endFace.radius);
    }
  }
  
  public Deciduous3(Vector3D position, int numRoots, int numBranches, int endLevel, int rootLevel, float radius){
    float yDist = random(150/(numRoots*sqrt(rootLevel+1)), 200/(numRoots*sqrt(rootLevel+1)));
    float xAngle = random(-50/numRoots, 50/numRoots);
    float zAngle = random(-50/numRoots, 50/numRoots);
    position = new Vector3D(position.x, position.y+1, position.z);
    Vector3D endPos = new Vector3D(position.x+xAngle, position.y-yDist, position.z+zAngle);
    if(radius == 0){
      this.path = new Line(position, endPos,  new Polygon(5, yDist/10.0), new Polygon(5, yDist/15.0));
    }
    else{
      this.path = new Line(position, endPos,  new Polygon(5, radius), new Polygon(5, .6*radius));
    }
    this.numBranches = numBranches+rootLevel;
    this.endLevel = endLevel;
    this.level = 1;
    this.rootLevel = rootLevel;
    this.numRoots = numRoots;
    this.branches = new Deciduous3[numBranches];
    for(int j = 0; j < numBranches; j++){
      branches[j] = new Deciduous3(this);
    }
  }
  
  public Deciduous3(Deciduous3 root){
    this.numRoots = root.numRoots;
    this.level = root.level+1;
    this.numBranches = root.numBranches-1;
    this.endLevel = root.endLevel;
    this.roots = new Deciduous3[this.numRoots];
    this.roots[0] = new Deciduous3(root, true, null, 0, true);
    for(int i = 1; i < this.numRoots; i++){
      this.roots[i] = new Deciduous3(root, false, this.roots[i-1].path, i, true);
    }
  }
  
  public Deciduous3(Deciduous3 root, boolean first, Line prevPath, int rootLevel, boolean differentiate){
    this.rootLevel = rootLevel;
    this.numRoots = root.numRoots;
    this.level = root.level+1;
    this.numBranches = root.numBranches-1;
    this.endLevel = root.endLevel;
    Vector3D branchStart;
    float branchYRand = random(0, .5+.07*this.level*this.rootLevel);
    if(first){
      float branchY = root.path.end.y - branchYRand*(root.path.end.y-root.path.start.y);
      branchStart = root.path.getPointWithThisY(branchY);
    }
    else{
      branchStart = new Vector3D(prevPath.end);
    }
    float branchLength = (.5+branchYRand)*random(1, 1.3)*root.path.length/(this.level);
    float yNorm = random(-.5, .1); 
    Vector3D branchEnd;
    if(prevPath != null){
      Vector3D rootDir = prevPath.end.addVector(prevPath.start.multiplyScalar(-1)).normalize();
      rootDir.y += yNorm;
      rootDir.x += random(-.2, .2);
      rootDir.z += random(-.2, .2);
      branchEnd = branchStart.addVector(rootDir.multiplyScalar(branchLength));
      this.path = new Line(branchStart, branchEnd, new Polygon(5, prevPath.endFace.radius), new Polygon(5, .6*prevPath.endFace.radius));
    }
    else{
      branchEnd = branchStart.addVector(new Vector3D(random(-1, 1), yNorm, random(-1, 1)).multiplyScalar(branchLength));
      this.path = new Line(branchStart, branchEnd, new Polygon(5, branchLength/10.0), new Polygon(5, branchLength/15.0));
    }
    if(this.level < this.endLevel){
      this.branches = new Deciduous3[numBranches];
      for(int i = 0; i < numBranches; i++){
        branches[i] = new Deciduous3(this);
      }
    }
  }
  
  public void drawRoot(String style){
    for(Deciduous3 d: this.roots){
      d.drawBranch(style);
    }
  }
  
  public void drawBranch(String style){
    if(style == "boxes"){
      this.path.drawBox();
    }
    else if(style == "lines"){
      this.path.drawLine();
    }
    else if(style == "solid"){
      this.path.drawSolid();
    }
    if(this.level < this.endLevel){
      for(Deciduous3 b: this.branches){
        b.drawRoot(style);
      }
    }
  }
}