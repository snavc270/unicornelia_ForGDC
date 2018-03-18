class Window{
  float xPos, yPos; 
  int windowSize = int(height*.6); 
  int windowNum; 
  int s; //text size
  int n [] = new int[8]; 
  int g; //good or bad boolean 
  float range = .5; //range for probability of good v bad 
  
  PImage windows[] = new PImage[4]; 
  Window(float _xPos, float _yPos, int _windowNum){
    xPos = _xPos; 
    yPos = _yPos; 
    windowNum = _windowNum; 
    for(int i = 0; i<4; i++){
      windows[i] = loadImage("window" + i + ".png"); 
      windows[i].resize(0, windowSize); 
    }
    for(int i = 0; i<n.length; i++){
      n[i] = 0; 
    }
    //n = floor(random(0,5)); 
    //text size
    s = 32; 
  }
  
  void display(){
    image(windows[windowNum], xPos, yPos); 
    textSize(s); 
    textAlign(CENTER); 
    text(textArray[n[windowNum*g]][windowNum*g], xPos-250, yPos, 500, yPos); 
    windows[windowNum].resize(0, windowSize); 
  }
  
  
  //void blur(){
  //  image(windows[windowNum], xPos, yPos);  
  //  windows[windowNum].filter(BLUR); 
  //}
  
  //void unBlur(){
  //  image(windows[windowNum], xPos, yPos);  
  //  windows[windowNum].filter(BLUR, 0); 
  //}
  
  void probGoodvBad(){
    float r = random(0, 1); 
    if(r < range){
      g = 0; //good task 
    }else{
      g = 1; //bad task 
    }
  }
  
  void pop(){
    windowSize = 0; 
    if(g == 0){
      range += .1; 
      n[windowNum*g] ++; 
    }else if (g == 1){
      range -= .1; 
      n[windowNum*g] ++; 
    }
  }
  void shrink(){
    s --; 
    if(windowSize>= 50){
      windowSize -= 50;
    }
    
    //if my task is good 
    //increase bad task probability 
    //increase my good n indexer 
    
    //if my task is bad
    //increase good task probability    
    if(windowSize == 100){
      if(g == 0 && range>= .1){
        range -= .1; 
        n[windowNum*g] ++; 
      }
      
      if(g == 1 && range < 1){
        range += .1; 
        n[windowNum*g] ++; 
      }
    }
  }
}