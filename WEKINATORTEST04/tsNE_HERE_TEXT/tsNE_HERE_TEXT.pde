void setup() {
  size(800,800);
}

void draw() {
  background(0);
  
 
 pushStyle();
//println("signal value =====  ",oscFloatSignal);
fill(255);
textSize(32);
text("TO SWITCH ON ", width/2-80, height/2); 
text("STAND HERE ", width/2-60, height/2+40); 
noFill();
stroke(255);
strokeWeight(6);
ellipse(width/2+40,height/2,332,332);

//Fill();
popStyle();

}