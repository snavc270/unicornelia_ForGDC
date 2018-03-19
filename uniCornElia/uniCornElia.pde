import processing.serial.*;
import processing.video.*;

int windowButtons[] = new int[4]; 
int lastWindowButtons[] = new int[4]; 
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
AudioPlayer introSong, gamePlay, shrink, pop; 
int interval[] = new int[4]; 
int state = 0; 
int pulse;
PImage bgImage, feelingsDiagram;
PImage horn, pannel, hand; 

ArrayList <Window> windows[] = new ArrayList[4]; 
ArrayList<Firework> fireworks;
PVector gravity = new PVector(0, 0.2);

int startTime; 
int timer; 
boolean button1Pressed = false;
boolean button2Pressed = false; 

int tNum = 5; 
Window [] tutorialWindows = new Window[6]; 

//storyline indexer 
int n [] = new int[8]; 

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
  introSong.loop(); 
  
  gamePlay = minim.loadFile("data/test.wav"); 
  gamePlay.loop(); 
  //gamePlay.rewind(); 
  
  shrink = minim.loadFile("data/shrink.mp3"); 
  pop = minim.loadFile("data/taskCompleted.mp3"); 
  
  font = createFont("8-BitMadness.ttf", 60); 
  textFont(font); 
  
  port = new Serial(this, Serial.list()[1], 9600); 
  port.bufferUntil('\n');

  bgImage = loadImage("bgImage.png"); 
  feelingsDiagram = loadImage("tent-05.png");
  horn = loadImage("horn.png"); 
  horn.resize(0, int(height*.3));
  
  pannel = loadImage("colorPannel.png"); 
  pannel.resize(0, int(height*.25));
  
  hand = loadImage("hand.png"); 
  hand.resize(0, int(height*.15));
  
  feelingsDiagram.resize(0, int(height*.45));
  
  startTime = millis(); 
  
  for(int i = 0; i<4; i++){
    interval[i] = int(random(5, 5+i*5)); 
    windows[i] = new ArrayList<Window>();
  }
  
  for(int i = 0; i<n.length; i++){
    n[i] = 0; 
  }
  
  fireworks = new ArrayList<Firework>();
  
  tutorialWindows[0] = new Window(random(width*.65, width*.75), random(height*.65, height*.75), 3);  
  tutorialWindows[1] = new Window (width*.8, height*.3, 1); 
  tutorialWindows[2] = new Window(width*.2, random(height*.65, height*.75), 2);  
  tutorialWindows[3] = new Window(random(width*.65, width*.75), random(height*.65, height*.75), 3);
}
void movieEvent(Movie m) {
  m.read();
}

void draw(){
  float increment; 
  increment = sin(frameCount/3)*30;
  
  if(state == 0){
     intro(); 
     if(keyPressed){
       state = 1; 
     }
     //for(int i = 0; i<4; i++){
     //  if(windowButtons[i] == 0 || feelButtons[i] == 0){
     //     state = 1; 
     //     timerRestart(); 
     //  }
     //}
  }
  else if (state == 1){
     background(0); 
     timeChange(2, int(width*.2), int(height*.4), 0); 
  }
  else if (state == 2){
     timeChange(3, int(width*.2), int(height*.4), 1); 
  }
  else if (state == 3){
    timeChange(3, int(width*.2), int(height*.4), 2); 
  }
  
  else if (state == 4){
    displayTutorialText(int(width*.05),int(height*.1), 3);
    tutorialWindows[0].display();
    image(pannel, width*.3, height*.45);  
    image(horn, width*.32 + increment, height*.56 - increment); 
   
     ////////////////////////////////////////////////////////////////UNCOMMENT FOR TESTING//////////////////////////////////////////////   
    //if(windowButtons[3] ==0){
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
    //if(windowButtons[1] ==0){
    //  button1Pressed = true; 
    //}
    //if(!button1Pressed){
    //  tutorialWindows[1].display();
    //}
    //if(windowButtons[2] == 0){
    //  button2Pressed = true; 
    //}
    //if(!button2Pressed){
    //  tutorialWindows[2].display();
    //}
    
    //if(button1Pressed && button2Pressed){
    //  state = 6; 
    //}
  }
  else if (state == 6){
    button1Pressed = false; 
    button2Pressed = false; 
    timeChange(10, int(width*.05), int(height*.1), 5); 
  }
  else if (state == 7){
    timeChange(3, int(width*.05), int(height*.1), 6); 
    image(feelingsDiagram, width/2, height/2);
  }
  //minimize task 
  else if (state == 8){
    displayTutorialText(int(width*.05),int(height*.1), 7);
    image(feelingsDiagram, width*.25, height*.65);
    image(hand, width*.32, height*.85 - increment); 
    tutorialWindows[3].display();
////////////////////////////////////////////////////////////////UNCOMMENT FOR TESTING//////////////////////////////////////////////     
    //if(feelButtons[3] == 1){
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
     introSong.pause();
     introSong.rewind(); 
     gamePlay.play(); 

     timer = ((millis() - startTime)/1000)/60; 
     image(bgImage, width*.5, height*.5, width, height); 

     windowFunctions(random(width*.15, width*.25),random(height*.15, height*.25), 0); 
     windowFunctions(random(width*.65, width*.75), random(height*.15, height*.25), 1); 
     windowFunctions(random(width*.15, width*.25), random(height*.65, height*.75), 2);
     windowFunctions(random(width*.65, width*.75), random(height*.65, height*.75), 3); 
     if(timer>=2){
       state = 11; 
     }
  }else if(state == 11){
    background(0); 
    introSong.play();  
    gamePlay.pause(); 
    gamePlay.rewind(); 
    
    text("its over", width/2, height/2);
    
    timer = ((millis() - startTime)/1000); 
    if(timer>= 1){
      restart(); 
    }
    //barGraph(); 
  }
  
  fireWorks(); 
  for(int i = 0; i<n.length; i++){
    if(n[i] >15){
      n[i] = 0; 
    } 
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
  introSong.play(); 
  gamePlay.pause(); 
  pulse = int(sin(frameCount/4)*1.5); 
  textSize(52 + pulse); 
  text("insert horn to start", width*.37-pulse, height*.95); 
}

void restart(){
  state = 0; 
  for(int i = 0; i<4; i++){
    score[i] = 0; 
  }
  for(int i = 0; i<8; i++){
    n[i] = 0; 
  }
  range = .5; 
}

float range = .5; //range for probability of good v bad 
int g[] = new int[4]; //good or bad boolean 
void probGoodvBad(int section){
  float r = random(0, 1); 
  if(r < range){
    g[section] = 0; //good task 
  }else{
    g[section] = 1; //bad task 
  }
  //println(g[section]); 
}

int range1 = 50; 
int range2 = 60; 
void windowFunctions(float xPos, float yPos, int section){
    if(state==10){
      if(frameCount % interval[section] == 0){
        windows[section].add(new Window(xPos, yPos, section)); 
        probGoodvBad(section); 
        if(range1>4 && range2>4){
          range1 --; 
          range2 --; 
        }
        for(int i = 0; i<4; i++){
          interval[i] = int(random(range1, range2)); 
        }
      }
    }
    
    for (int i = 0; i < windows[section].size(); i++) {
      Window w = windows[section].get(i);

      if(w.windowSize<100){
        fireworks.add(new Firework(w.xPos, w.yPos)); 
        windows[section].remove(i); 
      }
      if(windows[section].size()>0){
        Window lastW = windows[section].get(windows[section].size()-1); 
        
        
////////////////////////////////////////////////////////////////UNCOMMENT FOR TESTING//////////////////////////////////////////////   
        //if(feelButtons[section] == 0){
        //    lastW.shrink();
        //}
        //if(windowButtons[section] == 0){
        //    lastW.pop(); 
        //  //windows[section].remove(windows[section].size()-1); 
        //}
        
        if(keyPressed){
          if(key == 'b'){
            lastW.shrink();
          }
        }
        if(keyPressed){
          if(key == 'a'){
            lastW.pop(); 
          } 
        }
      }
      w.display();
   }
}

void fireWorks(){
  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.run();
    if (f.done()) {
      fireworks.remove(i);
    }
  }
  
}
int score [] = new int [4];
void barGraph(){
  ///////map this to score 
  score[0] = n[0] - n[1]; 
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
        lastWindowButtons[i] = windowButtons[i]; 
      }
    }
   
  }
}