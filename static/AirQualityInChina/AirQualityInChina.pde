// China AQI Project 
// Siyao Zhang and Qinying Li
FloatTable data;
int dataMin, dataMax;

int plotX1, plotY1;
int plotX2, plotY2;
int labelX, labelY;

int rowCount;
int columnCount;
int currentColumn = 0;

int dateMin, dateMax;
int[] dates;

int dateInterval = 1;
int volumeInterval = 40;

int[] myParametersX = {          //beijing shanghai chengdu guangzhou shenyang
  879, 933, 678, 840, 915
}; 
int[] myParametersY = {
  258, 390, 420, 534, 234
}; 
int[] myParametersXaqi = {
 855, 933, 678, 840, 915//aqi value //beijing shanghai chengdu guangzhou shenyang
}; 
int[] myParametersYaqi = {
 282, 411, 441, 555, 255
}; 


PFont  courier36;
PFont  courier24;
PFont  courier18;
PFont  courier12;
PFont plotFont; 
PImage backdrop;   // a low-contrast image of air pollution 

XML BeijingAirDataset;  // the XML data as downloaded 
XML[] BeijingAirItemsByHour;   // an array to store the top level content (of the whole dataset)
XML ShanghaiAirDataset;  // the XML data as downloaded 
XML[] ShanghaiAirItemsByHour;   // an array to store the top level content (of the whole dataset)
XML ChengduAirDataset;  // the XML data as downloaded 
XML[] ChengduAirItemsByHour;   // an array to store the top level content (of the whole dataset)
XML GuangzhouAirDataset;  // the XML data as downloaded 
XML[] GuangzhouAirItemsByHour;   // an array to store the top level content (of the whole dataset)
XML ShenyangAirDataset;  // the XML data as downloaded 
XML[] ShenyangAirItemsByHour;   // an array to store the top level content (of the whole dataset)

XML dataItem;  // a placeholder for a single XML item (read from a row)
String description,report,hour;  // for the text content to be read from the data item
XML dataItem2;  // a placeholder for a single XML item (read from a row)
String description2,report2,hour2;
XML dataItem3;  // a placeholder for a single XML item (read from a row)
String description3,report3,hour3;
XML dataItem4;  // a placeholder for a single XML item (read from a row)
String description4,report4,hour4;
XML dataItem5;  // a placeholder for a single XML item (read from a row)
String description5,report5,hour5;

int itemCounter = 0;  // counter for current item.  each time through the draw loop goes to the next one. 
int hourCounter; // a second counter in order to invert the time sequence
int signSize;
int signplace;
int itemCounter2 = 0;  // counter for current item.  each time through the draw loop goes to the next one. 
int hourCounter2; // a second counter in order to invert the time sequence
int signSize2;
int itemCounter3 = 0;  // counter for current item.  each time through the draw loop goes to the next one. 
int hourCounter3; // a second counter in order to invert the time sequence
int signSize3;
int itemCounter4 = 0;  // counter for current item.  each time through the draw loop goes to the next one. 
int hourCounter4; // a second counter in order to invert the time sequence
int signSize4;
int itemCounter5 = 0;  // counter for current item.  each time through the draw loop goes to the next one. 
int hourCounter5; // a second counter in order to invert the time sequence
int signSize5;

int a=1555;//placement of circle shanghai
int b=650;//placement of circle shanghai

float c=0.3;//size of circle

//int value = 0; 
boolean paused = false;
boolean paused2 = false;
//int y = 40;  // for positioning text display



void setup() {
  size(1152, 648);  
  courier36 = loadFont("Courier-36.vlw");
  courier24 = loadFont("Courier-24.vlw");
  courier18 = loadFont("Courier-18.vlw");
  courier12 = loadFont("Courier-12.vlw");
  rectMode(CORNERS);
  colorMode(HSB);
  textAlign(LEFT);
  //  background(0, 0, 25);
  backdrop = loadImage("map.png");
  BeijingAirDataset = loadXML("BeijingAir.xml");  // load the whole dataset into the sketch  print(BeijingAirDataset.listChildren());
  BeijingAirItemsByHour = BeijingAirDataset.getChildren("channel/item");  // get the data items, and put them into an array
  ShanghaiAirDataset = loadXML("ShanghaiAir.xml");  
  ShanghaiAirItemsByHour = ShanghaiAirDataset.getChildren("channel/item");
  ChengduAirDataset = loadXML("ChengduAir.xml");  
  ChengduAirItemsByHour = ChengduAirDataset.getChildren("channel/item");
  GuangzhouAirDataset = loadXML("GuangzhouAir.xml");  
  GuangzhouAirItemsByHour = GuangzhouAirDataset.getChildren("channel/item");
  ShenyangAirDataset = loadXML("ShenyangAir.xml");  
  ShenyangAirItemsByHour = ShenyangAirDataset.getChildren("channel/item");

//--------------------------------------------
  data = new FloatTable("aqi nov.tsv");
  rowCount = data.getRowCount();
  columnCount = data.getColumnCount();

  dates = int(data.getRowNames());
  dateMin = dates[0];
  dateMax = dates[dates.length - 1];
  
  //println(data.getTableMin());
  dataMin = 0; //data.getTableMin();
  //dataMax = data.getTableMax();
  dataMax = ceil(data.getTableMax() / volumeInterval) * volumeInterval;
  //println(dataMax);

  // Corners of the plotted time series
  plotX1 = 0; 
  plotX2 = width - 60;
  labelX = 50;
  plotY1 = 60;
  plotY2 = height - 70;
  labelY = height - 25;
  
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont);

  smooth();
}

void mouseClicked(){
  if (mouseY > 0 && mouseY < 36 && mouseX > 1100 && mouseX < 1150){//pause
  paused = true;
  }
  if (mouseY > 0 && mouseY < 36 && mouseX > 1080 && mouseX < 1100){//run
  paused = false;
  paused2= false;
  }
}

void draw() {
  background(235,40,36);
  image(backdrop, 0, 0);
   image(backdrop, 0, 0);
  

  if (itemCounter == 28) {  // reset at end of daily cycle
    itemCounter = 0;  
  }
  if (itemCounter2 == 28) {  // reset at end of daily cycle
    itemCounter2 = 0;  
  }
  if (itemCounter3 == 28) {  // reset at end of daily cycle
    itemCounter3 = 0;  
  }
  if (itemCounter4 == 28) {  // reset at end of daily cycle
    itemCounter4 = 0;  
  }
  if (itemCounter5 == 28) {  // reset at end of daily cycle
    itemCounter5 = 0;  
  }
  
  hourCounter = 27 - itemCounter;   // invert because data comes in newest to oldest. want to display oldest to newest, over the hours of the day. 
 // display the latest report 
  // this is just a text readout. next step would be to produce graphics instead. 
  hourCounter2 = 27 - itemCounter2;   // invert because data comes in newest to oldest. want to display oldest to newest, over the hours of the day.
  hourCounter3 = 27 - itemCounter3;   // invert because data comes in newest to oldest. want to display oldest to newest, over the hours of the day.
  hourCounter4 = 27 - itemCounter4;   // invert because data comes in newest to oldest. want to display oldest to newest, over the hours of the day.
  hourCounter5 = 27 - itemCounter5;   // invert because data comes in newest to oldest. want to display oldest to newest, over the hours of the day.
  
 
 if (paused == false){
   itemCounter++; 
   itemCounter2++;
   itemCounter3++;
   itemCounter4++;
   itemCounter5++;
  
  delay(1000); 
 }
  
 if (paused == true&&paused2==false){//??
    delay(1000); 
 }
 
  dataItem = (BeijingAirItemsByHour[hourCounter].getChild("title"));  // get the tagged item
  hour = dataItem.getContent();  // get its text content
  
  dataItem = (BeijingAirItemsByHour[hourCounter].getChild("Conc"));  // get the tagged item
  signplace = parseInt(dataItem.getContent());  // get its text content

  dataItem = (BeijingAirItemsByHour[hourCounter].getChild("AQI")); // get the tagged item
  report = dataItem.getContent(); // get its text content
  signSize = parseInt(report);

  dataItem = (BeijingAirItemsByHour[hourCounter].getChild("Desc")); // get the tagged item
  description = dataItem.getContent(); // get its text content
    // could get any other data items in similar manner


  

  dataItem2 = (ShanghaiAirItemsByHour[hourCounter].getChild("AQI")); // get the tagged item
  report2 = dataItem2.getContent(); // get its text content
  signSize2 = parseInt(report2);

  dataItem2 = (ShanghaiAirItemsByHour[hourCounter].getChild("Desc")); // get the tagged item
  description2 = dataItem2.getContent();
  
  
  
  dataItem3 = (ChengduAirItemsByHour[hourCounter].getChild("AQI")); // get the tagged item
  report3 = dataItem3.getContent(); // get its text content
  signSize3 = parseInt(report3);

  dataItem3 = (ChengduAirItemsByHour[hourCounter].getChild("Desc")); // get the tagged item
  description3 = dataItem3.getContent();
  
  
  
  dataItem4 = (GuangzhouAirItemsByHour[hourCounter].getChild("AQI")); // get the tagged item
  report4 = dataItem4.getContent(); // get its text content
  signSize4 = parseInt(report4);

  dataItem4 = (GuangzhouAirItemsByHour[hourCounter].getChild("Desc")); // get the tagged item
  description4 = dataItem4.getContent();
  
  
  
  dataItem5 = (ShenyangAirItemsByHour[hourCounter].getChild("AQI")); // get the tagged item
  report5 = dataItem5.getContent(); // get its text content
  signSize5 = parseInt(report5);

  dataItem5 = (ShenyangAirItemsByHour[hourCounter].getChild("Desc")); // get the tagged item
  description5 = dataItem5.getContent();
  
  
  if( (paused == false)||(paused == true&&paused2==false)){
  noFill();//beijing
  stroke(#E4007F);
  strokeWeight(1);
  ellipse(1465*0.6, 430*0.6, c*signSize, c*signSize);
  
  
  noStroke();
  fill(#DB1D8F,100);
  rect((69*0.6)*signplace-(69*0.6),1044*0.6, (69*0.6)*signplace, 1080*0.6);
  
  
  fill(255);
  textFont(courier18);
  text("AQI",1425,470);
  
  
  textFont(courier18);
  text(report,1425*0.6,470*0.6);
  textFont(courier12);
  text(description, 1425*0.6, 500*0.6);

  
  stroke(#E4007F);//shanghai
  strokeWeight(1);
  noFill();
  ellipse(a*0.6, b*0.6, c*signSize2, c*signSize2);
  
  
  fill(255);
  textFont(courier18);
  text(report2,a*0.6,(b+35)*0.6);
  textFont(courier12);
  text(description2,a*0.6, (b+65)*0.6);
  
  
  stroke(#E4007F);//chengdu
  strokeWeight(1);
  noFill();
  ellipse((a-425)*0.6, (b+50)*0.6, c*signSize3, c*signSize3);
  
 
  fill(255);
  textFont(courier18);
  text(report3,(a-425)*0.6,(b+35+50)*0.6);
  textFont(courier12);
  text(description3,(a-425)*0.6, (b+65+50)*0.6);
  
  stroke(#E4007F);//guangzhou
  strokeWeight(1);
  noFill();
  ellipse((a-155)*0.6, (b+240)*0.6, c*signSize4, c*signSize4);
  
 
  fill(255);
  textFont(courier18);
  text(report4,(a-155)*0.6,(b+35+240)*0.6);
  textFont(courier12);
  text(description4,(a-155)*0.6, (b+65+240)*0.6);
  
  
  stroke(#E4007F);//shenyang
  strokeWeight(1);
  noFill();
  ellipse((a-30)*0.6, (b-260)*0.6, c*signSize5, c*signSize5);
  
 
  fill(255);
  textFont(courier18);
  text(report5,(a-30)*0.6,(b+35-260)*0.6);
  textFont(courier12);
  text(description5,(a-30)*0.6, (b+65-260)*0.6);
}
 
 
noFill();//beijing
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse(1465*0.6, 430*0.6, c*278, c*278);
  
  noFill();
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse(1465*0.6, 430*0.6, c*43, c*43);
  
  noFill();
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse(1465*0.6, 430*0.6, c*637, c*637);
 
noFill();//shanghai
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse(a*0.6, b*0.6, c*146, c*146);
  
  noFill();
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse(a*0.6, b*0.6, c*85, c*85);
  
  noFill();
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse(a*0.6, b*0.6, c*280, c*280);
  
 noFill();//chengdu
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse((a-425)*0.6, (b+50)*0.6, c*170, c*170);
  
  noFill();
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse((a-425)*0.6, (b+50)*0.6, c*95, c*95);
  
  noFill();
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse((a-425)*0.6, (b+50)*0.6, c*192, c*192);
  
 noFill();//guangzhou
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse((a-155)*0.6, (b+240)*0.6, c*160, c*160);
  
  noFill();
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse((a-155)*0.6, (b+240)*0.6, c*127, c*127);
  
  noFill();
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse((a-155)*0.6, (b+240)*0.6, c*202, c*202);
  
  noFill();//shenyang
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse((a-30)*0.6, (b-260)*0.6, c*204, c*204);
  
  noFill();
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse((a-30)*0.6,(b-260)*0.6, c*132,c*132);
  
  noFill();
  stroke(#FFFFFF);
  strokeWeight(0.1);
  ellipse((a-30)*0.6, (b-260)*0.6, c*562,c*562);

  
 // -----------------------------------------------------
  drawTitleTabs();



  stroke(255);
  strokeWeight(5);
  drawDataPoints(currentColumn);
  noFill();
  strokeWeight(0.5);
}


void drawTitle() {
  fill(255);
  textSize(2000);
  textAlign(LEFT);
  String title = data.getColumnName(currentColumn);
  //text(title, plotX1, plotY1 - 10);
}


float[] tabLeft, tabRight;  // Add above setup()
float tabTop, tabBottom;
float tabPad = 10;

void drawTitleTabs() {
  rectMode(CORNERS);
  noStroke();
  textSize(13);
  textAlign(LEFT);

  // On first use of this method, allocate space for an array
  // to store the values for the left and right edges of the tabs
  if (tabLeft == null) {
 
   tabLeft = new float[columnCount];
    tabRight = new float[columnCount];
  }
  
  float runningX = plotX1; 
  tabTop =626.4;
  tabBottom = 648;
  
  for (int col = 0; col < columnCount; col++) {
    String title = data.getColumnName(col);
    tabLeft[col] = runningX; 
    float titleWidth = textWidth(title);
    tabRight[col] = tabLeft[col] + 41.4;
    
    runningX = tabRight[col];
  }
}


void mousePressed() {
   if (mouseY > tabTop && mouseY < tabBottom){
     for (int col = 0; col < columnCount; col++) {
if(mouseX > tabLeft[col] && mouseX < tabRight[col]) {
     paused2 = true;
     setCurrent(col);
   }
     }
   }
}


void setCurrent(int col) {
  currentColumn = col;
}

int volumeIntervalMinor = 10;   // Add this above setup()


 int squareSizeX = 100;
  int squareSizeY = 100;
   int squareSizeXaqi = 100;
  int squareSizeYaqi = 100;

void drawDataPoints(int col) {
  for (int row = 0; row < rowCount; row++) {
    if (data.isValid(row, col)) {
      float value = data.getFloat(row, col);
     float x = map(dates[row], dateMin, dateMax, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
    squareSizeX = myParametersX[row]; 
      squareSizeY = myParametersY[row]; 

      
if (paused2== true &&paused==true){    
      stroke(#e4007f);
      noFill();
      strokeWeight(1);
      ellipse(squareSizeX, squareSizeY, 0.3*value, 0.3*value);
      
        squareSizeXaqi = myParametersXaqi[row]; 
        squareSizeYaqi = myParametersYaqi[row]; 
        textFont(courier18);
        textAlign(LEFT);
        fill(255);
       text(nf(value,3,0) ,squareSizeXaqi, squareSizeYaqi);
       // text(value2 ,squareSizeXaqi, squareSizeYaqi+18);//state
        textFont(courier12);
       if(0 < value&&value < 50){
       text("Good",squareSizeXaqi, squareSizeYaqi+18);
       }
        if(50 < value&&value < 100){
       text("Moderate",squareSizeXaqi, squareSizeYaqi+18);
       }
        if(100 < value&&value < 150){
       text("Unhealthy for Sensitive Groups",squareSizeXaqi, squareSizeYaqi+18);
       }
        if(150 < value&&value < 200){
       text("Unhealthy",squareSizeXaqi, squareSizeYaqi+18);
       }
        if(200 < value&&value < 300){
       text("Very Unhealthy",squareSizeXaqi, squareSizeYaqi+18);
       }
        if(300 < value){
       text("Hazardous",squareSizeXaqi, squareSizeYaqi+18);
       }     

       noStroke();
       fill(col == currentColumn ? #DB1D8F : #080808, 25);    /////????????
    rect(tabLeft[col], tabTop, tabRight[col], tabBottom);
 
  }
    }
  }
}
// first line of the file should be the column headers
// first column should be the row titles
// all other values are expected to be ints
// getint(0, 0) returns the first data value in the upper lefthand corner
// files should be saved as "text, tab-delimited"
// empty rows are ignored
// extra whitespace is ignored


class FloatTable {
  int rowCount;
  int columnCount;
  float[][] data;
  String[] rowNames;
  String[] columnNames;
  
  
  FloatTable(String filename) {
    String[] rows = loadStrings(filename);
    
    String[] columns = split(rows[0], TAB);
    columnNames = subset(columns, 1); // upper-left corner ignored
    scrubQuotes(columnNames);
    columnCount = columnNames.length;

    rowNames = new String[rows.length-1];
    data = new float[rows.length-1][];

    // start reading at row 1, because the first row was only the column headers
    for (int i = 1; i < rows.length; i++) {
      if (trim(rows[i]).length() == 0) {
        continue; // skip empty rows
      }
      if (rows[i].startsWith("#")) {
        continue;  // skip comment lines
      }

      // split the row on the tabs
      String[] pieces = split(rows[i], TAB);
      scrubQuotes(pieces);
      
      // copy row title
      rowNames[rowCount] = pieces[0];
      // copy data into the table starting at pieces[1]
      data[rowCount] = parseFloat(subset(pieces, 1));

      // increment the number of valid rows found so far
      rowCount++;      
    }
    // resize the 'data' array as necessary
    data = (float[][]) subset(data, 0, rowCount);
  }
  
  
  void scrubQuotes(String[] array) {
    for (int i = 0; i < array.length; i++) {
      if (array[i].length() > 2) {
        // remove quotes at start and end, if present
        if (array[i].startsWith("\"") && array[i].endsWith("\"")) {
          array[i] = array[i].substring(1, array[i].length() - 1);
        }
      }
      // make double quotes into single quotes
      array[i] = array[i].replaceAll("\"\"", "\"");
    }
  }
  
  
  int getRowCount() {
    return rowCount;
  }
  
  
  String getRowName(int rowIndex) {
    return rowNames[rowIndex];
  }
  
  
  String[] getRowNames() {
    return rowNames;
  }

  
  // Find a row by its name, returns -1 if no row found. 
  // This will return the index of the first row with this name.
  // A more efficient version of this function would put row names
  // into a Hashtable (or HashMap) that would map to an integer for the row.
  int getRowIndex(String name) {
    for (int i = 0; i < rowCount; i++) {
      if (rowNames[i].equals(name)) {
        return i;
      }
    }
    //println("No row named '" + name + "' was found");
    return -1;
  }
  
  
  // technically, this only returns the number of columns 
  // in the very first row (which will be most accurate)
  int getColumnCount() {
    return columnCount;
  }
  
  
  String getColumnName(int colIndex) {
    return columnNames[colIndex];
  }
  
  
  String[] getColumnNames() {
    return columnNames;
  }


  float getFloat(int rowIndex, int col) {
    // Remove the 'training wheels' section for greater efficiency
    // It's included here to provide more useful error messages
    
    // begin training wheels
    if ((rowIndex < 0) || (rowIndex >= data.length)) {
      throw new RuntimeException("There is no row " + rowIndex);
    }
    if ((col < 0) || (col >= data[rowIndex].length)) {
      throw new RuntimeException("Row " + rowIndex + " does not have a column " + col);
    }
    // end training wheels
    
    return data[rowIndex][col];
  }
  
  
  boolean isValid(int row, int col) {
    if (row < 0) return false;
    if (row >= rowCount) return false;
    //if (col >= columnCount) return false;
    if (col >= data[row].length) return false;
    if (col < 0) return false;
    return !Float.isNaN(data[row][col]);
  }


  float getColumnMin(int col) {
    float m = Float.MAX_VALUE;
    for (int row = 0; row < rowCount; row++) {
      if (isValid(row, col)) {
        if (data[row][col] < m) {
          m = data[row][col];
        }
      }
    }
    return m;
  }


  float getColumnMax(int col) {
    float m = -Float.MAX_VALUE;
    for (int row = 0; row < rowCount; row++) {
      if (isValid(row, col)) {
        if (data[row][col] > m) {
          m = data[row][col];
        }
      }
    }
    return m;
  }

  
  float getRowMin(int row) {
    float m = Float.MAX_VALUE;
    for (int col = 0; col < columnCount; col++) {
      if (isValid(row, col)) {
        if (data[row][col] < m) {
          m = data[row][col];
        }
      }
    }
    return m;
  } 


  float getRowMax(int row) {
    float m = -Float.MAX_VALUE;
    for (int col = 0; col < columnCount; col++) {
      if (isValid(row, col)) {
        if (data[row][col] > m) {
          m = data[row][col];
        }
      }
    }
    return m;
  }


  float getTableMin() {
    float m = Float.MAX_VALUE;
    for (int row = 0; row < rowCount; row++) {
      for (int col = 0; col < columnCount; col++) {
        if (isValid(row, col)) {
          if (data[row][col] < m) {
            m = data[row][col];
          }
        }
      }
    }
    return m;
  }


  float getTableMax() {
    float m = -Float.MAX_VALUE;
    for (int row = 0; row < rowCount; row++) {
      for (int col = 0; col < columnCount; col++) {
        if (isValid(row, col)) {
          if (data[row][col] > m) {
            m = data[row][col];
          }
        }
      }
    }
    return m;
  }
}

