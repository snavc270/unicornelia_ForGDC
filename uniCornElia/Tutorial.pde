String tText [] = {"YOU ARE UNICORNELIA.", "Completing tasks is essential to maintaining your sparkle.",
"Tasks are sorted into four areas of your life.", "Insert your horn into the corresponding color hole to complete a task.", 
"Keep up with your tasks!", "Think twice about some tasks before completing.", "Trust your gut!", 
"To ignore a task, maintain your corresponding feelings!", "KEEP EVERYTHING FROM FALLING APART!"}; 
 
void displayTutorialText(int xPos, int yPos, int n){
  if(state>= 2 && state<9){
    image(bgImage, width/2, height/2, width, height);
  }
  noStroke(); 
  fill(0); 
  rect(xPos, yPos-25, width*.6, 150); 
  fill(255); 
  textSize(52); 
  textAlign(CENTER);
  text(tText[n], xPos, yPos, width*.6, 200); 
}
int stateTime; 
int stateStartTime;

void timerRestart(){
  stateStartTime = millis()/1000; 
}

void timeChange(int timer, int xPos, int yPos, int n){
    stateTime = millis()/1000 - stateStartTime; 
    displayTutorialText(xPos, yPos, n);
    if(stateTime > timer){
      state ++; 
      stateStartTime = millis()/1000;
      startTime = millis(); 
    }  
}