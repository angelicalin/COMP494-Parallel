Category[] categories;
//String data = "cameras-cleaned.tsv";
//String data = "nutrients-cleaned.tsv";
String data = "cars-cleaned.tsv";
final int windowWidth = 1300;
final int windowHeight = 720;
final float HIGH = windowHeight - 50;
final float LOW = HIGH - 500;
final float WIDTHPAD = 50;
final int BARWIDTH = 8;
float barSpace;
//float[] categoryPos;
boolean[] pressed;
int ROWCOUNT = 0;
int COLUMNCOUNT = 0;
int clickCount = 0; 
int[] clicked = {0, 0};
final float FILTERBARHALFWIDTH = 10;
final float FILTERBARLENGTH = 8;




void setup() {
  size(1300, 720, P2D);
  background(255);
  
  loadData(data);
 // categoryPos = new float[categories.length];
  pressed = new boolean[categories.length];
  barSpace = (width-2*WIDTHPAD)/(categories.length - 1);
  for(int i = 0; i < categories.length; i++){
    
    float xPos = i*barSpace+0.5*WIDTHPAD;
   // categoryPos[i] = xPos;
    pressed[i] = false;
    categories[i].setX(xPos);
    categories[i].setY();
  }
  
  
}

void draw(){
  background (255);
  textSize(20);
  textAlign(CENTER,CENTER);
  text(data, width/2, 50);
  strokeWeight(.5);
  //Draw individual lines between columns
  for (int i = 0; i < ROWCOUNT; i++){
    for (int j = 0; j < COLUMNCOUNT - 1; j++){
      line( categories[j].getX(), categories[j].getY(i),  categories[j+1].getX(), categories[j+1].getY(i));
    }
  }
  int count = 0;
  //Draw the columns and the text
  textAlign(CENTER,BOTTOM);
  for(Category c: categories){
    float x = c.getX();
    textSize(18);
    text(c.getCatName(), x, LOW - 10);
    if(pressed[count]){
      fill(200, 0, 0);
      stroke(200, 0, 0);
    }
    rect(x, LOW, BARWIDTH, HIGH-LOW);
    fill(178,255,255);
    rect(x + 0.5*BARWIDTH - FILTERBARHALFWIDTH, c.getFilterUpper()-FILTERBARLENGTH, 2* FILTERBARHALFWIDTH , FILTERBARLENGTH);
    rect(x + 0.5*BARWIDTH - FILTERBARHALFWIDTH, c.getFilterLower(), 2* FILTERBARHALFWIDTH , FILTERBARLENGTH);
    fill(0);
    stroke(0);
    count ++;
  }
}

//To fillter the data

void mouseDragged(){
  for (int i =0; i < COLUMNCOUNT ; i++){
    if (mouseX >=categories[i].getX()+0.5*BARWIDTH -FILTERBARHALFWIDTH && mouseX <= categories[i].getX()+0.5*BARWIDTH + FILTERBARHALFWIDTH&&
          mouseY >= categories[i].getFilterUpper()-FILTERBARLENGTH && mouseY <=categories[i].getFilterUpper()){
            categories[i].setFilterUpper(mouseY+0.5*FILTERBARLENGTH);
    }
     else if (mouseX >=categories[i].getX()+0.5*BARWIDTH -FILTERBARHALFWIDTH && mouseX <= categories[i].getX()+0.5*BARWIDTH + FILTERBARHALFWIDTH&&
          mouseY <= categories[i].getFilterLower()+FILTERBARLENGTH && mouseY >=categories[i].getFilterLower()){
             categories[i].setFilterLower(mouseY-0.5*FILTERBARLENGTH);
    }
  }

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