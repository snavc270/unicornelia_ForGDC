Table table; 
int numRows, numCols; 
int storyNum = 15; 
int love = storyNum;
int work = storyNum*2; 
int general = storyNum*3; 
int family = storyNum*4; 


String [] lPositive, lNegative; 
String [] fPositive, fNegative; 
String [] wPositive, wNegative; 
String [] gPositive, gNegative;

String[][] textArray; 

void importTextData(){
  table = loadTable("narrativeTextTest.csv"); 
  
  numRows = table.getRowCount(); 
  numCols = table.getColumnCount();
  
  textArray = new String[numCols][numRows]; 
  
  for(int i = 0; i<numRows; i++){
    for(int j = 0; j<numCols; j++){
      textArray[j][i] = table.getString(i, j); 
      //println(textArray[j][i]); 
    }
  }
}