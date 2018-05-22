// tutorial
class BrightVehicle {

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
  int radius;

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
  float timeToLerp;
  color interA;
    

  
  
  
  

    // Constructor initialize all values
    BrightVehicle(float x, float y, int whatkind,float mmaxspeed, float mmaxforce) {
   timeToLerp=0;
   //olor to = color(84, 149, 255);
  
   interA=color(84, 149, 255);
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
     
     println("whatkind=",whatkind );
     
   // IF  BRIGHT PARTICLES
    diffForce = false;
    radius = 2;
   // maxspeed = 1.0;
   // maxforce = 1;
    maxspeed = mmaxspeed;
    maxforce = mmaxforce;
    prevMouse=0;
    
    randomMax = 1.0;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
     theta=1;
  //  r=255;
  //  g=255;
  //  b=255;84, 149, 175)84, 149, 255
    r=84;
    g=149;
    b=255;
    ///colour
  //  r=220;
   // g=120;
   // b=23;
    //r=random(255);
   // g=random(255);
   // b=random(255);
    rb=1;
    bb=1;
    gb=1;
    
    
     } else if (whatkind == 0) {
    
     // IF  DARK PARTICLES
    diffForce = false;
    radius = 1;
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
       
       
       
       
     }//constuctor
    
    
    
    
    
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
  
  
  
  
  
  
  void applyBehaviors(ArrayList<BrightVehicle> vehicles,ArrayList<DarkVehicle> darkvehicles, int Mx,int My) {
     PVector separateForce = separate(vehicles);
    PVector separateForceDark = separatedark(position,darkvehicles);
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
    //  println("noMovement1Time=",noMovement1Time,"currenttime=",millis());
    //   println("lastPos.x=",lastPos.x,"Mx=",Mx);
     //  println("MOUSE POSITION AND CURRENT PART POSN lastd=",lastd);
      
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
        
        
        if (lastd < 10 && lastPosDiff  < 4)  {
         //  remove a  white vehicle
          if (brightvehicles.size() >0) {
            println("1 white vehicle removed");
           
            CountBrightNumber--;
            println("CountBrightNumber =",CountBrightNumber);
            brightvehicles.remove(0);
            }// delete a white vehicle
        }//
        
        
        //SWITCH FORCES RANDOM AND SEEK limitofMovedMouse
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
     separateForceDark.mult(1);
     
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
  PVector separate (ArrayList<BrightVehicle> vehicles) {
    float desiredseparation = radius*2;
    PVector sum = new PVector();
    int count = 0;
    // For every boid in the system, check if it's too close
    for (BrightVehicle other : vehicles) {
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










  void display(int lerpperiod) {

    colorMode(RGB);
    //lerp between colours
    color from = color(r, g, b);
    //color to = color(220, 120, 23);
    
    color to = color(84, 149, 255);
    if ( millis() <= lerpperiod+2000){
   // println("LERPINGCOLOUR");
    timeToLerp= map(millis(),lerpperiod,lerpperiod+2000,0,1);
    interA = lerpColor(from, to, timeToLerp);
    } else {
       //   println(",,,,,,,,,,,,,,,,,,,,");
    //println("R=",r,"G=",g,"b=",b);
    //  println(",,,,,,,,,,,,,,,,,,,,");
      
    }
    //fill(255,0,0);
   // fill(r,g,b);
    //stroke(0);
    noStroke();
    pushMatrix();
    translate(position.x, position.y,100);
   // colorMode(HSB, 360, 100, 20);
      //colorMode(HSB, 360, 900, 20);
    // r=220;
    //g=120;
   // b=23;
    //r=random(255);
   // g=random(255);
   // b=random(255);
   // rb=1;
   // bb=1;
    //gb=1;
    fill(interA,255);
   // fill(r, g, b, 255);
    
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
    // println("BRIGHT COLOR");
     


  //frameRate(100);
 // colorMode(RGB, 1.0);
 // setup a color mode of HSB
//colorMode(HSB, 360, 100, 20);

// ANTIALIAS
  smooth();

     
   
      
      
     // float d = PVector.dist(position, other.position);
              // chnage color stroke over time
 r-=0.6*rb;
  g-=0.4*gb;
  b-=0.3*bb;
 
 // CHANGE COLSTROKE OVER TIME
  
// r-=noiseR*rb;
// g-=noiseG*gb;
// b-=noiseB*bb;
  
//  r-=noiseB*bb/15;
 //g-=noiseB*bb/15;
//b-=noiseB*bb/15;
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
    //colorMode(HSB, width/2, height/2, 100); ///////  
    // colorMode(HSB, 360, 900, 20);
    //colorMode(HSB, 360, 900, 20);
    colorMode(RGB);
   // colorMode(HSB, 360, 100, 100);
 //  colorMode(HSB, 360, 100, 100);

    fill(r, g, b, 255);
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
    
    
   
      // Separation
  // Method checks for nearby vehicles and steers away
  PVector separatedark (PVector myposition, ArrayList<DarkVehicle> darkvehicles) {
    float desiredseparation = radius*2;
    PVector sum = new PVector();
    int count = 0;
    // For every boid in the system, check if it's too close
    //for (DarkVehicle other : vehicles) {
      for (int i = 0; i < darkvehicles.size()-1; i++) {
         DarkVehicle v = darkvehicles.get(i);
      float d = PVector.dist(v.position, myposition);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(v.position, myposition);
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


  
  
  
  

}//end class
