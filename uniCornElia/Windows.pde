class Window{
  float xPos, yPos; 
  int windowSize = int(height*.6); 
  int windowNum; 
  int n, s; 
  PImage windows[] = new PImage[4]; 
  Window(float _xPos, float _yPos, int _windowNum){
    xPos = _xPos; 
    yPos = _yPos; 
    windowNum = _windowNum; 
    for(int i = 0; i<4; i++){
      windows[i] = loadImage("window" + i + ".png"); 
      windows[i].resize(0, windowSize); 
    }
    n = floor(random(0,5)); 
    s = 32; 
  }
  
  void display(){
    image(windows[windowNum], xPos, yPos); 
    textSize(s); 
    textAlign(CENTER); 
    text(textArray[n][windowNum*2], xPos-250, yPos, 500, yPos); 
    windows[windowNum].resize(0, windowSize); 
  }
  
  void blur(){
    image(windows[windowNum], xPos, yPos);  
    windows[windowNum].filter(BLUR); 
  }
  
  void unBlur(){
    image(windows[windowNum], xPos, yPos);  
    windows[windowNum].filter(BLUR, 0); 
  }
  
  void shrink(){
    s --; 
    if(windowSize>= 20){
      windowSize -= 20;
    }   
  }
}