int buttons[8];  
int pins[] = {13, 12, 11, 10, 9, 8, 7, 6}; 

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
  }
    Serial.println(); 
}
