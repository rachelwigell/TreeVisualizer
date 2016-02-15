public class Deciduous1 {
  Deciduous1 root;
  Line path;
  int numBranches;
  Deciduous1[] branches;
  int level;
  int endLevel;
  
  public Deciduous1(Vector3D position, int numBranches, int endLevel){
    float yDist = random(100, 130);
    float xAngle = random(-20, 20);
    float zAngle = random(-20, 20);
    Vector3D endPos = new Vector3D(position.x+xAngle, position.y-yDist, position.z+zAngle);
    this.path = new Line(position, endPos,  new Polygon(5, yDist/20.0), new Polygon(5, yDist/70.0));
    this.numBranches = numBranches;
    this.endLevel = endLevel;
    this.level = 1;
    this.branches = new Deciduous1[numBranches];
    for(int i = 0; i < numBranches-1; i++){
      branches[i] = new Deciduous1(this, false);
    }
    branches[numBranches-1] = new Deciduous1(this, true);
  }
  
  public Deciduous1(Deciduous1 root, boolean last){
    this.level = root.level+1;
    this.numBranches = root.numBranches-1;
    this.endLevel = root.endLevel;
    Vector3D branchStart;
    float yNorm;
    float branchLength;
    // put the last branch at the top, it looks less awkward.
    if(!last){
      float branchYRand = random(0, .5+.1*this.level);
      float branchY = root.path.end.y - branchYRand*(root.path.end.y-root.path.start.y);
      branchStart = root.path.getPointWithThisY(branchY);
      branchLength = (.5+branchYRand)*random(1, 1.3)*root.path.length/(this.level);
      yNorm = .1;
      float up = random(-.8, .1);
      if(up < 0){
        yNorm = random(-.5, -.2); 
      }
    }
    else{
      yNorm = -.9;
      branchStart = new Vector3D(root.path.end.x, root.path.end.y+1, root.path.end.z);
      branchLength = random(.4, .6)*root.path.length/(this.level);
    }
    float xNorm = random(-1, 1);
    float zNorm = random(-1, 1);
    Vector3D branchEnd = branchStart.addVector(new Vector3D(xNorm, yNorm, zNorm).multiplyScalar(branchLength));
    this.path = new Line(branchStart, branchEnd, new Polygon(5, branchLength/20.0), new Polygon(5, branchLength/70.0));
    if(this.level < this.endLevel){
      this.branches = new Deciduous1[numBranches];
      for(int i = 0; i < numBranches; i++){
        branches[i] = new Deciduous1(this, false);
      }
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
      for(Deciduous1 b: this.branches){
        b.drawBranch(style);
      }
    }
  }
}