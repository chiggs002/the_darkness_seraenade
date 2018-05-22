// IMPORT OSC LIBRARIES //<>//
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest_Proc,dest_Max1,dest_Max2,dest_Max3,dest_Max4,dest_Max5;



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
float maxThresh=850; //900-1000? when testing


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

//SETUP OSC VARIBALES
float oscFloatx1;
float oscFloaty1;
float oscFloatvel1;
float oscFloataccel1;
float oscFloatSignal;
int detectSignalTime;
int detectSignal;
int detectNoSignalTime;




void setup() {
  
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
  
   // osc values
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
  println("countMinutes= ",countMinutes);
  background(0);
  
  pushMatrix();
 translate(kinect.width,0);
 scale(-1,1);
  
  
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
   
   
   // SET ALL PREVIUS VALUES
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
 ////TRACK THE SWARM
 
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
  
 
  

colorMode(RGB, 0.5);

fill(150,0,255);
ellipse(avgX,avgY,64,64);

fill(255);
//ellipse(rdx,rdy,32,32);

fill(255,0,0);
ellipse(rhx,rhy,32,32);



//fill(255);
//textSize(14);
//text("minThresh= " + minThresh + "maxThresh= "+ maxThresh,10,64);
 
 
 popMatrix();
 
 //Send the OSC message with box current position
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
// send mouse values to osc
//oscFloatx1 = mouseX;
oscFloatx1 = mouseX;
oscFloaty1 = mouseY;
oscFloatvel1 =velMouse.mag();
oscFloataccel1 = accMouse.mag();
  
  
  
  
  
 
  
 //DO WE HAVE A SIGNAL?
// int detectSignalTime;
// int detectSignal
 // send the kinnect values to osc
    // println ("  oscFloatSignal================= ", oscFloatSignal);
     println ("  oscFloatSignal================= ", oscFloatSignal);  
   println("no signal millis===   ", millis(),"detectNoSignalTime=   ",detectNoSignalTime);
    println("avgX= ", avgX,"avgY= ", avgY);
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
 // oscFloatx1 = kinect.width - avgX;
//  oscFloaty1 =  avgY;
 // oscFloatvel1 =velavg.mag();
 // oscFloataccel1 = accavg.mag();
  
   
       
       
  // kinnect highest 
 // oscFloatx1 = kinect.width -  rhx;
 // oscFloaty1 =   rhy;
 // oscFloatvel1 =velhighest.mag();
 // oscFloataccel1 = acchighest.mag();
  
  println( "oscFloatx1= ",oscFloatx1,"oscFloaty1=",oscFloaty1,"oscFloatvel1= ",oscFloatvel1,"oscFloataccel1= ",oscFloataccel1);
  
  OscMessage msg = new OscMessage("/kinnect/inputs");
  // mouse inputs
  msg.add((float)oscFloatx1); 
  msg.add((float)oscFloaty1); 
  msg.add((float)oscFloatvel1);
  msg.add((float)oscFloataccel1);
   msg.add((float)countMinutes);
   //oscFloatSignal=0;
    msg.add((float)oscFloatSignal);
  //send processing messae
  oscP5.send(msg, dest_Proc);
  //send max message 01
  oscP5.send(msg, dest_Max1);
  oscP5.send(msg, dest_Max2);
   oscP5.send(msg, dest_Max3);
    oscP5.send(msg, dest_Max4);
     oscP5.send(msg, dest_Max5);
}
