class Window{
  float xPos, yPos; 
  int windowSize = int(height*.6); 
  int windowNum; 
  int s; //text size  
  PImage windows[] = new PImage[4]; 
  
  Window(float _xPos, float _yPos, int _windowNum){
    xPos = _xPos; 
    yPos = _yPos; 
    windowNum = _windowNum; 
    for(int i = 0; i<4; i++){
      windows[i] = loadImage("window" + i + ".png"); 
      windows[i].resize(0, windowSize); 
    }

    //n = floor(random(0,5)); 
    //text size
    s = 32; 
    //probGoodvBad(); 
  }
  
  void display(){
    image(windows[windowNum], xPos, yPos); 
    textSize(s); 
    fill(255); 
    textAlign(CENTER); 
    text(textArray[windowNum*2+g[windowNum]][n[windowNum*2+g[windowNum]]], xPos-250, yPos, 500, yPos); 
    windows[windowNum].resize(0, windowSize); 
  }
  
  void pop(){
    pop.play(); 
    pop.rewind(); 
    windowSize = 50; 
    if(g[windowNum] == 0 && range<.9){
      range += .1; 
      n[windowNum*2+g[windowNum]] ++; 
      score[windowNum] ++; 
    }else if (g[windowNum] == 1 && range>= .2){
      range -= .1; 
      score[windowNum] --; 
      n[windowNum*2+g[windowNum]] ++; 
    }
  }
  void shrink(){
    s --; 
     shrink.play();
     shrink.rewind(); 
    if(windowSize>= 50){
      windowSize -= 50;
    } 
    if(windowSize <= 100){
      if(g[windowNum] == 0 && range>= .2){
        range -= .1; 
        score[windowNum] --; 
        n[windowNum*2+g[windowNum]] ++; 
      }
      
      if(g[windowNum] == 1 && range < .9){
        range += .1; 
        score[windowNum] ++; 
        n[windowNum*2+g[windowNum]] ++; 
      }
    }
  }
}