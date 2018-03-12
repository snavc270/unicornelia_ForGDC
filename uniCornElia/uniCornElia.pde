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
int state = 9; 
int pulse;
PImage bgImage, feelingsDiagram;

ArrayList <Window> windows[] = new ArrayList[4]; 
//ArrayList <Window> windows = new ArrayList<Window>(); 

int startTime; 
int timer; 

int tNum = 5; 
Window [] tutorialWindows = new Window[6]; 

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
  feelingsDiagram = loadImage("tent-05.png"); 
  feelingsDiagram.resize(0, int(height*.45));
  
  startTime = millis(); 
  
  for(int i = 0; i<4; i++){
    interval[i] = int(random(30,50)); 
    windows[i] = new ArrayList<Window>();
  }
  tutorialWindows[0] = new Window(random(width*.65, width*.75), random(height*.65, height*.75), 3);  
  tutorialWindows[1] = new Window (width*.8, height*.3, 1); 
  tutorialWindows[2] = new Window(width*.2, random(height*.65, height*.75), 2);  
  tutorialWindows[3] = new Window(random(width*.65, width*.75), random(height*.65, height*.75), 3);
}
void movieEvent(Movie m) {
  m.read();
}
void draw(){

  if(state == 0){
     intro(); 
     for(int i = 0; i<4; i++){
       if(windowButtons[i] == 0 || feelButtons[i] == 0){
          state = 1; 
          timerRestart(); 
       }
     }
  }
  else if (state == 1){
     background(0); 
     timeChange(2, int(width*.33), int(height*.4), 0); 
  }
  else if (state == 2){
     timeChange(3, int(width*.05), int(height*.1), 1); 
  }
  else if (state == 3){
    timeChange(3, int(width*.05), int(height*.1), 2); 
  }
  
  else if (state == 4){
 ////////////////////////////////////////////////////////////////ADD IN TUTORIAL GRAPHICS//////////////////////////////////////////////   
    displayTutorialText(int(width*.05),int(height*.1), 3);
    tutorialWindows[0].display();
    
     ////////////////////////////////////////////////////////////////UNCOMMENT FOR TESTING//////////////////////////////////////////////   
    //if(windowButtons[3] == 0){
    //  state = 5; 
    //}
    if(keyPressed){
      state = 5; 
    }
  }
  else if (state == 5){
    displayTutorialText(int(width*.05),int(height*.1), 4);
    if(keyPressed){
      state = 6; 
    }
     ////////////////////////////////////////////////////////////////UNCOMMENT FOR TESTING//////////////////////////////////////////////   
    //if(windowButtons[1] != 1){
    //  tutorialWindows[1].display();
    //}
    //if(windowButtons[2] != 1){
    //  tutorialWindows[2].display();
    //}
  }
  else if (state == 6){
    timeChange(3, int(width*.05), int(height*.1), 5); 
  }
  else if (state == 7){
  ////////////////////////////////////////////////////////////////add animation//////////////////////////////////////////////   
     
    timeChange(3, int(width*.05), int(height*.1), 6); 
    image(feelingsDiagram, width/2, height/2);
  }
  else if (state == 8){
    displayTutorialText(int(width*.05),int(height*.1), 7);
    image(feelingsDiagram, width*.2, height*.75);
    tutorialWindows[3].display();
////////////////////////////////////////////////////////////////UNCOMMENT FOR TESTING//////////////////////////////////////////////     
    //if(feelButtons[3] == 0){
    //  tutorialWindows[3].shrink();
    //}
    if(keyPressed){
      tutorialWindows[3].shrink();
    }
    if(tutorialWindows[3].windowSize < 100){
      state = 9; 
    }
  }
  else if (state == 9){
    background(0); 
    timeChange(5, int(width*.22), int(height*.45), 8); 
  }
  
  //gamePlay 
  else if(state == 10){
     timer = ((millis() - startTime)/1000)/60; 
     println(timer); 
     image(bgImage, width*.5, height*.5, width, height); 

     windowFunctions(random(width*.15, width*.25),random(height*.15, height*.25), 0); 
     windowFunctions(random(width*.65, width*.75), random(height*.15, height*.25), 1); 
     windowFunctions(random(width*.15, width*.25), random(height*.65, height*.75), 2);
     windowFunctions(random(width*.65, width*.75), random(height*.65, height*.75), 3); 
     if(timer>=3){
       state = 11; 
     }
  }else if(state == 11){
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
    if(state>=6){
      if(frameCount % interval[section] == 0){
        windows[section].add(new Window(xPos, yPos, section)); 
      }
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

void barGraph(){
  ///////map this to score 
  for(int i = 0; i<4; i++){
    rect(100+i*200, 100, 100, 300); 
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