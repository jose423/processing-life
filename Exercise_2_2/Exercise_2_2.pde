//Rewrite the applyForce() method using 
//the static method div() instead of get().

void applyForce(PVector force) {
  PVector f = PVector.div(force,mass);
  acceleration.add(f);
}
