import oscP5.*; //<>// //<>//
import netP5.*;
OscP5 oscP5;
NetAddress dest,dest_Max1,dest_Max2,dest_Max3,dest_Max4,dest_Max5,dest_Max6,dest_Max7;


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
float oscCountTime;
float  oscFloatSignal;

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
//oscP5 = new OscP5(this,6000); //listen for OSC messages on port 12000 (Wekinator default)
oscP5 = new OscP5(this,6021); //listen for OSC messages on port 12000 (Wekinator default)
  
  dest = new NetAddress("127.0.0.1",6022); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
   
  dest_Max1 = new NetAddress("127.0.0.1",6023);
  dest_Max2 = new NetAddress("127.0.0.1",6024);
   dest_Max3 = new NetAddress("127.0.0.1",6025);
   dest_Max4 = new NetAddress("127.0.0.1",6026);
  // dest_Max5 = new NetAddress("127.0.0.1",6027);
  // dest_Max6 = new NetAddress("127.0.0.1",6028);
  // dest_Max7 = new NetAddress("127.0.0.1",6029);
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
  
  background(0,255);
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
    darkvehicles.add(new DarkVehicle(random(width/2),random(height/2),0,oscParticlemaxspeed,  oscParticlemaxforce  ));
  }
  
 
  
  //size(screen.width, screen.height);
//size(1920, 1080,P3D);
size(1920, 1080,P3D);
//size(1920, 1080,FX2D);

 
 
   // full screen mode
// fullScreen(P3D);
 
} //END SETUP






void draw() {
  //background(100);
  
  
  // CHECK OSCMIX GRAPHICS SETTING
  
  if (oscMixGraphics == 1) {
    
    startEraticCounter=50;
    startAmeobaCounter=100;
    startAmeoba02Counter=150;
    
  } else if (oscMixGraphics == 2) {
     startEraticCounter=50;
    startAmeobaCounter=90;
    startAmeoba02Counter=1000;
    
  } else if (oscMixGraphics == 3) {
      startEraticCounter=30;
    startAmeobaCounter=50;
    startAmeoba02Counter=70;
    
   } else if (oscMixGraphics == 4) {
      startEraticCounter=30;
    startAmeobaCounter=50;
    startAmeoba02Counter=70;
    
  } else if (oscMixGraphics == 5) {
      startEraticCounter=30;
    startAmeobaCounter=50;
    startAmeoba02Counter=70;
    
  } 
  
  
  
  
  
  
  
  
  
  
  
  
//  eractic movement angle increase by anglecounter
anglecounter+=0.5;

fill(0,3);
rect(0,0,width,height);
 


// if the person moves add a bright value CHECK VALUE oscGraphicsAppear
if (oscFloataccel1 > oscGraphicsTrigger ) {
  
  
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
     println("erraticCounter=",eraticCounter);
     println(".............................");
      println(".............................");
     println("ameobaCounter=",ameobaCounter);
     println(".............................");
      println(".............................");
      println("oscMixGraphics=",oscMixGraphics);
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
           ameobavehicles.add(new AmeobaVehicle(random(width/2),random(height/2),1,oscParticlemaxspeed,  oscParticlemaxforce ));
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
           ameoba02vehicles.add(new Ameoba02Vehicle(random(width/2),random(height/2),1,oscParticlemaxspeed,  oscParticlemaxforce ));
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
           eraticvehicles.add(new EraticVehicle(random(width/2),random(height/2),1,oscParticlemaxspeed,  oscParticlemaxforce ));
           } // add erractic pixles
      }//counter for erratic
   }//erract time
  
 if ( CountBrightNumber < BrightNumberLimit) {
     for (int i = 0; i < 1; i++) {
         CountBrightNumber++;
          //println("CountBrightNumber =",CountBrightNumber);
          brightvehicles.add(new BrightVehicle(random(width/2),random(height/2),1,oscParticlemaxspeed,  oscParticlemaxforce ));
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
    if (oscCorners==0) v.applyBehaviors(brightvehicles,darkvehicles,int(oscFloatx1),int(oscFloaty1));
    if (oscCorners!=0) v.applyBehaviors(brightvehicles,darkvehicles,int(oscCornersx1),int(oscCornersy1));
    v.update();
    
    
    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {
    
        if (millis() <  brightTime ) {
        // println("CHNAGECOL DISPLAY");
     //println("r=",v.r,"g=",v.g,"b=",v.b);
         
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
            v.display(brightTime);
        } // end if
      
    } // display all bright pixels

    
   
    
    
    
    
    
    
     // DISPLAY  ALL DARK PIXELS
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
    
    if (oscCorners==0) e.applyBehaviors(eraticvehicles,darkvehicles,int(oscFloatx1),int(oscFloaty1));
     if (oscCorners!=0) e.applyBehaviors(eraticvehicles,darkvehicles,int(oscCornersx1),int(oscCornersy1));
    e.update();
    
    
    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {
    
        if (millis() <  brightTime ) {
        // println("CHNAGECOL DISPLAY");
     //println("r=",v.r,"g=",v.g,"b=",v.b);
         
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
     if (oscCorners==0) e.applyBehaviors(ameobavehicles,darkvehicles,int(oscFloatx1),int(oscFloaty1));
     if (oscCorners!=0) e.applyBehaviors(ameobavehicles,darkvehicles,int(oscCornersx1),int(oscCornersy1));
    e.update();
    
    
    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {
    
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
            e.display(brightTime);
        } // end if
        
     
    } // display all AMEOBA PIXELS
    
    
    
    
    
    
    
    
    
    /// DISPLAY AMEOBA VEHICLES
 for (int i = 0; i < ameoba02vehicles.size()-1; i++) {
    // Create a temporary arraylist to hold values of each particle class
    Ameoba02Vehicle e = ameoba02vehicles.get(i);
    if (oscCorners==0) e.applyBehaviors(ameoba02vehicles,darkvehicles,int(oscFloatx1),int(oscFloaty1));
    if (oscCorners!=0) e.applyBehaviors(ameoba02vehicles,darkvehicles,int(oscCornersx1),int(oscCornersy1));
    e.update();
    
    
    // v.changecol(brightvehicles,width-int(oscFloatx1),int(oscFloaty1 ) {
    
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
   

sendOscNames();



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
  
   //if (theOscMessage.checkAddrPattern("/kinnect/inputs")==true) {
 if (theOscMessage.checkAddrPattern("/wek/outputs")==true) {
     if(theOscMessage.checkTypetag("ffffffffffffffffffff")) { // looking for 4 control value
        
        oscFloatx1 = map(theOscMessage.get(0).floatValue(),0,640,0,1920);
        oscFloaty1 = map(theOscMessage.get(1).floatValue(),0,480,0,1080);
        oscFloatvel1 =map(theOscMessage.get(2).floatValue(),2.55,100,0,100);
        oscFloataccel1 = map(theOscMessage.get(3).floatValue(),4.88,200,0,200);
        oscCountTime = int(map(theOscMessage.get(4).floatValue(),0,20,0,21));
        oscFloatSignal = int(map(theOscMessage.get(5).floatValue(),1,2,0,1));
        oscAccelMax = map(theOscMessage.get(6).floatValue(),7.736,200,0,200);
        oscAccelStdDev = map(theOscMessage.get(7).floatValue(),0.3828,100,0,100);
        oscposXStdDev =  map(theOscMessage.get(8).floatValue(),2.69,200,0,200);
        oscposYStdDev = map(theOscMessage.get(9).floatValue(),-0.02,200,0,200);
        oscConductEvents = int(theOscMessage.get(10).floatValue());
        oscConductTime = map(theOscMessage.get(11).floatValue(),0,60000,30000,65000);
        oscGraphicsTrigger=map(theOscMessage.get(12).floatValue(),-0.0241,100,5,12);
        oscColourTrigger=map(theOscMessage.get(13).floatValue(),0.2166,50,8,12);
        oscParticlemaxspeed = map(theOscMessage.get(14).floatValue(),0.0243,100,0.8,30);
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
  msg.add(oscGraphicsTrigger);
  msg.add( oscColourTrigger);
  msg.add(oscParticlemaxspeed);
  msg.add(oscParticlemaxforce);
  msg.add(oscMixGraphics);
   msg.add(oscCorners);
    msg.add(oscCornersx1);
    msg.add(oscCornersy1);
    

 
  oscP5.send(msg, dest);
  //   oscP5.send(msg, dest_Max1);
  //oscP5.send(msg, dest_Max2);
  //oscP5.send(msg, dest_Max3);
  //oscP5.send(msg, dest_Max4);
  //oscP5.send(msg, dest_Max5);
  //oscP5.send(msg, dest_Max6);
  //oscP5.send(msg, dest_Max7);
}