// tutorial
class Vehicle {

  // All the usual stuff
  PVector position;
  PVector velocity;
  PVector acceleration;

  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  
  
  // col info
  int stepR;
  int stepG;
  int stepB;
  int radius;

  float noiseR;
  float noiseG;
  float noiseB;
  int rb;
  int bb;
  int gb;
  float r;
  float g;
   float b;
   float scaleFact;
   float sep;
   float theta;
 float prevMouse;
    

  
  
  
  

    // Constructor initialize all values
  Vehicle(float x, float y) {
    position = new PVector(x, y);
   // radius = int(random(22,5));
    radius = 12;
    maxspeed = 3;
    prevMouse=0;
    maxforce = 0.2;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
     theta=1;
    
    ///col shit
    r=220;
    g=120;
    b=23;
    rb=1;
    bb=1;
    gb=1;
    // random colors
    
    
    
    // RANDOMLY GENERATE R,G,B, SCALE FACTORS BETWEEN 0-1
    stepR= int(random(2367));
    stepG= int(random(3412));
    stepB= int(random (6767));

    noiseR=noise(stepR);
    noiseG=noise(stepG);
    noiseB=noise(stepB);


    
    
    
    
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }
  
  
  
  
  
  
  void applyBehaviors(ArrayList<Vehicle> vehicles, int Mx,int My) {
     PVector separateForce = separate(vehicles);
     PVector seekForce = seek(new PVector(Mx,My));
     separateForce.mult(2);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce); 
  }
  
  
  
  
  
  
  
  
    // A method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target,position);  // A vector pointing from the position to the target
    
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    
    return steer;
  }







  // Separation
  // Method checks for nearby vehicles and steers away
  PVector separate (ArrayList<Vehicle> vehicles) {
    float desiredseparation = radius*2;
    PVector sum = new PVector();
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Vehicle other : vehicles) {
      float d = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        sum.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      sum.div(count);
      // Our desired vector is the average scaled to maximum speed
      sum.normalize();
      sum.mult(maxspeed);
      // Implement Reynolds: Steering = Desired - Velocity
      sum.sub(velocity);
      sum.limit(maxforce);
    }
    return sum;
  }










  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }










  void display() {
    fill(175);
    stroke(0);
    pushMatrix();
    translate(position.x, position.y);
    
    //rotate
    theta= theta/map(int(abs(mouseX-pmouseX)),0,60,1,5);
   // println(theta);
    rotateY(theta/3);
    rotateZ(theta/2);
    
    
    ellipse(0, 0, radius, radius);
    popMatrix();
    
    //rotate
    theta++;
  }//emd disply
  
  
  
  
  
  
  
  
  
  
  
   void changecol(ArrayList<Vehicle> vehicles,int mX,int mY ) {
     // For every boid in the system, chnage col
     


  //frameRate(100);
 // colorMode(RGB, 1.0);
 // setup a color mode of HSB
//colorMode(HSB, 360, 100, 20);

// ANTIALIAS
  smooth();

     
   
      
      
     // float d = PVector.dist(position, other.position);
              // chnage color stroke over time
  //r-=0.6*rb;
 // g-=0.4*gb;
 // b-=0.3*bb;
 
 // CHANGE COLSTROKE OVER TIME
  
 // r-=noiseR*rb;
 // g-=noiseG*gb;
 // b-=noiseB*bb;
  
  r-=noiseB*bb/10;
  g-=noiseB*bb/10;
  b-=noiseB*bb/10;
  
  // IF RGB VALUES GO OUT OF RANGE COUNT IN REVERSE AND RESET RGB SCALE FACTOR VALUE
  if ((r<3) ||  (r>253)){
    scaleFact=random(90,120);

    rb*=-1;
    stepR= int(random(2367));
    noiseR=noise(stepR);
    
  }
  
  if ((g<3) ||  (g>253)) {
    scaleFact=random(100,120);

    gb*=-1;
    stepG= int(random(1367));
    noiseG=noise(stepG);
  }
  
  if ((b<3) ||  (b>253)){
    scaleFact=random(90,110);

    bb*=-1;
    stepB= int(random(1367));
    noiseB=noise(stepB);
  }
  
  
    
   // println ("r=",r);
    stroke(0);
    pushMatrix();
    colorMode(HSB, 360, 100, 20);
    fill(r, r, r, 200);
    translate(position.x, position.y,100);
    
      if ( mX > prevMouse) {
     
     theta+=0.05;
    // theta=180;
    //constrain(degrees(theta), 0, 180);
     prevMouse=pmouseX-10;
     if (theta > 3.14159) theta=3.14159;
    
     } else {
       prevMouse=pmouseX+10;
      theta-=0.05;
       //theta=0;
       if (theta < 0) theta=0;
       //constrain(degrees(theta), -180, 0);
    
     }
    //rotate
     //theta= theta/map(int(abs(mouseX-pmouseX)),0,60,1,5);
    
    rotateY(theta);
    //rotateZ(theta/2);
    rect(12,5,4,4);
    //rect(0,0,14,14);
    ellipse(0, 6, radius, radius);
    popMatrix();
    //println(theta);
    
    //rotate
   // theta+=random(0.04,2);




}
     

  
  
  
  

}//end class
