public class Branch {
  Branch root;
  Line path;
  int numBranches;
  Branch[] branches;
  int level;
  int endLevel;
  int faces;
  
  public Branch(Line path, int numBranches, int endLevel, int faces){
    this.path = path;
    this.numBranches = numBranches;
    this.endLevel = endLevel;
    this.level = 1;
    this.faces = faces;
    this.branches = new Branch[numBranches];
    for(int i = 0; i < numBranches; i++){
      branches[i] = new Branch(this);
    }
  }
  
  public Branch(Branch root){
    this.level = root.level+1;
    this.numBranches = root.numBranches;
    this.endLevel = root.endLevel;
    this.faces = root.faces;
    float branchY = root.path.end.y - 2*random((root.path.end.y-(root.path.start.y)))/3;
    Vector3D branchStart = root.path.getPointWithThisY(branchY);
    float branchLength = .7*root.path.length-.4*root.path.start.distance(branchStart)+random(-.1*root.path.length, .1*root.path.length);
    float yNorm = random(-.8, .3);
    float xNorm = random(yNorm*yNorm-1, yNorm*yNorm+1);
    float pos = random(-1, 1);
    float zNorm;
    if(pos > 0) zNorm = 1 - xNorm*xNorm - yNorm*yNorm;
    else zNorm = xNorm*xNorm + yNorm*yNorm - 1;
    Vector3D branchEnd = branchStart.addVector(new Vector3D(xNorm, yNorm, zNorm).multiplyScalar(branchLength));
    float percent = (branchY-root.path.start.y)/(root.path.end.y-root.path.start.y);
    float baseRad = random(percent*root.path.startFace.radius);
    float topRad = random(baseRad);
    this.path = new Line(branchStart, branchEnd, new Polygon(this.faces, branchStart, baseRad), new Polygon(this.faces, branchEnd, baseRad));
    if(this.level < this.endLevel){
      this.branches = new Branch[numBranches];
      for(int i = 0; i < numBranches; i++){
        branches[i] = new Branch(this);
      }
    }
  }
  
  public void drawBranch(PApplet visual, boolean solid){
    if(solid){
      noStroke();
      fill(255);
      this.path.drawSolid(visual);
    }
    else{
      noFill();
      stroke(255);
      this.path.drawLine(visual);
    }
    if(this.level < this.endLevel){
      for(Branch b: this.branches){
        b.drawBranch(visual, solid);
      }
    }
  }
  
  public void printInfo(){
    println("Branch level: " + this.level);
    println("num branches: " + this.numBranches + " endLevel: " + this.endLevel);
    if(this.level < this.endLevel){
      println("starting children:");
      for(Branch b: this.branches){
        b.printInfo();
      }
    }
    else{
      println("this is a leaf node");
    }
  }
}

