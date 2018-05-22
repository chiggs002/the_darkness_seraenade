//   Colin Higgs The Darkness Serenade //<>//
//
//
//   The basic setup of the kinect and swarms was based on tutorials from Daniel Shiffman
//
//    Swarms:
//    https://youtu.be/JIz2L4tn5kM
//
//
//    Kinect setup:
//    https://youtu.be/QmVNgdapJJM?list=PLRqwX-V7Uu6ZMlWHdcy8hAGDy6IaoxUKf
//
//    Processing osc data setup from Rebecca Fiebrink
//    http://www.wekinator.org/examples/#Download_All_Source
//
//
//
//   THIS PATCH CREATES ALL THE SWARMS FOR THE DARKNESS SERENADE:
//
//
//
//   The processing sketch consists of 5 particle swarms called:
//
//    Ameoba02Vehicle: cell like but big
//    AmeobaVehicle: cell like but small
//    BrightVehicle: tadpole like
//    DarkVehicle: small black particles
//    EraticVehicle: like a "firework" pattern that uses a lissajous pattern
//
//    These are triggered by the Graphics Trigger Values.  oscGraphicsTrigger 
//
//    This in turn triggered counters for all the the graphics which keep getting updated.   
//    However, when they are seen is triggered by "Mixup Graphics" value that keeps changes 
//    it mind about the trigger values.
//
//
//   THIS PATCH ALSO PASSES ON WEKINATOR DATA VIA OSC TO MAXMSP & CONROLS WEKINATOR DATA SETS:
//
//   SENDS ALL OUTPUTS TO THE WEKINATOR HELPER ON PORT 6449
//   SENDS ALL DATA OUTPUTS FROM WEKINATOR TO MAXMSP VIA OSC
//   
//    THE DATA VALUES USED IN THIS SKETCH FROM WEKINATOR:
//
//     oscFloatx1     - average position of person in x uses depth data
//     oscFloaty1     - average position of person in y uses depth data
//
//     oscFloatvel1   - average velocity of person detected
//     oscFloataccel1 - average acceleration of person detected
//     countMinutes   - count in minutes since simulation started
//     oscFloatSignal - Has kinect detected a person? yes 1 no 0
//     oscAccelMax    -  Gives me a max acceleration reading from the last 10 
//
//     oscRadius      -  Based on oscFloataccel1 the radius of the particles changes
//
//     oscAccelStdDev -  Acceleration based on Standard deviation
//     oscposXStdDev  -  Pos X Standard Deviation value
//     oscposYStdDev  -  Pos Y Standard Deviation value
//
//     oscConductEvents -    MAXMSP controllers changes the music events
//     oscConductTime   -    MAXMSP controller changes the period a sample is played for uses milli seconds
//     oscGraphicsTrigger  - Creates a particle based on if this value is exeeded or not.
//     oscColourTrigger    - Changes the color of the graphics if this value is exceeded
//     oscParticlemaxspeed - Changes the speed of the particles
//     oscParticlemaxforce - Changes the force of the particles  
//     oscMixGraphics      - Changes the counters for all the graphics which chnages which graphics will be created
//
//
//   oscCorners     - Has kinect detected a any gestures? (0-no 1-2-3-4==n-s-w-e)
//   oscStretchx1   - if any gestures have been detected send x cord
//   oscStretchy1    - if any gestures have been detected send y cord
//
//
//
//   Sends out osc data on port 6022 to MAXMSP on the local network
//   Sends out osc data on port 6049 to Wekinator  on the local network
//   
//
//
//
//    THE BULK OF THIS PATCH IS ABOUT THE CREATION OF DIFFERENT CLASSES OF PARTICLES:
//    
//    DarkVehicle graphics are created when the accerlated graphics dissapeear:
//    Ameoba02Vehicle,AmeobaVehicle,BrightVehicle,EraticVehicle: will all dissapear if the person does not move
//    
//    When Ameoba02Vehicle,AmeobaVehicle are created all BrightVehicle particles dissapear.
//    
//
//    All graphics apart from the dark graphhics change color if "oscColourTrigger" is exceeded
//

//
//   
//

  
   







  


















// SET UP THE LIBRARIES FOR OSC 

import oscP5.*;
import netP5.*;
OscP5 oscP5, oscP6,  oscP7;
NetAddress dest,dest_Wek;

// SET UP THE LIBRARIES FOR Kinect
// Not used here now but initially it was designed with the inputs coming from here.
import org.openkinect.freenect.*;
import org.openkinect.processing.*;


////// setup all particles SWARMS

// SET UP ARRAYLIST FOR SWARMS
ArrayList<BrightVehicle> brightvehicles;

// SET UP ARRAYLIST FOR SWARMS
ArrayList<DarkVehicle> darkvehicles;

// SET UP ARRAYLIST FOR SWARMS
ArrayList<EraticVehicle> eraticvehicles;

// / SET UP ARRAYLIST FOR CELLULAR SWARMS
ArrayList<AmeobaVehicle> ameobavehicles;
ArrayList<Ameoba02Vehicle> ameoba02vehicles;









Kinect kinect;

// Angle for rotation
float a = 0;
float deg;

// kinect data
boolean ir = false;
boolean colorDepth = false;
boolean mirror = false;
PImage  img;
float minThresh=200;
float maxThresh=850;

//depth positions
float  avgX;
float  avgY;
float  multWidth,multHeight;
int rhx;
int rhy;
int rdx;
int rdy;


//SETUP OSC VARIBALES
float oscFloatx1;
float oscFloaty1;
float oscFloatvel1;
float oscFloataccel1;
int   oscCountTime;
float oscFloatSignal;
int   oscTime;

/// MAKE TRIGGER VARIABLES
float oscGraphicsTrigger;
float oscColourTrigger;
float oscParticlemaxspeed ;
float oscParticlemaxforce ;
int   oscMixGraphics;
float oscAccelMax;
float oscAccelStdDev;
float oscposXStdDev;
float oscposYStdDev;
float oscConductEvents;
float oscConductTime;
float oscCorners;
float oscCornersx1;
float oscCornersy1;
float oscRadius;

  


// limit bright pixels
int BrightNumberLimit;
int CountBrightNumber;
int DarkNumberLimit;
int CountDarkNumber;
int brightTime;
int lerpTime;
int brightTimeInterval;

// DIFFERENT COUNTERS FOR ALL THE GRAPHICS
int startEraticCounter;
int eraticCounter;
int eraticTime;
int eraticNumberLimit;
int CountEraticNumber;

int startAmeobaCounter;
int ameobaCounter;
int ameobaTime;
int ameobaNumberLimit;
int ameobaEraticNumber;
int ameobaFlag;

int startAmeoba02Counter;
int ameoba02Counter;
int ameoba02Time;
int ameoba02NumberLimit;
int ameoba02EraticNumber;
int ameoba02Flag;
float anglecounter;

// OSC SWITCH FOR WEKINATOR DATA SWITCHING BETWEEN DATA
int switchFlag;
int delayTime;
int delayTime08;
int delayTime09;




void setup() {
  
  // setup default osc triggers
  oscTime=0;
  oscGraphicsTrigger=5;
  oscColourTrigger=25;
  oscParticlemaxspeed = 1.0;
  oscParticlemaxforce = 1.0;
  oscMixGraphics=1;
  oscAccelMax=1;
  oscAccelStdDev=5;
  oscposXStdDev=5;
  oscposYStdDev=5;
  oscConductEvents=5;
  oscConductTime=30000;
  oscCorners = 0;
  oscCornersx1 = 0;
  oscCornersy1 = 0;
  switchFlag =0;
  oscRadius=random(1,3);
  
  
//Initialize OSC communication
//oscP5 = new OscP5(this,6000); //listen for OSC messages on port 12000 (Wekinator default)
  oscP5 = new OscP5(this,6021); //listen for OSC messages on port 12000 (Wekinator default)
// CONTROL OUTPUTS TO WEKINATOR
   oscP6 = new OscP5(this,9060);
  
// WHAT PORTS ARE WE SPEAKING WITH?
  dest = new NetAddress("127.0.0.1",6022); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
  dest_Wek = new NetAddress("127.0.0.1",6449);//CONTROL WEKINATOR
  
 
  
  
// WHEN DO OTHER PARICLES GET TRIGGERED?
// DEFAULT VALUES FOR COUNTER TRIGGERS
  
startEraticCounter=500;
startAmeobaCounter=100;
startAmeoba02Counter=95;

// ameoba initualize
  ameobaCounter=1;
  ameobaTime=0;
  ameobaNumberLimit=300;
  ameobaEraticNumber =0;
  ameobaFlag=0;
  
// ameoba  02 initualize
  ameoba02Counter=1;
  ameoba02Time=0;
  ameoba02NumberLimit=300;
  ameoba02EraticNumber =0;
  ameoba02Flag=0;
  
  background(0,255);
 //get time clock in minutes
  eraticCounter=1;
 oscCountTime=0;
 //delayTime=0;
 // CHNAGE THE COLOR OF ALL THE PARTICLES IF THEY ARE EXCITED WITH A CLOCK VARIABLE brightTime
  brightTime= millis();
  brightTimeInterval=2000;
  eraticTime=0;
  anglecounter=0;
////// setup particles

// SET UP DEFAULT VALUES
    avgX=width/2;
    avgY=height/2;
    rdx =0;
    rdy = 0;
    rhx =0;
    rhy = 0;
//  DEAFULT LIMITS ON SWARMS CREATION TRIGGERS
    BrightNumberLimit= 200;
    DarkNumberLimit=500;
    eraticNumberLimit=400;
    CountEraticNumber=0;
    CountBrightNumber=0;
    CountDarkNumber=100;
    
// do we have a signal?
delayTime= 0;
delayTime08=0;
delayTime09=0;
  
  //
  // SET UP BRIGHT PARTICLES and storing them in an ArrayList
  brightvehicles = new ArrayList<BrightVehicle>();
  // We are now making random vehicles and storing them in an ArrayList
  darkvehicles = new ArrayList<DarkVehicle>();
  
   // SET UP ERATIC PARTILES  and storing them in an ArrayList
  eraticvehicles = new ArrayList<EraticVehicle>();
  
  // SET UP CELLULAR 01 PARTICLES and storing them in an ArrayList
  ameobavehicles = new ArrayList<AmeobaVehicle>();
  
  // SET UP CELLULAR 02 PARTICLES and storing them in an ArrayList
  ameoba02vehicles = new ArrayList<Ameoba02Vehicle>();
  
  
  
  
  //setup  SOME dark followers 100 LIMIED TO 500 THEY CAN BOTH BE CREATED AND DELETED
  for (int i = 0; i < 100; i++) {
    darkvehicles.add(new DarkVehicle(random(width/2),random(height/2),0,oscParticlemaxspeed,  oscParticlemaxforce ,oscRadius ));
  }
  
 
  

// SCREEN SIZE FOR DEBUGGING
size(1920, 1080,P3D);
 
 
// FINAL full screen mode
//fullScreen(P3D);
 
} //END SETUP






void draw() {
  //background(100);
  
  
  // CHECK OSCMIX GRAPHICS SETTING
  //
  // WHAT IS THIS DOING? 
  // 
  // WE ARE CHANGING THE TRIGGERS FOR THE CREATION OF ERATIC,AMEOBA AN AMEOBA2 SWARM PARTICLES
  //
  //
  // oscMixGraphics HAS BEEN REMAPPED FROM 1 TO 5 TO 6 TO 10 DEPENDING ON THE TRAINING SET USED
  
  if (oscMixGraphics == 1) {
    
    startEraticCounter=50;
    startAmeobaCounter=300;
    startAmeoba02Counter=150;
    
  } else if (oscMixGraphics == 2) {
     startEraticCounter=50;
    startAmeobaCounter=390;
    startAmeoba02Counter=250;
    
  } else if (oscMixGraphics == 3) {
      startEraticCounter=30;
    startAmeobaCounter=150;
    startAmeoba02Counter=270;
    
   } else if (oscMixGraphics == 4) {
      startEraticCounter=30;
    startAmeobaCounter=240;
    startAmeoba02Counter=170;
    
  } else if (oscMixGraphics == 5) {
      startEraticCounter=30;
    startAmeobaCounter=250;
    startAmeoba02Counter=170;
    
  } 
  
  if (oscMixGraphics == 6) {
    
    startEraticCounter=350;
    startAmeobaCounter=100;
    startAmeoba02Counter=50;
    
  } else if (oscMixGraphics == 7) {
     startEraticCounter=250;
    startAmeobaCounter=90;
    startAmeoba02Counter=250;
    
  } else if (oscMixGraphics == 8) {
      startEraticCounter=430;
    startAmeobaCounter=150;
    startAmeoba02Counter=70;
    
   } else if (oscMixGraphics == 9) {
      startEraticCounter=330;
    startAmeobaCounter=40;
    startAmeoba02Counter=170;
    
  } else if (oscMixGraphics == 10) {
      startEraticCounter=30;
    startAmeobaCounter=50;
    startAmeoba02Counter=170;
    
  } 
  
  
  
  
  
  
  
  
  
  
  
  
//  eractic movement angle increase by anglecounter
//   USES A Lissajous Curve
//   http://mathworld.wolfram.com/LissajousCurve.html
//   SO IT NEED A COUNTER ON THE TIME OR AGLE  ITERATION
anglecounter+=0.5;

fill(0,3);
rect(0,0,width,height);
 


// if the person moves adds a bright value CHECK VALUE oscGraphicsTrigger
//
//
//  CHECK THE VALUES FROM WEKINATOR "oscFloataccel1" AND "oscGraphicsTrigger"
//  oscGraphicsTrigger: CONTINOUSLY CHANGES
//  oscFloataccel1: CONTINOUSLY CHANGES
//
//  if oscFloataccel1 > oscGraphicsTrigger create more bright particles.

if (oscFloataccel1 > oscGraphicsTrigger ) {
  
  // if oscFloataccel1 > oscColourTrigger color all the graphics 
  // add color for 10 seconds CHECK VALUE oscColourTrigger
   if (oscFloataccel1 > oscColourTrigger ) { 
     eraticCounter++;
     ameobaCounter++;
     ameoba02Counter++;
     println(".............................");
     println("..........START COUNTERS...................");
     println("startEraticCounter=",startEraticCounter);
     println("startAmeobaCounter=",startAmeobaCounter);
     println(" startAmeoba02Counter=", startAmeoba02Counter);
     println(".............................");
     println(".............................");
     println("erraticCounter=",eraticCounter);
     println(".............................");
     println(".............................");
     println("ameobaCounter=",ameobaCounter);
     println(".............................");
     println(".............................");
     println("oscMixGraphics=",oscMixGraphics);
     println("..............");
     
     //brighttime CREATE A 2000 SECOND GAP TO CREATE NEW PARTICLES
     // THIS TRIGGERS THE CREATION OF ALL NEW PARTICLES FOR THE BRIGHTSWARMS ONLY 
     brightTime= millis() + brightTimeInterval;
     lerpTime= brightTime +1000;  
     
   }/// ACCELERATION > WAS 25
 
 //startEraticCounter=50;
 //startAmeobaCounter=100;
 //startAmeoba02Counter=150;


 //   create different particles
 //   USES TRIGGERS TO CREATE NEW PARTICLES FOR 2 SECONDS
 if ( eraticCounter % startEraticCounter == 0) {
  // println(" Create eratic particles");
   eraticTime= millis() + 2000;
   }//eracti counter
   
   // create different particles
    if ( ameobaCounter % startAmeobaCounter ==0) {
      ameobaFlag=1;
  // println(" Create ameoba particles");
   ameobaTime= millis() + 2000;
   }//eracti counter
   
   
    // create different particles
    if ( ameoba02Counter % startAmeoba02Counter ==0) {
      ameoba02Flag=1;
   //println(" Create ameoba02 particles");
   ameoba02Time= millis() + 2000;
   }//eracti counter
   
   
   
   
   //create ameoba particles
   // HAVE WE TRIGGERED THE CREATION OF NEW PARTICLES?
   if (millis() < ameobaTime) {
 
     //LESS THAN MAX NUMBER ameobaNumberLimit
     // PLACE THEM ANYWHERE BUT THE TARGET WILL BE THE PERSON
      if ( ameobaEraticNumber < ameobaNumberLimit) {
       //println(" ADD ameoba PARTICLES");
           for (int i = 0; i < 1; i++) {         
               ameobaEraticNumber++;       
                 //println("ameobaEraticNumber =",ameobaEraticNumber);
           ameobavehicles.add(new AmeobaVehicle(random(width/2),random(height/2),1,oscParticlemaxspeed,  oscParticlemaxforce,oscRadius ));
           } // add erractic pixles
      }//counter for erratic
   } else {
     
     ameobaFlag=0;
   }
   
   
     
   //create ameoba particles
   //LESS THAN MAX NUMBER ameoba02NumberLimit
   // PLACE THEM ANYWHERE BUT THE TARGET WILL BE THE PERSON
   if (millis() < ameoba02Time) {
 
      if ( ameoba02EraticNumber < ameoba02NumberLimit) {
      // println(" ADD ameoba02 PARTICLES");
           for (int i = 0; i < 1; i++) {         
               ameoba02EraticNumber++;       
                 //println("ameoba02EraticNumber =",ameoba02EraticNumber);
           ameoba02vehicles.add(new Ameoba02Vehicle(random(width/2),random(height/2),1,oscParticlemaxspeed,  oscParticlemaxforce,oscRadius ));
           } // add erractic pixles
      }//counter for erratic
   } else {
     
     ameoba02Flag=0;
   }
   
   
   
   
   
   
   
   
   
   //erract time
   
   
   
   //create erractic particles
   // PLACE THEM ANYWHERE BUT THE TARGET WILL BE LISSAJOUS CURVE
   // THIS CREATES PARTICLES FOLLOWING A LISSAJOUS CURVE
   if (millis() < eraticTime) {
      if ( CountEraticNumber < eraticNumberLimit) {
      // println(" ADD ERACTIC PARTICLES");
           for (int i = 0; i < 1; i++) {         
               CountEraticNumber++;       
                 //println("CountEraticNumber =",CountEraticNumber);
           eraticvehicles.add(new EraticVehicle(random(width/2),random(height/2),1,oscParticlemaxspeed,  oscParticlemaxforce,oscRadius ));
           } // add erractic pixles
      }//counter for erratic
   }//erract time
  
  
  
 if ( CountBrightNumber < BrightNumberLimit) {
     for (int i = 0; i < 1; i++) {
         CountBrightNumber++;
          //println("CountBrightNumber =",CountBrightNumber);
          brightvehicles.add(new BrightVehicle(random(width/2),random(height/2),1,oscParticlemaxspeed,  oscParticlemaxforce,oscRadius ));
      } // add more bright pixles
  
       //delete a dark pixel
      if (darkvehicles.size() > 0) {
          darkvehicles.remove(0);
           CountDarkNumber--;
         // println("remove 1 dark vehicle ");
         // println("CountDarkNumber= ",CountDarkNumber);
       }//delete a dark value
   
  } // check  BRIGTH NUMBER limit
  
} // end acceleration add check
  
  
  
  //IF ANY AMEOBAS EXISTS DELETE ALL BRIGHT ONES
   if ( ( ameobaEraticNumber > 2) || ( ameoba02EraticNumber > 2) ) {
   println("DELETE BRIGHT PIXELS NOW");
      //delete bright pixels
      if (brightvehicles.size() >0) {
          //  println("1 white vehicle removed");
           
            CountBrightNumber--;
          //  println("CountBrightNumber =",CountBrightNumber);
            brightvehicles.remove(0);
       }// delete a white vehicle
       
    }//delete brightones if ameoabas exisst
   
  
  
  
  
  
  
  


 
 
  //ArrayList<Vehicle> vehicles;
 // for (Vehicle v : vehicles) {
    
   
 

  // DISPLAY  ALL BRIGHT PIXELS
  // CALC THE FORCE TO EITHER A TARGET PERSON OR A GESTURE POSITION
 for (int i = 0; i < brightvehicles.size()-1; i++) {
    // Create a temporary arraylist to hold values of each particle class
    BrightVehicle v = brightvehicles.get(i);
    if (oscCorners==0) v.applyBehaviors(brightvehicles,darkvehicles,int(oscFloatx1),int(oscFloaty1));
    if (oscCorners!=0) v.applyBehaviors(brightvehicles,darkvehicles,int(oscCornersx1),int(oscCornersy1));
    v.update();
    
    
    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {
      
      
    //  IF THE COLOUR TRIGGER IS ACTIVE CHANGE THE PARTICLE COLOR FOR 2 SECONDS
        if (millis() <  brightTime ) {
           // println("CHNAGECOL DISPLAY");
           //println("r=",v.r,"g=",v.g,"b=",v.b);
           // CALC THE FORCE TO EITHER A TARGET PERSON OR A GESTURE POSITION
          if (oscCorners==0) v.changecol(brightvehicles,int(oscFloatx1),int(oscFloaty1 ) );
           if (oscCorners!=0) v.changecol(brightvehicles,int(oscCornersx1),int(oscCornersy1 ) );
        } else  {
          // println("NORMAL DISPLAY");
          // println("r=",v.r,"g=",v.g,"b=",v.b);
          if (millis() <  brightTime+50 ) {
       //     println("RANDOMIZE COLOR");
         //v.r=random(255);
         // v.g=random(255);
         // v.b=random(255);
          }
         //   println("TIME NOW= ",millis(),"brightime= ",brightTime);
         // CHANGE COLOR OF PARTICLE BACK TO DEFUALT OFF WHITE CLOR
            v.display(brightTime);
        } // end if
      
    } // display all bright pixels

    
   
    
    
    
    
    
    
 // DISPLAY  ALL DARK PIXELS
 // CALC THE FORCE TO EITHER A TARGET PERSON OR A GESTURE POSITION
 for (int i = 0; i < darkvehicles.size()-1; i++) {
    // Create a temporary arraylist to hold values of each particle class
    DarkVehicle v = darkvehicles.get(i);
    
    if (oscCorners==0) v.applyBehaviors(darkvehicles,int(oscFloatx1),int(oscFloaty1));
    if (oscCorners!=0) v.applyBehaviors(darkvehicles,int(oscCornersx1),int(oscCornersy1));
    v.update();
   // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {
    v.display();
    } // display all bright pixels
  
  
  
  
  
  
  
 
 
 
  /// DISPLAY ERATIC VEHICLES
  
 for (int i = 0; i < eraticvehicles.size()-1; i++) {
    // Create a temporary arraylist to hold values of each particle class
    EraticVehicle e = eraticvehicles.get(i);
    
    //// CALC THE FORCE TO EITHER A TARGET PERSON OR A GESTURE POSITION
    if (oscCorners==0) e.applyBehaviors(eraticvehicles,darkvehicles,int(oscFloatx1),int(oscFloaty1));
     if (oscCorners!=0) e.applyBehaviors(eraticvehicles,darkvehicles,int(oscCornersx1),int(oscCornersy1));
    e.update();
    
    
    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {
    
        if (millis() <  brightTime ) {
        // println("CHNAGECOL DISPLAY");
     //println("r=",v.r,"g=",v.g,"b=",v.b);
         
         
        //  IF THE COLOUR TRIGGER IS ACTIVE CHANGE THE PARTICLE COLOR FOR 2 SECONDS
        if (oscCorners==0) e.changecol(eraticvehicles,int(oscFloatx1),int(oscFloaty1 ) );
        if (oscCorners!=0) e.changecol(eraticvehicles,int(oscCornersx1),int(oscCornersy1 ) );
        } else  {
        // println("NORMAL DISPLAY");
          // println("r=",v.r,"g=",v.g,"b=",v.b);
          if (millis() <  brightTime+50 ) {
       //     println("RANDOMIZE COLOR");
         //v.r=random(255);
         // v.g=random(255);
         // v.b=random(255);
          }
         //   println("TIME NOW= ",millis(),"brightime= ",brightTime);
            e.display(brightTime);
        } // end if
        
     
    } // display all eratic pixels
    
   
   
    
    
    
    
    
    
    
    /// DISPLAY AMEOBA VEHICLES
 for (int i = 0; i < ameobavehicles.size()-1; i++) {
    // Create a temporary arraylist to hold values of each particle class
    AmeobaVehicle e = ameobavehicles.get(i);
    //// CALC THE FORCE TO EITHER A TARGET PERSON OR A GESTURE POSITION
     if (oscCorners==0) e.applyBehaviors(ameobavehicles,darkvehicles,int(oscFloatx1),int(oscFloaty1));
     if (oscCorners!=0) e.applyBehaviors(ameobavehicles,darkvehicles,int(oscCornersx1),int(oscCornersy1));
    e.update();
    
    
    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {
        //  IF THE COLOUR TRIGGER IS ACTIVE CHANGE THE PARTICLE COLOR FOR 2 SECONDS
        if (millis() <  brightTime ) {
        // println("CHNAGECOL DISPLAY");
        //println("r=",v.r,"g=",v.g,"b=",v.b);
         
         
       
       if (oscCorners==0) e.changecol(ameobavehicles,int(oscFloatx1),int(oscFloaty1 ) );
       if (oscCorners!=0) e.changecol(ameobavehicles,int(oscCornersx1),int(oscCornersy1 ) );
        } else  {
          // println("NORMAL DISPLAY");
          // println("r=",v.r,"g=",v.g,"b=",v.b);
          if (millis() <  brightTime+50 ) {
          //     println("RANDOMIZE COLOR");
          //v.r=random(255);
          // v.g=random(255);
          // v.b=random(255);
          }
         //   println("TIME NOW= ",millis(),"brightime= ",brightTime);
         
         // CHANGE COLOR OF PARTICLE BACK TO DEFUALT OFF WHITE CLOR
            e.display(brightTime);
        } // end if
        
     
    } // display all AMEOBA PIXELS
    
    
    
    
    
    
    
    
    
    /// DISPLAY AMEOBA VEHICLES
 for (int i = 0; i < ameoba02vehicles.size()-1; i++) {
    // Create a temporary arraylist to hold values of each particle class
    Ameoba02Vehicle e = ameoba02vehicles.get(i);
    
    //// CALC THE FORCE TO EITHER A TARGET PERSON OR A GESTURE POSITION
    if (oscCorners==0) e.applyBehaviors(ameoba02vehicles,darkvehicles,int(oscFloatx1),int(oscFloaty1));
    if (oscCorners!=0) e.applyBehaviors(ameoba02vehicles,darkvehicles,int(oscCornersx1),int(oscCornersy1));
    e.update();
    
    
    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {
    //  IF THE COLOUR TRIGGER IS ACTIVE CHANGE THE PARTICLE COLOR FOR 2 SECONDS
        if (millis() <  brightTime ) {
        // println("CHNAGECOL DISPLAY");
     //println("r=",v.r,"g=",v.g,"b=",v.b);
         
        if (oscCorners==0) e.changecol(ameoba02vehicles,int(oscFloatx1),int(oscFloaty1 ) );
        if (oscCorners!=0) e.changecol(ameoba02vehicles,int(oscCornersx1),int(oscCornersy1 ) );
        } else  {
        // println("NORMAL DISPLAY");
          // println("r=",v.r,"g=",v.g,"b=",v.b);
          if (millis() <  brightTime+50 ) {
       //     println("RANDOMIZE COLOR");
         //v.r=random(255);
         // v.g=random(255);
         // v.b=random(255);
          }
         //   println("TIME NOW= ",millis(),"brightime= ",brightTime);
            e.display(brightTime);
        } // end if
        
     
    } // display all AMEOBA PIXELS
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

//colorMode(RGB, 0.5);

//fill(0,0,255);
//ellipse(avgX,avgY,64,64);

//fill(255);
//ellipse(rdx,rdy,32,32);

//fill(0,250,0,255);//176 221 238
//ellipse(width/2.0,height/2.0,200,200);
   //stroke(255);
   //strokeWeight(3);
   
// send data out in intervals
if ( millis()> oscTime) {
  oscTime=millis()+100;
  //RESEND ALL OUTPUTS TO MAXMSP: MORE EFFICIENT THQ 
  sendOscNames();

}//send data in packets

// delay a minute BEFORE SWITCHING DATA SETS
// FOR WEKINATOR

// EVERY MINUTE SWITCH DATA SETS BY THIS CLOCK
if (millis() > delayTime) {
  switchFlag=0;
  delayTime= millis() + 60000;
} else {
  switchFlag=1;
}
//change wekinator training data



 // SWITCH DATA SETS BASED ON THE CLOCK SENT FROM WEKINATOR
 // THE TIME COUNTS IN MINUTES: SWITCH EVERY MINUTE
 if(oscCountTime%2==0) {
   //ONLY CALL THIS DATA SET 1 TIME EVERY MINUTE
   if (millis() > delayTime09){
   println("09 selected switchFlag = ",switchFlag,"09 SWITCH TIME =",oscCountTime);
   sendOscWekchange09();  
   delayTime09=millis()+60000;
   }//delayTime09
  
 } //switchflag 1
  
   if(oscCountTime%2==1) {
    //ONLY CALL THIS DATA SET 1 TIME EVERY MINUTE
    if (millis() > delayTime08){
   println("08 selected switchFlag = ",switchFlag,"08 SWITCH TIME =",oscCountTime);
   sendOscWekchange08();  
   delayTime08=millis()+60000;
     }//delayTime08
  
 }//switchflag 1
   
 


}//end draw


void mouseDragged() {
  //brightvehicles.add(new BrightVehicle(mouseX,mouseY,1));
}



// OSC DATA
//This is called automatically when OSC message is received

// WEKINATOR INPUTS

//oscP5 = new OscP5(this,6021)


    //1  POSX:                0
    //2  POSY:                0
    //3  VEL:                 2.55
    //4  ACCEL:               4.9
    //5  TIME:                0
    //6  SIGNAL:              def 1 on 2
    //7  ACCEL_MAX:           2.34
    //8  ACCEL_STD_DEV:         1.5
    //9  POSX_STDDEV;            6.27
    //10  POSY_STSDEV:            6.16

    //11  CONDUCTOR_EVENTS:     1

    //12  CONDUCTOR_TIME:        0

    //13  GRAPHICS_TRIGGER:       0.02      > 5
    //14  color_TRIGGER:          1.216       > 25
    //15  PART_MAXSPEED:            0.06
    //16  PART_MAXFORCE:            -0.0001
    //17  MIXGRAPHICS:              2     
    // 18  oscCorners             0
    // 19 CORNER POS X
    // 20 CORNER POS Y
  
  
void oscEvent(OscMessage theOscMessage) {
  
  // WE CAN RECEIVE TRAINGING DATA FROM TWO TRAINING SETS
  // WEK_TRAIN08D AND WEK_TRAIN09C
  //
  //  /wek/outputs = WEK_TRAIN08D
  //  /wek/outputs02 = WEK_TRAIN09C
  //
   //if (theOscMessage.checkAddrPattern("/kinnect/inputs")==true) {
 if (theOscMessage.checkAddrPattern("/wek/outputs")==true) {
     if(theOscMessage.checkTypetag("ffffffffffffffffffff")) { // looking for 4 control value
        
        oscFloatx1 = map(theOscMessage.get(0).floatValue(),0,640,0,1920);
        oscFloaty1 = map(theOscMessage.get(1).floatValue(),0,480,0,1080);
        oscFloatvel1 =map(theOscMessage.get(2).floatValue(),2.55,100,0,100);
        oscFloataccel1 = map(theOscMessage.get(3).floatValue(),4.88,200,0,200);
        oscCountTime = int(map(theOscMessage.get(4).floatValue(),0,20,0,21));
        oscFloatSignal = int(map(theOscMessage.get(5).floatValue(),1,2,0,1));
        oscAccelMax = map(theOscMessage.get(6).floatValue(),7.736,200,0,300);
        // change radius based on acceleration
        oscRadius=map(oscFloataccel1,0,200,1,3);
        oscAccelStdDev = map(theOscMessage.get(7).floatValue(),0.3828,100,0,100);
        oscposXStdDev =  map(theOscMessage.get(8).floatValue(),2.69,200,0,200);
        oscposYStdDev = map(theOscMessage.get(9).floatValue(),-0.02,200,0,200);
        oscConductEvents = int(theOscMessage.get(10).floatValue());
        oscConductTime = map(theOscMessage.get(11).floatValue(),0,60000,10000,30000);
        oscGraphicsTrigger=map(theOscMessage.get(12).floatValue(),-0.0241,100,5,12);
        oscColourTrigger=map(theOscMessage.get(13).floatValue(),0.2166,50,8,12);
        oscParticlemaxspeed = map(theOscMessage.get(14).floatValue(),0.0243,100,0.8,18);
        oscParticlemaxforce = map(theOscMessage.get(15).floatValue(),0.00278,60,1,10);
        oscMixGraphics = int(theOscMessage.get(16).floatValue() );
        oscCorners = int(map(theOscMessage.get(17).floatValue(),1,5,0,4));
         oscCornersx1 = map(theOscMessage.get(18).floatValue(),0,640,0,1920);
        oscCornersy1 = map(theOscMessage.get(19).floatValue(),0,480,0,1080);
  //println("oscFloatx1= ",oscFloatx1,"oscFloaty1= ",oscFloaty1,"oscFloatvel1= ",oscFloatvel1,"oscFloataccel1= ",oscFloataccel1);
     } else {
        println("Error: unexpected OSC message received by Processing: ");
        theOscMessage.print();
      }
 } //CHECK checkAddrPattern /wek/outputs
 
 
 if (theOscMessage.checkAddrPattern("/wek/outputs02")==true) {
     if(theOscMessage.checkTypetag("ffffffffffffffffffff")) { // looking for 4 control value
        
        oscFloatx1 = map(theOscMessage.get(0).floatValue(),0,640,0,1920);
        oscFloaty1 = map(theOscMessage.get(1).floatValue(),0,480,0,1080);
        oscFloatvel1 =map(theOscMessage.get(2).floatValue(),2.55,100,0,100);
        oscFloataccel1 = map(theOscMessage.get(3).floatValue(),4.88,200,0,200);
        // change radius based on acceleration
       // oscRadius=map(oscFloataccel1,0,200,1,10);
        
         oscRadius=map(oscFloataccel1,0,100,1,15);
        oscCountTime = int(map(theOscMessage.get(4).floatValue(),0,20,0,21));
        oscFloatSignal = int(map(theOscMessage.get(5).floatValue(),1,2,0,1));
        oscAccelMax = map(theOscMessage.get(6).floatValue(),7.736,200,0,300);
        oscAccelStdDev = map(theOscMessage.get(7).floatValue(),0.3828,100,0,100);
        oscposXStdDev =  map(theOscMessage.get(8).floatValue(),2.69,200,0,200);
        oscposYStdDev = map(theOscMessage.get(9).floatValue(),-0.02,200,0,200);
        oscConductEvents = int(theOscMessage.get(10).floatValue());
        oscConductTime = map(theOscMessage.get(11).floatValue(),0,60000,10000,30000);
        oscGraphicsTrigger=map(theOscMessage.get(12).floatValue(),-0.09196,100,5,12);
        oscColourTrigger=map(theOscMessage.get(13).floatValue(),-0.00279,50,8,12);
        oscParticlemaxspeed = map(theOscMessage.get(14).floatValue(),-7.72153,100,0.8,18);
        oscParticlemaxforce = map(theOscMessage.get(15).floatValue(),-2.91144,60,1,10);
        //oscMixGraphics = int(theOscMessage.get(16).floatValue() );
         oscMixGraphics = int(map(theOscMessage.get(16).floatValue(),1,5,6,10));
        oscCorners = int(map(theOscMessage.get(17).floatValue(),1,5,0,4));
        oscCornersx1 = map(theOscMessage.get(18).floatValue(),0,640,0,1920);
        oscCornersy1 = map(theOscMessage.get(19).floatValue(),0,480,0,1080);
  //println("oscFloatx1= ",oscFloatx1,"oscFloaty1= ",oscFloaty1,"oscFloatvel1= ",oscFloatvel1,"oscFloataccel1= ",oscFloataccel1);
     } else {
        println("Error: unexpected OSC message received by Processing: ");
        theOscMessage.print();
      }
 } //CHECK checkAddrPattern /wek/outputs02
 
 
} // VOID OSC DO WE HAVE MESSAGES FROM WEK TEST 08







//Sends current parameter (hue) to Wekinator

//
//
//

void sendOscNames() {
//
//
//
// SEND THE WEKINATIOR DATA TO MAXMSP FROM HERE
//
//
  //OscMessage msg = new OscMessage("/wekinator/control/setOutputNames");
  OscMessage msg = new OscMessage("/wek/outputs");
  //msg.add("hue"); //Now send all 5 names
  msg.add(oscFloatx1);
  msg.add(oscFloaty1);
  msg.add(oscFloatvel1);
  msg.add(oscFloataccel1);
  msg.add(oscCountTime);
  msg.add(oscFloatSignal);
  //println("  -------------------------------"); 
  //println("oscFloatSignal=============>>>>>>>>> ",oscFloatSignal);
  //println("  -------------------------------"); 
  msg.add(oscAccelMax);
  msg.add(oscAccelStdDev);
  msg.add(oscposXStdDev);
  msg.add(oscposYStdDev);
  msg.add(oscConductEvents);
  msg.add(oscConductTime);
  //msg.add(oscGraphicsTrigger);
  //msg.add( oscColourTrigger);
  //msg.add(oscParticlemaxspeed);
  //msg.add(oscParticlemaxforce);
  //msg.add(oscMixGraphics);
  // msg.add(oscCorners);
  //  msg.add(oscCornersx1);
  //  msg.add(oscCornersy1);
    

 
  oscP5.send(msg, dest);
}



//................ CONTROL WEKINATOR

void sendOscWekchange09() {
//
//
//
//
// CALL THE TRAINING SET DATA:
// WEK_TRAIN09C
//
//
//
//
  println("09 CHANGE DATA SETS");
  println("oscCountTime = ",oscCountTime);

OscMessage msg = new OscMessage("/wekinator/control/runNewProject");
//Users/CH/Desktop/WEKINATORTEST03/WEK_TRAIN08cdiffport/WEK_TRAIN08cdiffport.wekproj
///Users/CH/Desktop/WEKINATORTEST03/WEK_TRAIN08D/WEK_TRAIN08D.wekproj
//msg.add("Users/CH/Desktop/WEKINATORTEST03/WEK_TRAIN08cdiffport/WEK_TRAIN08cdiffport.wekproj"); 
 //msg.add("/Users/CH/Desktop/WEKINATORTEST03/WEK_TRAIN08D/WEK_TRAIN08D.wekproj"); 
 msg.add("/Users/CH/Desktop/WEKINATORTEST03/WEK_TRAIN09C/WEK_TRAIN09C.wekproj"); 
 msg.add("STOPCURRENTLISTENING"); 
   oscP6.send(msg, dest_Wek);
  
}



void sendOscWekchange08() {
//
//
//
//
// CALL THE TRAINING SET DATA:
// WEK_TRAIN08D
//
//
//
//
  println("08 CHANGE DATA SETS");
  println("oscCountTime = ",oscCountTime);

OscMessage msg = new OscMessage("/wekinator/control/runNewProject");
//Users/CH/Desktop/WEKINATORTEST03/WEK_TRAIN08cdiffport/WEK_TRAIN08cdiffport.wekproj
///Users/CH/Desktop/WEKINATORTEST03/WEK_TRAIN08D/WEK_TRAIN08D.wekproj
//msg.add("Users/CH/Desktop/WEKINATORTEST03/WEK_TRAIN08cdiffport/WEK_TRAIN08cdiffport.wekproj"); 
 msg.add("/Users/CH/Desktop/WEKINATORTEST03/WEK_TRAIN08D/WEK_TRAIN08D.wekproj"); 
 //msg.add("/Users/CH/Desktop/WEKINATORTEST03/WEK_TRAIN09C/WEK_TRAIN09C.wekproj"); 
 msg.add("STOPCURRENTLISTENING"); 
   oscP6.send(msg, dest_Wek);
  
}