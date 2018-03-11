String tText [] = {"YOU ARE UNICORNELIA.", "Some tasks are essential to maintaining your sparkle",
"Tasks are sorted into four areas of your life. Insert your horn into the corresponding color hole to complete a task.", 
"Keep up with your tasks!", "Think twice about some tasks before completing.", "Trust your gut!", 
"To ignore a task, maintaing your corresponding feelings!", "KEEP EVERYTHING FROM FALLING APART"}; 

void dispayTutorialText(xPos, yPos, int n){
  text(tText[n], xPos, yPos); 
}