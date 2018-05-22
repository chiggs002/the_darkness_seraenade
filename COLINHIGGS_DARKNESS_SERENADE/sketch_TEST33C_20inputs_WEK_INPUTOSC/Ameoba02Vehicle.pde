// 
//
//
//
//
//   CREATE SWARM OF AMEOBA02 PARTILCES
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
//

class Ameoba02Vehicle {

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
  float timeToLerp;
  color interA;
    
    // ameoba variables
    int moveTimer;
    float ameobaNoiseY;

  
  
  
  

    // Constructor initialize all values
    Ameoba02Vehicle(float x, float y, int whatkind, float mmaxspeed, float mmaxforce,float myRadius) {
    moveTimer=0;
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
    
    
    // EVERY PARTICLE DIFFERNT MOVE INTERVAL VALUE
    limitofMovedMouse =  int(random(10,1000));
    noMovement1Interval=int(random(10000,20000));
    noMovement1Time=millis()+noMovement1Interval;
  
   // radius = int(random(22,5));
   
   //setup system values
   if (whatkind == 1) {
     
     println("whatkind=",whatkind );
     
   // IF  BRIGHT PARTICLES
    diffForce = false;
  //  radius = int(random(3,13));
 // radius=int(random(1,3));
  radius=myRadius;
    //maxspeed = 1.0;
    prevMouse=0;
    //maxforce = 1;
    // maxspeed = 1.0;
   // maxforce = 1;
    maxspeed = mmaxspeed;
    maxforce = mmaxforce;
    randomMax = 1.0;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
     theta=1;
  //  r=255;
  //  g=255;
  //  b=255;84, 149, 175)84, 149, 255
    r=284;
    g=random (120,179);
    b=55;
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
    radius = int(random(6,12));
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
  
  
  
  
  
  
  void applyBehaviors(ArrayList<Ameoba02Vehicle> vehicles,ArrayList<DarkVehicle> darkvehicles, int Mx,int My) {
     //SEPERATE PARTICLES IF THEY ARE TOO CLOSE
    PVector separateForce = separate(vehicles);
     PVector separateForceDark = separatedark(position,darkvehicles);
     // SEEK THE TARGET MX AND MY
     PVector seekForce = seek(new PVector(Mx,My));
     PVector inputVector = new PVector(Mx,My);
  
       //What are we seeking?
       
       
     // CHECK DISTANCE BETWEEN CURRENT INPUT POSITION  AND CURRENT PARTICLE POSN
      // lastd = PVector.dist(inputVector, lastPos);
       lastd = PVector.dist(inputVector, position);
      
     
     
    // update last pos every ten seconds
    // UPDATE THE LAST POSITION EVERY 10 SECONDS
    
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
         
        
        // LASTD= MOUSEPOSN AND PARTICLE POSTION
        //LASTPOSDIFF= LAST 2 POSITINS OF OBJECT
        if (lastd < 55   && lastPosDiff  <99)  {
         //  remove a  white vehicle
          if (ameoba02vehicles.size() >=0) {
            println("1 white vehicle removed");
           
            ameoba02EraticNumber--;
            println("ameobaEraticNumber =",ameoba02EraticNumber);
            ameoba02vehicles.remove(0);
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
     
     
     
     // IF THE PERSON HASNT MOVED FOR 10 SECONDS APPLY A RANDOM POSITION TARGET ALGORITHM
     if (diffForce)  {
       // seek random force if pos difference is less than 50
    // println("seeking random force");
     // SEEKS A RANDOM VECTOR
      seekForce = seek(RandomMoveTimer());
       //seekForce = seek(RandomMove());
      
       }// lastpos diff from posn
     
     
       
     //SEPERATE THE PARTICLES FROM EACH OTHER
     // CALCULATE THE TARGT FORCE
     separateForce.mult(8);
     seekForce.mult(1);
     // calc a force to avoid the dark particles
     separateForceDark.mult(1);
     
     // APPLY ALL FORCES
     applyForce(separateForce);
     applyForce(seekForce); 
  }// end Behaviurs
  
  
  
  
  
  
  
  
    // A method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  //
  // Get a vector towards target: target-position
  //
  //
  //
  //
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


// not used
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
  PVector separate (ArrayList<Ameoba02Vehicle> vehicles) {
    float desiredseparation = radius*2;
    PVector sum = new PVector();
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Ameoba02Vehicle other : vehicles) {
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
//
//
//
// changes particles back to white when its finshed changing the color
// all draws the particles
//
//
//
//
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
    stroke(interA,255);
   // fill(r, g, b, 255);
    
    //rotate the particles
    theta= theta/map(int(abs(mouseX-pmouseX)),0,60,1,5);
   // println(theta);
   // rotateY(theta/3);
   // rotateZ(theta/2);
    
   //  rect(12,5,4,4);
   // ellipse(0, 0, radius, radius);
    //drawAmeoba(radius);
    // DRAW CELLUAR CREATURES
    drawAmeoba02(radius);
    popMatrix();
    
    //rotate
    theta++;
  }//emd disply
  
  
  
  
  
  
  
  
  
  
  
   void changecol(ArrayList<Ameoba02Vehicle> vehicles,int mX,int mY ) {
     
//
//  Change particles over time
//  also draws the paticles
//
//
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
    stroke(r,g,b,254);
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
 ///   rect(0,0,4,4);
   // rect(0,0,14,14);
    //ellipse(0, 6, radius, radius);
    //drawAmeoba(radius);
   drawAmeoba02(radius);
    
    popMatrix();
    //println(theta);
    
    //rotate
   // theta+=random(0.04,2);




} //end color chnage

PVector RandomMove(){
 //
 //
 // randomly move the particles
 //
 //
 //
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
    
    
    
    PVector RandomMoveTimer(){
      
  //random move please
  /// move between random moving particles
  //  and strightline particles
      
        
        //add timer
        if (millis() > moveTimer ) {
          
        println("add random:");
        xs += random(-randomMax,randomMax);

        ys += random(-randomMax,randomMax);
    
        moveTimer= millis() +2000;
      }
        
        
        
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



void drawAmeoba(float radius ){
//
//
//  Draw cellular figures with of set of joined vertices
//
//  not filled
//
//
//
 
//translate(width/2,height/2);
smooth();
//fill(4,1);
//stroke(r,g,b,254);
strokeWeight(0.3);
noFill();
beginShape();
//background(0);

for(float i=0;i<2*PI;i+=PI/64) {
vertex((radius +10*noise(i,ameobaNoiseY))*cos(i),(radius +10*noise(i,ameobaNoiseY))*sin(i));
 
vertex((radius +13*noise(i,ameobaNoiseY))*cos(i), (radius +13*noise(i,ameobaNoiseY))*sin(i));
//println("250+(99+80*noise(i,g))*cos(i)=",250+(99+80*noise(i,ameobaNoiseY))*cos(i));
}

endShape(CLOSE);
ellipse(0, 0, 3, 3);
// rect(0,0,4,4);
ameobaNoiseY+=.01;


}//END AMEOBA 1




void drawAmeoba02(float radius ){
  //
//
//  Draw cellular figures with of set of joined vertices
//
//  filled
//
//
//
 
 
//translate(width/2,height/2);
smooth();
//fill(r,g,b,1);
//stroke(r,g,b,254);
strokeWeight(0.3);
//noFill();
beginShape();
//background(0);

for(float i=0;i<2*PI;i+=PI/64) {
vertex((radius +22*noise(i,ameobaNoiseY))*cos(i),(radius +22*noise(i,ameobaNoiseY))*sin(i));
 
vertex((radius +33*noise(i,ameobaNoiseY))*cos(i), (radius +33*noise(i,ameobaNoiseY))*sin(i));
//println("250+(99+80*noise(i,g))*cos(i)=",250+(99+80*noise(i,ameobaNoiseY))*cos(i));
}

endShape(CLOSE);
//ellipse(0, 0, 8, 8);
// rect(0,0,4,4);
ameobaNoiseY+=.01;


}//END AMEOBA 2



  
  
  
  

}//end class