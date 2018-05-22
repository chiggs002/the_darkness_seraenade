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
//   THIS PATCH WAS PART OF A SWARM PATCH I MADE FOR A ART THEORY PAPER ON SWARMS
//   MOUSE INPUTS FOR THE INSTALLATION
//   SIMULATES KINECT LIVE DATA.
//
//
//   THIS PATCH USES THE KINECT INPUT FOR TESTING THE COMPLETE INSTALLATION
//
//   SENDS ALL OUTPUTS TO THE WEKINATOR HELPER ON PORT 6448
//
//   CALCULATES THE FOLLOWING  DATA TO SEND ON TO WEKINATOR HELPER:
//
//
//   oscFloatx1     - average position of person in x uses depth data
//   oscFloaty1     - average position of person in y uses depth data
//
//   oscFloatvel1   - average velocity of person detected
//   oscFloataccel1 - average acceleration of person detected
//   countMinutes   - count in minutes since simulation started
//   oscFloatSignal - Has kinect detected a person? yes 1 no 0
//   oscCorners     - Has kinect detected a any gestures? (0-no 1-2-3-4==n-s-w-e)
//   oscStretchx1   - if any gestures have been detected send x cord
//   oscStretchy1    - if any gestures have been detected send y cord
//
//
//
//   Sends out osc data on port 6448 on the local network
//   NetAddress("127.0.0.1",6448);
//
//
//
//    THE BULK OF THIS PATCH IS ABOUT THE KINECT DEPTH VALUES AND CALCUALTING
//    THE AVERAGE READING(0), THE TOP MOST READING(1), THE BOTTOM MOST READING(3)
//    THE LEFT MOST READING(4), THE RIGHT MOST READING(2)
//
//    IT THEN SENDS ALL THIS DATA TO WEKINATOR HELPER.
//

//
//   CHANGE DEPTH SETTINGS TO A SPECIFIC RANGE : float minThresh=200; float maxThresh=910
//
//
//
//
//
//
//     UPDATE OSC MESSAGE CALL TO THESE FILES 
//     ON WHERE U HAVE PLACED THEM ON YOUR COMPUTER:
//
//   "/Users/CH/Desktop/WEKINATORTEST03/WEK_TRAIN08D/WEK_TRAIN08D.wekproj"
//   “/Users/CH/Desktop/WEKINATORTEST03/WEK_TRAIN09C/WEK_TRAIN09C.wekproj”
//
//
//

  
   














// IMPORT OSC LIBRARIES
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest_Proc,dest_Max1,dest_Max2,dest_Max3,dest_Max4,dest_Max5,dest_WekHelp;



//KINECT LIBRARY
import org.openkinect.freenect.*;
import org.openkinect.processing.*;


////// setup particles

// SET UP ARRAYLIST FOR SWARMS
ArrayList<Vehicle> vehicles;






Kinect kinect;

// Angle for rotation
float a = 0;

float deg;

boolean ir = false;
boolean colorDepth = false;
boolean mirror = false;
PImage  img;
float minThresh=200;
float maxThresh=910;//890; //900-1000? when testing


// last depth

int rdx;
int rdy;
int lastrdx;
int lastrdy;
PVector veldepth;
PVector vellastdepth;
PVector accdepth;

// THE AVERAGE POSITION 
float  avgX;
float  avgY;
float  lastavgX;
float  lastavgY;
PVector velavg;
PVector vellastavg;
PVector accavg;
// THE THE HIGHEST POSITION 
int rhx;
int rhy;
int lastrhx;
int lastrhy;
PVector velhighest;
PVector vellasthighest;
PVector acchighest;
//  THE THE lowest POSITION 
int rlx;
int rly;
int lastrlx;
int lastrly;
int countMinutes;
PVector vellowest;
PVector vellastlowest;
PVector acclowest;
//  THE Left POSITION 
int rleftx;
int rlefty;
int lastrleftx;
int lastrlefty;
PVector velleft;
PVector vellastleft;
PVector accleft;
//  THE Right POSITION 
int rrightx;
int rrighty;
int lastrrightx;
int lastrrighty;
PVector velright;
PVector vellastright;
PVector accright;
// MOUSE value

PVector velMouse;
PVector vellastMouse;
PVector accMouse;

// left right centre
PVector leftPos, rightPos,centPos,bottomPos,topPos;

//SETUP OSC VARIBALES
float oscFloatx1;
float oscFloaty1;
float oscFloatvel1;
float oscFloataccel1;
float oscFloatSignal;
int detectSignalTime;
int detectSignal;
int detectNoSignalTime;
float oscStretchx1;
float oscStretchy1;
int oscCorners;

//didstanc from left to centr e and right to centre3
float distToLeft;
float distToRight;
float distToTop;
float distToBottom;




void setup() {
  // left right centre pos
  leftPos= new PVector(0, 0);
  rightPos = new PVector(0, 0);
  centPos = new PVector(0, 0);
  bottomPos = new PVector(0, 0);
  topPos = new PVector(0, 0);
  distToLeft=0;
  distToRight=0;
  distToTop = 0;
   distToBottom = 0;
  
  // do we have a signal? NO
  detectSignal=0;
  detectNoSignalTime=0;
  detectSignalTime=0;
  /// system clock
  countMinutes=0;
  //////  SETUP OSC MESSAGES
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,9000);
  // processing destination
  dest_Proc = new NetAddress("127.0.0.1",6000);
  //// Max destination
  dest_Max1 = new NetAddress("127.0.0.1",6001);
  dest_Max2 = new NetAddress("127.0.0.1",6002);
  dest_Max3 = new NetAddress("127.0.0.1",6003);
  dest_Max4 = new NetAddress("127.0.0.1",6004);
  dest_Max5= new NetAddress("127.0.0.1",6005);
  dest_WekHelp= new NetAddress("127.0.0.1",6448);
  
  
   // osc values
  oscStretchx1=0;
  oscStretchy1=0;
  oscCorners=0;
  oscFloatx1 = 0;
  oscFloaty1 = 0;
  oscFloatvel1 =0;
  oscFloataccel1 = 0;
  oscFloatSignal=0;
  
// THE DEPTH POSITION
   rdx=0;
   rdy=0;
   lastrdx=0;
   lastrdy=0;
   veldepth= new PVector(0,0);
   vellastdepth= new PVector(0,0);
   accdepth= new PVector(0,0);

// THE AVERAGE POSITION 
  avgX=width/2;
  avgY=height/2;
  lastavgX=0;
  lastavgY=0;
  velavg= new PVector(0,0);
  vellastavg= new PVector(0,0);
  accavg= new PVector(0,0);
// THE THE HIGHEST POSITION 
   rhx=0;
   rhy=0;
   lastrhx=0;
   lastrhy=0;
   velhighest=new PVector(0,0);
   vellasthighest=new PVector(0,0);
   acchighest=new PVector(0,0);
//  THE THE lowest POSITION 
   rlx=0;
   rly=0;
   lastrlx=0;
   lastrly=0;
    vellowest=new PVector(0,0);
    vellastlowest=new PVector(0,0);
    acclowest=new PVector(0,0);
//  THE Left POSITION 
   rleftx=0;
   rlefty=0;
   lastrleftx=0;
   lastrlefty=0;
   velleft=new PVector(0,0);
   vellastleft=new PVector(0,0);
   accleft=new PVector(0,0);
   //  THE Right POSITION 
   rrightx=0;
   rrighty=0;
   lastrrightx=0;
   lastrrighty=0;
   velright=new PVector(0,0);
   vellastright=new PVector(0,0);
   accright=new PVector(0,0);
   
   // mouse velocities
   velMouse=new PVector(0,0);
   vellastMouse=new PVector(0,0);
   accMouse=new PVector(0,0);

   
  
  //MAKE A HUNDRED PATICKE SWARM 
  // We are now making random vehicles and storing them in an ArrayList
  vehicles = new ArrayList<Vehicle>();
  for (int i = 0; i < 100; i++) {
    vehicles.add(new Vehicle(random(width),random(height)));
  }
  
  
  // 640 480
  //size(1280, 520);
  size(640, 480,P3D);
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.initVideo();
  //kinect.enableIR(ir);
  kinect.enableColorDepth(colorDepth);
  img=createImage(kinect.width,kinect.height,RGB);
 
  deg = kinect.getTilt();
  // kinect.tilt(deg);
}

void draw() {
  // count minutes integer units.
  countMinutes=int(millis()/60000);
  //println("countMinutes= ",countMinutes);
  background(0);
  
  pushMatrix();
// translate(kinect.width,0);
// scale(-1,1);
  
  
   img.loadPixels();
  // minThresh=map(mouseX,0,width,0,2000);
   //maxThresh=map(mouseY,0,height,0,2000);
  // println("minThresh= ",minThresh,"maxThresh= ",maxThresh);

// depth image

PImage dImg=kinect.getDepthImage();

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();
  
  int recordDepth=2300;
  
  
  int recordHeight=kinect.height;
  
  int recordLeft =kinect.width;
  int recordRight =0;
  int recordLowest=0;
  
 

   float sumX=0;
   float sumY=0;
   float totalPixels=0;
   
   
   // SET ALL PREVIOUS VALUES
   lastrdx=rdx;
   lastrdy=rdy;
   lastavgX=avgX;
   lastavgY=avgY;
   lastrhx=rhx;
   lastrhy=rhy;
   lastrlx=rlx;
   lastrly=rly;
   lastrleftx=rleftx;
   lastrlefty=rlefty;
   lastrrightx=rrightx;
   lastrrighty=rrighty;
  
 
   // set all previuos velocities
   
   vellastdepth =  veldepth;
   vellastavg = velavg;
   vellasthighest = velhighest;
   vellastlowest=vellowest;
   vellastleft=velleft;
   vellastright= velright;
   vellastMouse=velMouse;
 // println("OLD  vellastMouse=", vellastMouse.mag());
   //println("OLD  vellastMouse=", (vellastMouse.normalize().x+vellastMouse.normalize().y+vellastMouse.normalize().z)* vellastMouse.mag());
   
 

  

  for (int x = 0; x < kinect.width; x++) {
    for (int y = 0; y < kinect.height; y++) {
      int offset = x + y * kinect.width;
      int d = depth[offset];
      
      //println("d= ",d);
      

      // RECORD ALLDEPTH VALUES WITHIN THE THRESHOLD
      
      if (d > minThresh && d < maxThresh) {
       //IF WE FOUND A DEPTH READING OF VALUE COLOR IT PINK INTO A AN ARRAY LIST
      img.pixels[offset]=color(250,0,150);
      
      //seta a record of depth closet?
      //RECORD THE DEPTH VALUES AND THERE POSITIONS
      if (d < recordDepth) {
        recordDepth=d;
        rdx=x;
        rdy=y;
       
        //CalculateVelocity( int currx,int curry,int lastx, int lasty)
        //CalculateAcceleration(PVector currvel, PVector lastvel)
        veldepth= CalculateVelocity(rdx,rdy,lastrdx,lastrdy);
        accdepth= CalculateAcceleration(veldepth,vellastdepth);

      }
      
      
      //seta a record of highest height : top of thinger
      if (y < recordHeight) {
        recordHeight=y;
        rhx=x;
        rhy=y;
        topPos.set(rhx,rhy);
        
        //CalculateVelocity( int currx,int curry,int lastx, int lasty)
        //CalculateAcceleration(PVector currvel, PVector lastvel)
        //vellasthighest = velhighest;
        velhighest= CalculateVelocity(rhx,rhy,lastrhx, lastrhy);
        acchighest= CalculateAcceleration(velhighest,vellasthighest);
        
      }
      
      // SET RECORD LOWEST HEIGHT
      if (y > recordLowest) {
        recordLowest=y;
        rlx=x;
        rly=y;
        bottomPos.set(rlx,rly);
      
         //CalculateVelocity( int currx,int curry,int lastx, int lasty)
        //CalculateAcceleration(PVector currvel, PVector lastvel)
        vellowest= CalculateVelocity( rlx,rhy,lastrlx,lastrly);
        acclowest= CalculateAcceleration(vellowest,vellastlowest);
        
      }
      
       // SET RECORD most right side
      if (x < recordLeft) {
        recordLeft=x;
        rleftx=x;
        rlefty=y;
        leftPos.set(rleftx,rlefty);
         //CalculateVelocity( int currx,int curry,int lastx, int lasty)
        //CalculateAcceleration(PVector currvel, PVector lastvel)
        velleft= CalculateVelocity( rleftx,rlefty,lastrleftx,lastrlefty);
        acclowest= CalculateAcceleration(vellowest,vellastlowest);
         }
         
          // SET RECORD most left side
      if (x >  recordRight) {
         recordRight=x;
       
        rrightx=x;
        rrighty=y;
         rightPos.set( rrightx,rrighty);
         //CalculateVelocity( int currx,int curry,int lastx, int lasty)
        //CalculateAcceleration(PVector currvel, PVector lastvel)
         velright= CalculateVelocity( rrightx,rrighty,lastrrightx,lastrrighty);
         accright= CalculateAcceleration(velright,vellastright);
         }
      
     // importnat pixels
     sumX += x;
     sumY += y;
     totalPixels++;

      } else {
         img.pixels[offset]=color(0,0,0);
         //img.pixels[offset]=dImg.pixels[offset];
      }
     
    }
  }
 
 
 
 img.updatePixels();
image(img,0,0);

// AVERAGE POSITION OF DEPTH VALUES
 avgX=sumX/ totalPixels;
 avgY=sumY/ totalPixels;
 centPos.set(avgX,avgY);
  //CalculateVelocity( int currx,int curry,int lastx, int lasty)
   //CalculateAcceleration(PVector currvel, PVector lastvel)
 velavg= CalculateVelocity( int(avgX),int(avgY),int(lastavgX),int(lastavgY));
 accavg= CalculateAcceleration(velavg,vellastavg);
 
 // mouse velocites and aceeleartion
  //CalculateVelocity( int currx,int curry,int lastx, int lasty)
   //CalculateAcceleration(PVector currvel, PVector lastvel)
   
 velMouse= CalculateVelocity( mouseX,mouseY,pmouseX,pmouseY);
 accMouse= CalculateAcceleration(velMouse,vellastMouse);
 //println("mouseX-pmouseX= ",mouseX-pmouseX,"mouseY-pmouseY= ",mouseY-pmouseY);
// println("NEW  velMouse=", velMouse.mag());
// println("NEW  accMouse=", accMouse.mag());
 

// update particles
 //ps.addParticle(avgX,avgY);
 
 
 ////TRACK THE SWARM OF PARTICLES TO THE MOUSE POSITION.
 
  for (Vehicle v : vehicles) {
    // Path following and separation are worked on in this function
  // v.applyBehaviors(vehicles,int(avgX),int(avgY));
   
   // Track kinect highest point data
   //v.applyBehaviors(vehicles,rhx,rhy);
   
    v.applyBehaviors(vehicles,width-mouseX,mouseY);
   
    //println("avgX= ",int(avgX),"avgY= ",int(avgY));
    
    //println("mouseX= ",mouseX,"mouseY= ",mouseY);
   
    // Call the generic run method (update, borders, display, etc.)
    v.update();
   v.changecol(vehicles,rhx,rhy);
   
  //v.display();
    
  }
  
  
  
 // CALCUATE THE DISTANCE TO THE CENTRE FROM THE EXTREMES DEPTH READINGS
 // LEFT/RIGHT/TOP AND BOTTOM
 
 
 //leftPos= new PVector(0, 0);
 // rightPos = new PVector(0, 0);
 // centPos = new PVector(0, 0);
 // bottomPos = new PVector(0, 0);
 // topPos = new PVector(0, 0);
 
 // CALC THE DISTANCE (FLOAT VALUE) TO THE EXTREMES VECTORS USING VECTOR MATH
  distToTop = centPos.dist(topPos);
  distToBottom = centPos.dist(bottomPos);
  distToRight = centPos.dist(rightPos);
  distToLeft = centPos.dist(leftPos);
// println("distToTop==== ", distToTop,"distToBottom==== ", distToBottom,"distToLeft==== ", distToLeft,"distToRight==== ", distToRight);  



/////oscStretchx1=0;
//  oscStretchy1=0;
//  oscCorners=0;


// GO THRU AND DECIDE WHICH EXTREME READING IS THE BIGGEST.
if (  distToTop > distToBottom )  {
      oscCorners=1; 
      oscStretchx1=topPos.x;
      oscStretchy1=topPos.y;
     if ( distToRight > distToTop ) {
         oscCorners=2;
         oscStretchx1=rightPos.x;
         oscStretchy1=rightPos.y;
         if ( distToLeft > distToRight ) {
            oscCorners=4;
            oscStretchx1=leftPos.x;
            oscStretchy1=leftPos.y;
         }// distToRight
     }// distToLeft
   
} else  {
   oscStretchx1=bottomPos.x;
   oscStretchy1=bottomPos.y;
   oscCorners=3; 
   if ( distToRight > distToBottom ) {
         oscCorners=2;
         oscStretchx1=rightPos.x;
         oscStretchy1=rightPos.y;
         if ( distToLeft > distToRight ) {
            oscCorners=4;
            oscStretchx1=leftPos.x;
            oscStretchy1=leftPos.y;
         }// distToRight
     }// distToLeft
   
}///distToTop > distToBottom 


// ONLY SELECT A GESTURE IF THE DIATNCE DETECTED IS GREATER THEN 150 PIXELS.
if ( (distToTop <150) && (distToBottom <150) && (distToRight <150) && (distToLeft <150) ) {
  oscCorners=0;
  oscStretchx1=centPos.x;
  oscStretchy1=centPos.y;
}//reset osccorners to zero

println("OSCCORNERS====  ",oscCorners,"oscStretchx1====   ",oscStretchx1,"oscStretchY1====",oscStretchy1);

colorMode(RGB, 0.5);


// USE PRIMIATVE OBJECT TO DEFINE THE MOST IMPORANT FEATURES
fill(0,0,255);
ellipse(avgX,avgY,64,64);

fill(255);
//ellipse(rdx,rdy,32,32);


//top
//bottomPos.set(rlx,rly);
fill(255,255,0);
ellipse(topPos.x,topPos.y,32,32);

fill(255,255,0);
ellipse(bottomPos.x,bottomPos.y,32,32);

// right and left pos
// left right centre
//PVector leftPos, rightPos,centpos;

//draw left marker and right marker
fill(0,255,0);
rect(leftPos.x,leftPos.y,60,60);
fill(0,255,0);
rect(rightPos.x,rightPos.y,60,60);
//print("leftpos= ",leftPos);
//print("rightpos= ",leftPos);
//fill(255);
//textSize(14);
//text("minThresh= " + minThresh + "maxThresh= "+ maxThresh,10,64);
 
 
 popMatrix();
 
//Send the OSC message 
//   oscFloatx1     - average position of person in x uses depth data
//   oscFloaty1     - average position of person in y uses depth data
//
//   oscFloatvel1   - average velocity of person detected
//   oscFloataccel1 - average acceleration of person detected
//   countMinutes   - count in minutes since simulation started
//   oscFloatSignal - Has kinect detected a person? yes 1 no 0
//   oscCorners     - Has kinect detected a any gestures? (0-no 1-2-3-4==n-s-w-e)
//   oscStretchx1   - if any gestures have been detected send x cord
//   oscStretchy1    - if any gestures have been detected send y cord
//
//
//
//   Sends out osc data on port 6448 on the local network
//   NetAddress("127.0.0.1",6448);
//
  sendOsc();
 
}// end draw


void mouseDragged() {
  vehicles.add(new Vehicle(mouseX,mouseY));
}



PVector CalculateVelocity( int currx,int curry,int lastx, int lasty) {
  PVector d =  new PVector(currx-lastx,curry- lasty);
 //println("d=",d);
  return d;
  }
  
  
  
  PVector CalculateAcceleration(PVector currvel, PVector lastvel) {
   PVector accel= PVector.sub(currvel, lastvel);
   //currvel.sub(lastvel);
  return accel;
  }
  
  
  /// SET UP OSC MESSAGES
  void sendOsc() {
//    SETUP THE OSC MESSAGE
//
//   oscFloatx1     - average position of person in x uses depth data
//   oscFloaty1     - average position of person in y uses depth data
//
//   oscFloatvel1   - average velocity of person detected
//   oscFloataccel1 - average acceleration of person detected
//   countMinutes   - count in minutes since simulation started
//   oscFloatSignal - Has kinect detected a person? yes 1 no 0
//   oscCorners     - Has kinect detected a any gestures? (0-no 1-2-3-4==n-s-w-e)
//   oscStretchx1   - if any gestures have been detected send x cord
//   oscStretchy1    - if any gestures have been detected send y cord
//
//
//
//   Sends out osc data on port 6448 on the local network
//   NetAddress("127.0.0.1",6448);  
    
    
    
    
    
// send mouse values to osc
//oscFloatx1 = mouseX;
//oscFloatx1 = mouseX;
//oscFloaty1 = mouseY;
//oscFloatvel1 =velMouse.mag();
//oscFloataccel1 = accMouse.mag();
  
  
  
  
  
 
  
 //DO WE HAVE A SIGNAL?
 
 
// int detectSignalTime;
// int detectSignal
 // send the kinnect values to osc
    // println ("  oscFloatSignal================= ", oscFloatSignal);
     println ("  oscFloatSignal================= ", oscFloatSignal);  
  // println("no signal millis===   ", millis(),"detectNoSignalTime=   ",detectNoSignalTime);
   // println("avgX= ", avgX,"avgY= ", avgY);
   // IF AFTER TEN SECONDS SIGNAL IS BAD SEND OSC DATA
   if ( millis() < detectNoSignalTime) {
     
     
      
      if (Float.isNaN(avgX)) {
        println("send signal NO");
       oscFloatSignal=0; 
      }//SIGNAL YES OR NO?
   }//no signaltime
 
 
 

   if (Float.isNaN(avgX) ) {
      println( "NO SIGNAL");
      
      if ( millis() > detectNoSignalTime+2000) {
     
         detectNoSignalTime= millis() + 10000;
         detectSignal=0;
      }//>detectSignalTime
      
   } else if (!Float.isNaN(avgX) ) {
      println( "YES SIGNAL");
      
      if ( millis() > detectSignalTime) {
     
         detectSignalTime= millis() + 10000;
         detectSignal=1;
      }//>detectSignalTime
      
   }// do we have a signal?


// check for 10 seonds if we have a signal
  if ( millis() < detectSignalTime) {
  
     if (detectSignal==1) {
        if ( avgX >= 0 || avgX <= kinect.width) {
           println("send signal YES");
           oscFloatSignal=1;
        } else {
         //  println("send signal NO");
           oscFloatSignal=0;
        }// CHECK AVERAGE
     } // we have avg values
  
  }// check for 10 seconds
  
  
 
 // kinnect average 
 //oscFloatx1 = kinect.width - avgX;
 oscFloatx1 = avgX;
 oscFloaty1 =  avgY;
 oscFloatvel1 =velavg.mag();
 oscFloataccel1 = accavg.mag();
  
   
       
       
  // kinnect highest 
 // oscFloatx1 = kinect.width -  rhx;
 // oscFloaty1 =   rhy;
 // oscFloatvel1 =velhighest.mag();
 // oscFloataccel1 = acchighest.mag();
  
  //println( "oscFloatx1= ",oscFloatx1,"oscFloaty1=",oscFloaty1,"oscFloatvel1= ",oscFloatvel1,"oscFloataccel1= ",oscFloataccel1);
  
  
  //inputs to processing and max
  OscMessage msg = new OscMessage("/kinnect/inputs");
  
  //inputs to processing and max
 // OscMessage msg = new OscMessage("/wek/inputs");
  // mouse inputs
  
  
  
  
  
  
  // OUTPUT ALL DATA VALUES VIA OSC
  
  
  
  msg.add((float)oscFloatx1); 
  msg.add((float)oscFloaty1); 
  msg.add((float)oscFloatvel1);
  msg.add((float)oscFloataccel1);
   msg.add((float)countMinutes);
   //oscFloatSignal=0;
    msg.add((float)oscFloatSignal);
  
    msg.add((float)oscCorners);
    msg.add((float)oscStretchx1);
    msg.add((float)oscStretchy1);
   
 
  //send processing messae
  //oscP5.send(msg, dest_Proc);
  ////send max message 01
  //oscP5.send(msg, dest_Max1);
  //oscP5.send(msg, dest_Max2);
  // oscP5.send(msg, dest_Max3);
  //  oscP5.send(msg, dest_Max4);
  //   oscP5.send(msg, dest_Max5);
      oscP5.send(msg, dest_WekHelp);
}