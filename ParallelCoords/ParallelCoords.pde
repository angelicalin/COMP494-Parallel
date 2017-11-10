Category[] categories;
//String data = "cameras-cleaned.tsv";
//String data = "nutrients-cleaned.tsv";
String data = "cars-cleaned.tsv";
final int windowWidth = 1300;
final int windowHeight = 720;
final float HIGH = windowHeight - 50;
final float LOW = HIGH - 500;
final float WIDTHPAD = 100;
final int BARWIDTH = 8;
float barSpace;
boolean[] pressed;
boolean moved = false; //if toggle is being moved is true
boolean hovered = false; //if a bar is being hovered over is true
int barHovered = 0; //The specific bar being hovered over
int filterBarMoved = 0; //the category who's filter bar is being moved
int ROWCOUNT = 0;
int COLUMNCOUNT = 0;
int clickCount = 0;
int[] clicked = {0, 0};
final float FILTERBARHALFWIDTH = 10;
final float FILTERBARLENGTH = 8;
HashMap<Integer, Boolean> indexToIfDisplay; //Keeps track of the rows to be displayed
HashMap<Integer, Integer> rowIndexToColor; //Keeps track of the color for each row

void setup() {
  size(1300, 720, P2D);
  hint(ENABLE_STROKE_PURE);
  background(255);
  indexToIfDisplay = new HashMap<Integer, Boolean>();
  rowIndexToColor = new HashMap<Integer, Integer>();
  loadData(data);
  pressed = new boolean[categories.length];
  barSpace = (width-2*WIDTHPAD)/(categories.length - 1);
  //Designates the positions of each bar
  for(int i = 0; i < categories.length; i++){
    float xPos = i*barSpace+WIDTHPAD;
    pressed[i] = false;
    categories[i].setX(xPos);
    categories[i].setY();
    categories[i].setLabels();
  }
  //Sets up the colors for each row
  for(int i = 0; i < ROWCOUNT; i++){
    if(i % 2 == 0){
      LABColor red = new LABColor(color(255,0,0));
      LABColor blue = new LABColor(color(0,255,255));
      color c = red.lerp(blue, float(i)/float(ROWCOUNT)).rgb;
      rowIndexToColor.put(i, c);
    }
    else{
      LABColor green = new LABColor(color(0,128,0));
      LABColor purple = new LABColor(color(128,0,128));
      color c = green.lerp(purple, float(i)/float(ROWCOUNT)).rgb;
      rowIndexToColor.put(i, c);
    }
  }
}

void draw(){
  background (255);
  textSize(20);
  textAlign(CENTER,CENTER);
  text(data, width/2, 50);
  strokeWeight(1);
  //Draw individual lines between columns
  for (int i = 0; i < ROWCOUNT; i++){
    for (int j = 0; j < COLUMNCOUNT - 1; j++){
      if (indexToIfDisplay.get(i)==null){
        float oppacity = 100.0;
        //Checks if the labels are being shown over the bar's lines
        if(hovered && (barHovered == j+1)){
          oppacity = 75.0;
        }
        stroke(rowIndexToColor.get(i), oppacity);
        line( categories[j].getX()+BARWIDTH/2, categories[j].getY(i),  categories[j+1].getX()+BARWIDTH/2, categories[j+1].getY(i));
      }
    }
  }
  stroke(0);
  
  //Checks if a bar is being moved and checks where it should be drawn
  if(moved){
    categories[filterBarMoved].setFilter(mouseY, 0.5*FILTERBARLENGTH);
  }
  
  //Draws labels for the bar being hovered over
  if(hovered){
    textSize(12);
    textAlign(RIGHT,BOTTOM);
    Category c = categories[barHovered];
    HashMap<Integer, String> labels = c.getYCoordToLabel();
    if(c.getType().equals("String")){
      if(labels.get(mouseY) != null){
        text(labels.get(mouseY), c.getX(), mouseY);
      }
    }
    else{
      for(HashMap.Entry<Integer, String> entry: labels.entrySet()){
        text(entry.getValue(), c.getX(), entry.getKey());
      }
    }
  }
  
  int count = 0;
  //Draw the columns and the text
  for(Category c: categories){
    float x = c.getX();
    textSize(18);
    textAlign(CENTER,BOTTOM);
    text(c.getCatName(), x, LOW - 10);
    
    if(pressed[count]){
      fill(178,255,255);
    }
    rect(x, LOW, BARWIDTH, HIGH-LOW);
    fill(178,255,255);
    //Create the boxes that show to where the bars are being filtered
    rect(x + 0.5*BARWIDTH - FILTERBARHALFWIDTH, c.getFilterUpper()-FILTERBARLENGTH, 2* FILTERBARHALFWIDTH , FILTERBARLENGTH);
    rect(x + 0.5*BARWIDTH - FILTERBARHALFWIDTH, c.getFilterLower(), 2* FILTERBARHALFWIDTH , FILTERBARLENGTH);
    fill(0);
    count ++;
  }
}

//To filter the data with toggles on the bars
void mouseDragged(){
  if(!moved){
    for (int i = 0; i < COLUMNCOUNT ; i++){
      if (mouseX >=categories[i].getX()+0.5*BARWIDTH -FILTERBARHALFWIDTH && mouseX <= categories[i].getX()+0.5*BARWIDTH + FILTERBARHALFWIDTH&&
          mouseY >= categories[i].getFilterUpper()-FILTERBARLENGTH && mouseY <=categories[i].getFilterUpper()){
        categories[i].setIsUpper(true);
        filterBarMoved = i;
        moved = true;
      }
      else if (mouseX >=categories[i].getX()+0.5*BARWIDTH -FILTERBARHALFWIDTH && mouseX <= categories[i].getX()+0.5*BARWIDTH + FILTERBARHALFWIDTH&&
                mouseY <= categories[i].getFilterLower()+FILTERBARLENGTH && mouseY >=categories[i].getFilterLower()){
        categories[i].setIsUpper(false);
        filterBarMoved = i;
        moved = true;
      }
    }
  }
  if (moved){
    indexToIfDisplay.clear();
    for (Category c: categories){
      indexToIfDisplay.putAll(c.getIndexToIfDisplayMap());
    }
  }
}

void mouseReleased(){
  moved = false;
}

//To change the arrangement of the columns
void mouseClicked(){
  for(int i = 0; i < COLUMNCOUNT; i++){
    //Use 2 as a area for easier selection
    if(mouseX >= categories[i].getX()-2 && mouseX <= categories[i].getX() + BARWIDTH+2 && mouseY >= LOW && mouseY <= HIGH){
      pressed[i] = true;
      if(clickCount == 0){
        clicked[0] = i;
      }
      else{
        clicked[1] = i;
      }
      clickCount ++;
    }
  }
  
  if(clickCount == 2){
    swapColumn();
    clickCount = 0;
  }
}

//Checks to see if a bar is being hovered over
void mouseMoved(){
  for(int i = 0; i < COLUMNCOUNT; i++){
    //Use 2 as a area for easier selection
    if(mouseX >= categories[i].getX()-2 && mouseX <= categories[i].getX() + BARWIDTH+2 && mouseY >= LOW && mouseY <= HIGH){
      hovered = true;
      barHovered = i;
      break;
    }
    else{
      hovered = false;
    }
  }
}

//Swaps two columns after they've been selected
void swapColumn(){
  float x0 = categories[clicked[0]].getX();
  float x1 = categories[clicked[1]].getX();
  categories[clicked[1]].setX(x0);
  categories[clicked[0]].setX(x1);
  Category swap = categories[clicked [0]];
  categories[clicked[0]] = categories[clicked[1]];
  categories[clicked[1]] = swap;
  pressed[clicked[0]] = false;
  pressed[clicked[1]] = false;
}

void loadData(String data){
  TableReader tr = new TableReader(data, HIGH, LOW);
  categories = tr.getCategories();
  ROWCOUNT = tr.getRowCount();
  COLUMNCOUNT = tr.getColumnCount();
}