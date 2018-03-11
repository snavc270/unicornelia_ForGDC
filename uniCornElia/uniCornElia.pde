import processing.serial.*;
import processing.video.*;

int windowButtons[] = new int[4]; 
int feelButtons[] = new int[4]; 
 
Serial port; 
Movie introLoop; 
PFont font; 

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim; 
AudioPlayer introSong; 
int interval[] = new int[4]; 
int state = 0; 
int pulse;
PImage bgImage; 
ArrayList <Window> windows[] = new ArrayList[4]; 
//ArrayList <Window> windows = new ArrayList<Window>(); 

int startTime; 
int timer; 
void setup(){
  println(Serial.list()); 
  //size(800, 800); 
  fullScreen(); 
  imageMode(CENTER); 
  introLoop = new Movie(this, "/Users/courtney/Desktop/uniCornElia_allCode/uniCornElia/data/introFinal.mp4"); 
  introLoop.play(); 
  introLoop.loop(); 
  
  importTextData(); 
  
  minim = new Minim(this);
  introSong = minim.loadFile("data/introMusic.mp3");
  //introSong.loop(); 
  
  font = createFont("8-BitMadness.ttf", 60); 
  textFont(font); 
  
  port = new Serial(this, Serial.list()[1], 9600); 
  port.bufferUntil('\n');

  bgImage = loadImage("bgImage.png"); 
  
  startTime = millis(); 
  
  for(int i = 0; i<4; i++){
    interval[i] = int(random(30,50)); 
    windows[i] = new ArrayList<Window>();
  }
}
void movieEvent(Movie m) {
  m.read();
}
void draw(){

  //state 0 
  if(state == 0){
     intro(); 
     for(int i = 0; i<4; i++){
       if(feelButtons[i] == 0){
          state = 1; 
       }
     }

  //gamePlay 
  }else if(state == 1){
     //tutorial();
     timer = ((millis() - startTime)/1000)/60; 
     println(timer); 
     image(bgImage, width*.5, height*.5, width, height); 
     windowFunctions(random(width*.15, width*.25),random(height*.15, height*.25), 0); 
     windowFunctions(random(width*.65, width*.75), random(height*.15, height*.25), 1); 
     windowFunctions(random(width*.15, width*.25), random(height*.65, height*.75), 2);
     windowFunctions(random(width*.65, width*.75), random(height*.65, height*.75), 3); 
     if(timer>=3){
       state = 2; 
     }
  }else if(state == 2){
    background(0); 
    text("its over", width/2, height/2);
    barGraph(); 
  }
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == RETURN){
      restart(); 
    }
  }
}

void barGraph(){
  ///////map this to score 
  for(int i = 0; i<4; i++){
    rect(100+i*200, 100, 100, 300); 
  }
}

void intro(){
  image(introLoop, width*.5, height*.5, width, height); 
  introLoop.play(); 
  //introSong.play(); 
  
  pulse = int(sin(frameCount/4)*1.5); 
  textSize(52 + pulse); 
  text("insert horn to start", width*.37-pulse, height*.95); 
}

void restart(){
  state = 0; 
}
void windowFunctions(float xPos, float yPos, int section){
     if(frameCount % interval[section] == 0){
       windows[section].add(new Window(xPos, yPos, section)); 
     }

    for (int i = 0; i < windows[section].size(); i++) {
      Window w = windows[section].get(i);
      if(i < windows[section].size()-1){
        w.blur(); 
      }else{
        w.unBlur();
      }
      if(w.windowSize<100){
        windows[section].remove(i); 
      }
      if(windows[section].size()>0){
        if(feelButtons[section] == 0){
          Window lastW = windows[section].get(windows[section].size()-1); 
          lastW.shrink();
        }
        if(windowButtons[section] == 0){
          windows[section].remove(windows[section].size()-1); 
        }
      }
      w.display();
   }
}

void serialEvent(Serial port) {
  String inString = port.readStringUntil('\n'); 

  if (inString != null) {
    inString = trim(inString);

    int[] allButtons = int(split(inString, ',')); 

    if (allButtons.length == 9) {
      for(int i = 0; i<4; i++){
        //println(allButtons[i]); 
        windowButtons[i] = allButtons[i+4]; 
        feelButtons[i] = allButtons[i]; 
      }
    }
  }
}