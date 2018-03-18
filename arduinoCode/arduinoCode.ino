int buttons[8];  
int lastButtonState[8];
boolean buttonClicked[8]; 
int pins[] = {13, 12, 11, 10, 8, 7, 9, 6}; 

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600); 
  for(int i = 0; i< 8; i++){
    pinMode(pins[i], INPUT_PULLUP); 
    
  }
}

void loop() {
  // put your main code here, to run repeatedly:
  for(int i = 0; i<8; i++){
    buttons[i] = digitalRead(pins[i]); 
    Serial.print(buttons[i]); 
    Serial.print(",");
//    Serial.print(buttonClicked[i]); 
//    Serial.print(",");
//
//    if(buttons[i] != lastButtonState[i]){
//      buttonClicked[i] = true; 
//    }else{
//      buttonClicked[i] = false; 
//    }
//    lastButtonState[i] = buttons[i]; 
  }
    Serial.println(); 

    
}
