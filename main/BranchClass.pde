public class Branch {
  Branch root;
  Line path;
  int numBranches;
  Branch[] branches;
  int level;
  int endLevel;
  
  public Branch(Line path, int numBranches, int endLevel){
    this.path = path;
    this.numBranches = numBranches;
    this.endLevel = endLevel;
    this.level = 1;
    this.branches = new Branch[numBranches];
    for(int i = 0; i < numBranches; i++){
      branches[i] = new Branch(this);
    }
  }
  
  public Branch(Branch root){
    this.level = root.level+1;
    this.numBranches = root.numBranches;
    this.endLevel = root.endLevel;
    float branchY = root.path.end.y - 2*random((root.path.end.y-(root.path.start.y)))/3;
    Vector3D branchStart = root.path.getPointWithThisY(branchY);
    float branchLength = random(100)/(.4*this.level*this.level);
    float yNorm = random(-.8, .2);
    float xNorm = random(yNorm*yNorm-1, yNorm*yNorm+1);
    float pos = random(-1, 1);
    float zNorm;
    if(pos > 0) zNorm = 1 - xNorm*xNorm - yNorm*yNorm;
    else zNorm = xNorm*xNorm + yNorm*yNorm - 1;
    //println(xNorm + " " + yNorm + " " + zNorm);
    Vector3D branchEnd = branchStart.addVector(new Vector3D(xNorm, yNorm, zNorm).multiplyScalar(branchLength));
    this.path = new Line(branchStart, branchEnd);
    if(this.level < this.endLevel){
      this.branches = new Branch[numBranches];
      for(int i = 0; i < numBranches; i++){
        branches[i] = new Branch(this);
      }
    }
  }
  
  public void drawBranch(PApplet visual){
    visual.line(this.path.start.x, this.path.start.y, this.path.start.z, this.path.end.x, this.path.end.y, this.path.end.z);
    if(this.level < this.endLevel){
      for(Branch b: this.branches){
        b.drawBranch(visual);
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