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
//   
//    receives ALL DATA INPUTS FROM KINECT RPESSONG PATCH ON PORT 6000 VIA OSC
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

  
   
















import oscP5.*; //<>//
import netP5.*;
OscP5 oscP5;
NetAddress dest;


import org.openkinect.freenect.*;
import org.openkinect.processing.*;


////// setup particles

// SET UP ARRAYLIST FOR SWARMS
ArrayList<BrightVehicle> brightvehicles;

// SET UP ARRAYLIST FOR SWARMS
ArrayList<DarkVehicle> darkvehicles;

// SET UP ARRAYLIST FOR SWARMS
ArrayList<EraticVehicle> eraticvehicles;

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
float  multWidth, multHeight;
int rhx;
int rhy;
int rdx;
int rdy;

//SETUP OSC VARIBALES
float oscFloatx1;
float oscFloaty1;
float oscFloatvel1;
float oscFloataccel1;
float oscCountTime;
float  oscFloatSignal;
int oscTime;

/// MAKE TRIGGER VARIABLES
float oscGraphicsTrigger;
float oscColourTrigger;
float oscParticlemaxspeed ;
float oscParticlemaxforce ;
int oscMixGraphics;
float oscAccelMax;
float oscAccelStdDev;
float oscposXStdDev;
float oscposYStdDev;
float oscConductEvents;
float oscConductTime;
float oscCorners;
float oscCornersx1;
float oscCornersy1;




// limit bright pixels
int BrightNumberLimit;
int CountBrightNumber;
int DarkNumberLimit;
int CountDarkNumber;
int brightTime;
int lerpTime;
int brightTimeInterval;

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


  //Initialize OSC communication
  oscP5 = new OscP5(this, 6000); //listen for OSC messages on port 12000 (Wekinator default)
  //oscP5 = new OscP5(this,6021); //listen for OSC messages on port 12000 (Wekinator default)

  dest = new NetAddress("127.0.0.1", 6022); //send messages back to Wekinator on port 6448, localhost (this machine) (default)

  // WHEN DO OTHER PARICLES GET TRIGGERED?

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

  background(0, 255);
  //get time clock in minutes
  eraticCounter=1;
  oscCountTime=0;
  brightTime= millis();
  brightTimeInterval=2000;
  eraticTime=0;
  anglecounter=0;
  ////// setup particles
  avgX=width/2;
  avgY=height/2;
  rdx =0;
  rdy = 0;
  rhx =0;
  rhy = 0;
  BrightNumberLimit= 200;
  DarkNumberLimit=500;
  eraticNumberLimit=400;
  CountEraticNumber=0;
  CountBrightNumber=0;
  CountDarkNumber=100;

  //MAKE A HUNDRED PATICKE SWARM 
  // We are now making random vehicles and storing them in an ArrayList
  brightvehicles = new ArrayList<BrightVehicle>();
  // We are now making random vehicles and storing them in an ArrayList
  darkvehicles = new ArrayList<DarkVehicle>();

  // We are now making random vehicles and storing them in an ArrayList
  eraticvehicles = new ArrayList<EraticVehicle>();

  // We are now making random vehicles and storing them in an ArrayList
  ameobavehicles = new ArrayList<AmeobaVehicle>();

  // We are now making random vehicles and storing them in an ArrayList
  ameoba02vehicles = new ArrayList<Ameoba02Vehicle>();




  //setup dark followers
  for (int i = 0; i < 100; i++) {
    darkvehicles.add(new DarkVehicle(random(width/2), random(height/2), 0, oscParticlemaxspeed, oscParticlemaxforce  ));
  }



  //size(screen.width, screen.height);
  //size(1920, 1080,P3D);
  size(1920, 1080,P3D);


  // full screen mode
  //fullScreen(P3D);
} //END SETUP






void draw() {
  //background(100);


  // CHECK OSCMIX GRAPHICS SETTING

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












  //  eractic movement angle increase by anglecounter
  anglecounter+=0.5;

  fill(0, 3);
  rect(0, 0, width, height);



  // if the person moves add a bright value CHECK VALUE oscGraphicsAppear
  if (oscFloataccel1 > oscGraphicsTrigger ) {


    // add color for 10 seconds CHECK VALUE oscColourTrigger
    if (oscFloataccel1 > oscColourTrigger ) { 
      eraticCounter++;
      ameobaCounter++;
      ameoba02Counter++;
      println(".............................");
      println("..........START COUNTERS...................");
      println("startEraticCounter=", startEraticCounter);
      println("startAmeobaCounter=", startAmeobaCounter);
      println(" startAmeoba02Counter=", startAmeoba02Counter);
      println(".............................");
      println(".............................");
      println("erraticCounter=", eraticCounter);
      println("erraticCounter=", eraticCounter);
      println(".............................");
      println(".............................");
      println("ameobaCounter=", ameobaCounter);
      println(".............................");
      println(".............................");
      println("oscMixGraphics=", oscMixGraphics);
      println("..............");

      //brighttime
      brightTime= millis() + brightTimeInterval;
      lerpTime= brightTime +1000;
    }/// ACCELERATION > 25

    //startEraticCounter=50;
    //startAmeobaCounter=100;
    //startAmeoba02Counter=150;


    //// create different particles
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
    if (millis() < ameobaTime) {

      if ( ameobaEraticNumber < ameobaNumberLimit) {
        //println(" ADD ameoba PARTICLES");
        for (int i = 0; i < 1; i++) {         
          ameobaEraticNumber++;       
          //println("ameobaEraticNumber =",ameobaEraticNumber);
          ameobavehicles.add(new AmeobaVehicle(random(width/2), random(height/2), 1, oscParticlemaxspeed, oscParticlemaxforce ));
        } // add erractic pixles
      }//counter for erratic
    } else {

      ameobaFlag=0;
    }



    //create ameoba particles
    if (millis() < ameoba02Time) {

      if ( ameoba02EraticNumber < ameoba02NumberLimit) {
        // println(" ADD ameoba02 PARTICLES");
        for (int i = 0; i < 1; i++) {         
          ameoba02EraticNumber++;       
          //println("ameoba02EraticNumber =",ameoba02EraticNumber);
          ameoba02vehicles.add(new Ameoba02Vehicle(random(width/2), random(height/2), 1, oscParticlemaxspeed, oscParticlemaxforce ));
        } // add erractic pixles
      }//counter for erratic
    } else {

      ameoba02Flag=0;
    }









    //erract time



    //create erractic particles
    if (millis() < eraticTime) {
      if ( CountEraticNumber < eraticNumberLimit) {
        // println(" ADD ERACTIC PARTICLES");
        for (int i = 0; i < 1; i++) {         
          CountEraticNumber++;       
          //println("CountEraticNumber =",CountEraticNumber);
          eraticvehicles.add(new EraticVehicle(random(width/2), random(height/2), 1, oscParticlemaxspeed, oscParticlemaxforce ));
        } // add erractic pixles
      }//counter for erratic
    }//erract time

    if ( CountBrightNumber < BrightNumberLimit) {
      for (int i = 0; i < 1; i++) {
        CountBrightNumber++;
        //println("CountBrightNumber =",CountBrightNumber);
        brightvehicles.add(new BrightVehicle(random(width/2), random(height/2), 1, oscParticlemaxspeed, oscParticlemaxforce ));
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



  //IF AMEOBA EXISTS DELETE BRIGHT ONES
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
  for (int i = 0; i < brightvehicles.size()-1; i++) {
    // Create a temporary arraylist to hold values of each particle class
    BrightVehicle v = brightvehicles.get(i);
    if (oscCorners==0) v.applyBehaviors(brightvehicles, darkvehicles, int(oscFloatx1), int(oscFloaty1));
    if (oscCorners!=0) v.applyBehaviors(brightvehicles, darkvehicles, int(oscCornersx1), int(oscCornersy1));
    v.update();


    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {

    if (millis() <  brightTime ) {
      // println("CHNAGECOL DISPLAY");
      //println("r=",v.r,"g=",v.g,"b=",v.b);

      if (oscCorners==0) v.changecol(brightvehicles, int(oscFloatx1), int(oscFloaty1 ) );
      if (oscCorners!=0) v.changecol(brightvehicles, int(oscCornersx1), int(oscCornersy1 ) );
    } else {
      // println("NORMAL DISPLAY");
      // println("r=",v.r,"g=",v.g,"b=",v.b);
      if (millis() <  brightTime+50 ) {
        //     println("RANDOMIZE COLOR");
        //v.r=random(255);
        // v.g=random(255);
        // v.b=random(255);
      }
      //   println("TIME NOW= ",millis(),"brightime= ",brightTime);
      v.display(brightTime);
    } // end if
  } // display all bright pixels









  // DISPLAY  ALL DARK PIXELS
  for (int i = 0; i < darkvehicles.size()-1; i++) {
    // Create a temporary arraylist to hold values of each particle class
    DarkVehicle v = darkvehicles.get(i);

    if (oscCorners==0) v.applyBehaviors(darkvehicles, int(oscFloatx1), int(oscFloaty1));
    if (oscCorners!=0) v.applyBehaviors(darkvehicles, int(oscCornersx1), int(oscCornersy1));
    v.update();
    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {
    v.display();
  } // display all bright pixels










  /// DISPLAY ERATIC VEHICLES
  for (int i = 0; i < eraticvehicles.size()-1; i++) {
    // Create a temporary arraylist to hold values of each particle class
    EraticVehicle e = eraticvehicles.get(i);

    if (oscCorners==0) e.applyBehaviors(eraticvehicles, darkvehicles, int(oscFloatx1), int(oscFloaty1));
    if (oscCorners!=0) e.applyBehaviors(eraticvehicles, darkvehicles, int(oscCornersx1), int(oscCornersy1));
    e.update();


    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {

    if (millis() <  brightTime ) {
      // println("CHNAGECOL DISPLAY");
      //println("r=",v.r,"g=",v.g,"b=",v.b);

      if (oscCorners==0) e.changecol(eraticvehicles, int(oscFloatx1), int(oscFloaty1 ) );
      if (oscCorners!=0) e.changecol(eraticvehicles, int(oscCornersx1), int(oscCornersy1 ) );
    } else {
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
    if (oscCorners==0) e.applyBehaviors(ameobavehicles, darkvehicles, int(oscFloatx1), int(oscFloaty1));
    if (oscCorners!=0) e.applyBehaviors(ameobavehicles, darkvehicles, int(oscCornersx1), int(oscCornersy1));
    e.update();


    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {

    if (millis() <  brightTime ) {
      // println("CHNAGECOL DISPLAY");
      //println("r=",v.r,"g=",v.g,"b=",v.b);

      if (oscCorners==0) e.changecol(ameobavehicles, int(oscFloatx1), int(oscFloaty1 ) );
      if (oscCorners!=0) e.changecol(ameobavehicles, int(oscCornersx1), int(oscCornersy1 ) );
    } else {
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









  /// DISPLAY AMEOBA VEHICLES
  for (int i = 0; i < ameoba02vehicles.size()-1; i++) {
    // Create a temporary arraylist to hold values of each particle class
    Ameoba02Vehicle e = ameoba02vehicles.get(i);
    if (oscCorners==0) e.applyBehaviors(ameoba02vehicles, darkvehicles, int(oscFloatx1), int(oscFloaty1));
    if (oscCorners!=0) e.applyBehaviors(ameoba02vehicles, darkvehicles, int(oscCornersx1), int(oscCornersy1));
    e.update();


    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {

    if (millis() <  brightTime ) {
      // println("CHNAGECOL DISPLAY");
      //println("r=",v.r,"g=",v.g,"b=",v.b);

      if (oscCorners==0) e.changecol(ameoba02vehicles, int(oscFloatx1), int(oscFloaty1 ) );
      if (oscCorners!=0) e.changecol(ameoba02vehicles, int(oscCornersx1), int(oscCornersy1 ) );
    } else {
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

  // send data out in intervals NOT USED
  if ( millis()> oscTime) {
    oscTime=millis()+100;
    //sendOscNames();
  }//send data in packets



  // do we have a signal?
}


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
// setup default osc Values
//oscGraphicsTrigger=5;
//oscColourTrigger=25;
//oscParticlemaxspeed = 1.0;
//oscParticlemaxforce = 1.0;
//oscMixGraphics=1;
//oscAccelMax=1;
//oscAccelStdDev=5;
//oscposXStdDev=5;
//oscposYStdDev=5;
//oscConductEvents=5;
//oscConductTime=30000;



void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("/kinnect/inputs")==true) {
    //if (theOscMessage.checkAddrPattern("/wek/outputs")==true) {
    if (theOscMessage.checkTypetag("fffffffff")) { // looking for 4 control value

      oscFloatx1 = map(theOscMessage.get(0).floatValue(), 0, 640, 0, 1920);
      oscFloaty1 = map(theOscMessage.get(1).floatValue(), 0, 480, 0, 1080);
      oscFloatvel1 =map(theOscMessage.get(2).floatValue(), 0, 100, 0, 100);
      oscFloataccel1 = map(theOscMessage.get(3).floatValue(), 0, 200, 0, 200);
      oscCountTime = int(map(theOscMessage.get(4).floatValue(), 0, 20, 0, 21));
      oscFloatSignal = int(map(theOscMessage.get(5).floatValue(), 0, 1, 0, 1));
      
      oscCorners = int(map(theOscMessage.get(6).floatValue(), 0, 4, 0, 4));
      oscCornersx1 = map(theOscMessage.get(7).floatValue(), 0, 640, 0, 1920);
      oscCornersy1 = map(theOscMessage.get(8).floatValue(), 0, 480, 0, 1080);
      
      oscAccelMax = max(oscFloatvel1, oscFloataccel1);
      oscAccelStdDev = max(oscFloatvel1, oscFloataccel1);
      oscposXStdDev =  max(oscFloatvel1, oscFloataccel1);
      oscposYStdDev = max(oscFloatvel1, oscFloataccel1);
      oscConductEvents = int(map(oscFloaty1, 0, 1920, 1, 10));
      oscConductTime = map(oscFloaty1, 0, 1080, 10000, 30000);
      oscGraphicsTrigger=map(oscAccelMax, 0, 200, 5, 12);
      oscColourTrigger=map(oscAccelMax, 0, 200, 8, 12);
      oscParticlemaxspeed = map(oscFloatx1, 0, 1920, 0.8, 18);
      oscParticlemaxforce = map(oscFloaty1, 0, 1080, 1, 10);
      oscMixGraphics = (int(theOscMessage.get(4).floatValue() )  % 6) +1;
      println("oscFloatx1= ",oscFloatx1,"oscFloaty1= ",oscFloaty1,"oscFloatvel1= ",oscFloatvel1,"oscFloataccel1= ",oscFloataccel1);
    } else {
      println("Error: unexpected OSC message received by Processing: ");
      theOscMessage.print();
    }
  }
}

//Sends current parameter (hue) to Wekinator
void sendOscNames() {
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