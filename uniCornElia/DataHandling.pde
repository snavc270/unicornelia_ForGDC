Table table; 
int numRows, numCols; 
int love = 5;
int work = 10; 
int general = 15; 
int family = 20; 


String [] lPositive, lNegative; 
String [] fPositive, fNegative; 
String [] wPositive, wNegative; 
String [] gPositive, gNegative;

String[][] textArray = new String[5][8];; 

void importTextData(){
  table = loadTable("text.csv", "header"); 
  
  numRows = table.getRowCount(); 
  numCols = table.getColumnCount();
  
  lPositive = new String [love]; 
  lNegative = new String [love]; 
  wPositive = new String[work - love]; 
  wNegative = new String[work - love]; 
  gPositive = new String[general-work]; 
  gNegative = new String[general-work]; 
  fPositive = new String[family-general]; 
  fNegative = new String[family-general]; 
  
  //storing table data into string arrays for each category
  for(int i = 0; i<numRows; i++){
     if(i< love){
         lPositive[i] = table.getString(i, 1); 
         lNegative[i] = table.getString(i, 2); 
     }
     if(i >= love && i< work){
         wPositive[i-love] = table.getString(i, 1); 
         wNegative[i-love] = table.getString(i, 2); 
     }
    if(i>= work && i< general){
         gPositive[i-work] = table.getString(i, 1); 
         gNegative[i-work] = table.getString(i, 2); 
     }
     if(i>= general && i<family){
         fPositive[i-general] = table.getString(i, 1); 
         fNegative[i-general] = table.getString(i, 2); 
     }
  }
  
  for(int i = 0; i<5; i++){
    textArray[i][0] = wPositive[i]; 
    textArray[i][1] = wNegative[i]; 
    textArray[i][2] = fPositive[i]; 
    textArray[i][3] = fNegative[i]; 
    textArray[i][4] = lPositive[i]; 
    textArray[i][5] = lNegative[i]; 
    textArray[i][6] = gPositive[i]; 
    textArray[i][7] = gNegative[i]; 
  }
  
  
  //{ lPositive, lNegative, fPositive, fNegative, wPositive, wNegative,
//gPositive, gNegative};
}