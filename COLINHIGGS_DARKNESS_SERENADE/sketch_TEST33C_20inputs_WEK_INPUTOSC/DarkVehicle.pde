// 
//
//
//
//
//   CREATE SWARM OF DARK VEHICLE PARTILCES
//
//   The basic setup swarms was based on tutorials from Daniel Shiffman
//
//    Swarms:
//    https://youtu.be/JIz2L4tn5kM
//
//    THIS DOES ALOT MORE:
//   * DELETES THE PARTICLES IF THE DISTANCE BETWEEN NEW AND OLD IS QUITE SMAALL
//   * DELETES THE PARTICLES IF THE DISTANCE BETWEEN THE PARTICLE  AND THE TARGET IS SMALL
//   * CALLS A RANDOM FUNCTION IF THE PERSON HASNT MOVED (noMovement1Interval) 1O SECONDS "diffForce"
//
//     WE HAVE RANDOM VALUES FOR TO CALC IF THE DISTANCE TO TARGET HAS BEEN EXCEEDED: barrierDistance
//     AND THE DISTANCE TO THE LAST POSITION HAS BEEN EXCEEDED:limitofMovedMouse
//   
//     limitofMovedMouse =  int(random(10,1000));
//     noMovement1Interval=int(random(10000,20000));
//     barrierDistance= random(20,300);
//
//
//
class DarkVehicle {

  // All the usual stuff
  PVector position;
  PVector randomPos;
  PVector lastPos;
  PVector velocity;
  PVector acceleration;
  
  float barrierDistance;

  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  
  // diferent forces
  float lastd;
  
  // time interval 01 no action
  int noMovement1Time;
  int noMovement1Interval;
  boolean diffForce;
  
  
  
  
  // col info
  int stepR;
  int stepG;
  int stepB;
   float radius;

  float noiseR;
  float noiseG;
  float noiseB;
  float randomMax;
  int rb;
  int bb;
  int gb;
  int  limitofMovedMouse;
  float xs;
  float ys;
  float r;
  float g;
  float b;
  float scaleFact;
  float sep;
  float theta;
  float prevMouse;
    

  
  
  
  

    // Constructor initialize all values
    DarkVehicle(float x, float y, int whatkind,float mmaxspeed, float mmaxforce,float myRadius) {
    position = new PVector(x, y);
    lastPos  = new PVector(x, y);
   // diffForce= new boolean[1];
    //data = new int[5];
 
    // random force vectors
    randomPos = new PVector(0,0);
    
    // random force bariers all differnt
    barrierDistance= random(20,300);
    // NO MOVEMENT BASIC 1
    //noMovement1Interval=10000;
    
    
    // EVERY PARTICLE DIFFERNT MOUSE INTERVAL
    limitofMovedMouse =  int(random(10,1000));
    noMovement1Interval=int(random(10000,20000));
    noMovement1Time=millis()+noMovement1Interval;
  
   // radius = int(random(22,5));
   
   //setup system values
   if (whatkind == 1) {
     
   // IF  BRIGHT PARTICLES
    diffForce = false;
    radius = 2;
    maxspeed = 1.0;
    prevMouse=0;
    maxforce = 1;
    randomMax = 1.0;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
     theta=1;
    
    ///colour
    r=220;
    g=120;
    b=23;
    //r=random(255);
   // g=random(255);
   // b=random(255);
    rb=1;
    bb=1;
    gb=1;
    
    
     } else if (whatkind == 0) {
    
     // IF  DARK PARTICLES
    diffForce = false;
    //radius = 1;
    radius = myRadius;
    maxspeed = 0.2;
    prevMouse=0;
    maxforce = 0.5;
    randomMax = 1.0;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
     theta=1;
    
    ///colour
    r=5;
    g=5;
    b=5;
    //r=random(255);
   // g=random(255);
   // b=random(255);
    rb=1;
    bb=1;
    gb=1;
       
       
       
       
     }
    
    
    
    
    
    // RANDOMLY GENERATE R,G,B, SCALE FACTORS BETWEEN 0-1
    stepR= int(random(2367));
    stepG= int(random(3412));
    stepB= int(random (6767));

    noiseR=noise(stepR);
    noiseG=noise(stepG);
    noiseB=noise(stepB);
    
    // random move 
    xs =random(width);
    ys =random(height);


    
    
    
    
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  } //end applyforce
  
  
  
  
  
  
  void applyBehaviors(ArrayList<DarkVehicle> vehicles, int Mx,int My) {
     PVector separateForce = separate(vehicles);
     PVector seekForce = seek(new PVector(Mx,My));
      PVector inputVector = new PVector(Mx,My);
  
       //What are we seeking?
       
     // CHECK DISTANCE BETWEEN CURRENT INPUT POSITION  AND CURRENT PARTICLE POSN
      // lastd = PVector.dist(inputVector, lastPos);
       lastd = PVector.dist(inputVector, position);
      
     
     
    // update last pos every ten seconds
    
    if (millis() > noMovement1Time) {
      
      //if inputVector  to  lastpos  < 50
      
      
     // println("Mx=",Mx);
    //  println("lastPos.x=",lastPos.x,"Mx=",Mx);
      
   
       
      // println("diffForce=",diffForce[0]);
     // println("noMovement1Time=",noMovement1Time,"currenttime=",millis());
      // println("lastPos.x=",lastPos.x,"Mx=",Mx);
      // println("MOUSE POSITION AND CURRENT PART POSN lastd=",lastd);
      
     noMovement1Time=millis()+noMovement1Interval;
     
     // change lastpos to current input value EVREY 10 SECONDS
     //UPDATE LAST POSITION EVERY 10 SECONDS
      lastPos.x  = Mx;
      lastPos.y  = My;
      
      
    }//MILLIS UPDATED 
    
       // check difference between lastpos is less than 10
       // CHECK IF MOUSE HAS MOVED
       
       //CHECK IF MOUSE HAS MOVED
       float lastPosDiff=  abs( lastPos.x-Mx);
       
     //  println("lastPosDiff=",lastPosDiff);
    
      //if (lastd < 5 && lastPosDiff  < 10) {
      //barrierDistance 
      // if (lastd < 70 && lastPosDiff  < 10)  {
        
         if (lastPosDiff  < 1)  {
           
            
         if (  CountDarkNumber < DarkNumberLimit) {
         CountDarkNumber++;
         println("add 1 dark vehicle ");
         println("CountDarkNumber= ",CountDarkNumber);
         darkvehicles.add(new DarkVehicle(random(width/2),random(height/2),0,oscParticlemaxspeed,  oscParticlemaxforce,oscRadius ));
         } // add a dark vehicle if it < limit
    
        }// extreme condition
        
        //SWITCH FORCES RANDOM AND SEEK
        if (lastd < barrierDistance && lastPosDiff  < limitofMovedMouse)  {
         diffForce = true;
        
        
            
       } else {
           //println("diffForce=",diffForce);
         diffForce = false;
       }
      // println("diffForce=",diffForce[0]);
     
     
     
     
     if (diffForce)  {
       // seek random force if pos difference is less than 50
    // println("seeking random force");
      seekForce = seek(RandomMove());
       }// lastpos diff from posn
     
     
       
     
     separateForce.mult(8);
     seekForce.mult(1);
     
     // APPLY ALL FORCES
     applyForce(separateForce);
     applyForce(seekForce); 
  }// end Behaviurs
  
  
  
  
  
  
  
  
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


PVector seekRandom(PVector target) {
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
  PVector separate (ArrayList<DarkVehicle> vehicles) {
    float desiredseparation = radius*2;
    PVector sum = new PVector();
    int count = 0;
    // For every boid in the system, check if it's too close
    for (DarkVehicle other : vehicles) {
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
  } // darkvehicle










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
    //fill(255,0,0);
   // fill(r,g,b);
    //stroke(0);
    noStroke();
    pushMatrix();
    translate(position.x, position.y,100);
    colorMode(HSB, 360, 900, 20);
    //r= 20;
    //g=60;
    //b=30;
    
   //  r=220;
   // g=120;
   // b=23;
    r=105;
    g=105;
    b=5;
    fill(r, g, b, 255);
    colorMode(RGB,100);
    //rotate
    theta= theta/map(int(abs(mouseX-pmouseX)),0,60,1,5);
   // println(theta);
   // rotateY(theta/3);
   // rotateZ(theta/2);
    
     rect(12,5,4,4);
    ellipse(0, 0, radius, radius);
    popMatrix();
    
    //rotate
    theta++;
  }//emd disply
  
  
  
  
  
  
  
  
  
  
  
   void changecol(ArrayList<BrightVehicle> vehicles,int mX,int mY ) {
     // For every boid in the system, chnage col
     


  //frameRate(100);
 // colorMode(RGB, 1.0);
 // setup a color mode of HSB
//colorMode(HSB, 360, 100, 20);

// ANTIALIAS
  smooth();

     
   
      
      
     // float d = PVector.dist(position, other.position);
              // chnage color stroke over time
 // r-=0.6*rb;
 // g-=0.4*gb;
 // b-=0.3*bb;
 
 // CHANGE COLSTROKE OVER TIME
  
// r-=noiseR*rb;
// g-=noiseG*gb;
// b-=noiseB*bb;
  
  r-=noiseB*bb/15;
 g-=noiseB*bb/15;
b-=noiseB*bb/15;
 // println("r=",r,"g=",g,"b=",b);
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
   // stroke(0);
   noStroke();
    pushMatrix();
    //colorMode(HSB, width/2, height/2, 100); 
 // colorMode(HSB, 360, 900, 20);
    fill(r, g, b, 255);
    translate(position.x, position.y);
    
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
    
 //   rotateY(theta);
   // println(theta);
    //rotateZ(theta/2);
    rect(12,5,4,4);
    //rect(0,0,14,14);
    ellipse(0, 6, radius, radius);
    popMatrix();
    //println(theta);
    
    //rotate
   // theta+=random(0.04,2);




} //end color chnage

PVector RandomMove(){
      
  //random move please
        xs += random(-randomMax,randomMax);

        ys += random(-randomMax,randomMax);
        
        //access pvector
        randomPos.x+= xs;
        randomPos.y += ys;
        
        if(randomPos.x < 0) { randomPos.x = 0; xs *= -.5;}
        if(randomPos.x > width-20) { randomPos.x = width-20; xs *= -.5;}
        if(randomPos.y < 0) { randomPos.y = 0; ys *= -.5;}
        if(randomPos.y > height-20) { randomPos.y = height-20; ys *= -.5;}
        
        //println("randomPos=",randomPos);
        
        return randomPos;
        
    } //end RandomMove
     

  
  
  
  

}//end class