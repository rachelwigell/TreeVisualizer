public class Vector3D {
  public float x;
  public float y;
  public float z;
  
  public Vector3D(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public Vector3D(double x, double y, double z){
    this.x = (float) x;
    this.y = (float) y;
    this.z = (float) z;
  }
  
  public Vector3D(Vector3D vec){
    this.x = vec.x;
    this.y = vec.y;
    this.z = vec.z;
  }
  
  public float distance(Vector3D to){
    return (float) Math.sqrt(squareDistance(to));
  }
  
  public float squareDistance(Vector3D to){
    return (float) (Math.pow(this.x - to.x, 2) + Math.pow(this.y - to.y, 2) + Math.pow(this.z - to.z, 2));
  }
  
  public Vector3D addScalar(float quantity){
    return new Vector3D(this.x + quantity, this.y + quantity, this.z + quantity);
  }
  
  public Vector3D addVector(Vector3D vector){
    return new Vector3D(this.x + vector.x, this.y + vector.y, this.z + vector.z);
  }
  
  public Vector3D multiplyScalar(float quantity){
    return new Vector3D(this.x * quantity, this.y * quantity, this.z * quantity);
  }
  
  public void printOut(String label){
    System.out.println(label + " x: " + this.x + " y: " + this.y + " z: " + this.z);
  }
  
  public float magnitude(){
    return (float) Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2) + Math.pow(this.z, 2));
  }
  
  public Vector3D normalize(){
    float magnitude = this.magnitude();
    return new Vector3D(this.x/magnitude, this.y/magnitude, this.z/magnitude);
  }
  
  public float dotProduct(Vector3D with){
    return this.x*with.x + this.y*with.y + this.z*with.z;
  }
}