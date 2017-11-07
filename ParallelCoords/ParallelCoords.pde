Category[] categories;
//String data = "cameras-cleaned.tsv";
//String data = "nutrients-cleaned.tsv";
String data = "cars-cleaned.tsv";

final float HIGH = 1250;
final float LOW = 250;
final float WIDTHPAD = 100;
final int BARWIDTH = 8;
float barSpace;
//float[] categoryPos;
boolean[] pressed;
int ROWCOUNT = 0;
int COLUMNCOUNT = 0;
int clickCount = 0; 
int[] clicked = {0, 0};

void setup() {
  size(2000, 1500, P2D);
  background(255);

  
  loadData(data);
 // categoryPos = new float[categories.length];
  pressed = new boolean[categories.length];
  barSpace = (1800-200+WIDTHPAD)/(categories.length - 1);
  for(int i = 0; i < categories.length; i++){
    float xPos = i*barSpace+200;
   // categoryPos[i] = xPos;
    pressed[i] = false;
    categories[i].setX(xPos);
    categories[i].setY(HIGH, LOW);
  }
  
  
}

void draw(){
  background (255);
   textSize(42);
  text(data, (HIGH+LOW)/2, 150);
  strokeWeight(.5);
  for (int i = 0; i < ROWCOUNT; i++){
    for (int j = 0; j < COLUMNCOUNT - 1; j++){
      line( categories[j].getX(), categories[j].getY(i),  categories[j+1].getX(), categories[j+1].getY(i));
    }
  }


  int count = 0;
  for(Category c: categories){
    
    float x = c.getX();
    textSize(18);
    text(c.getCatName(), x-5, LOW - 10);
    if(pressed[count]){
      fill(200, 0, 0);
      stroke(200, 0, 0);
    }
    rect(x, LOW, BARWIDTH, HIGH-LOW);
    fill(0);
    stroke(0);
    count ++;
  }
  

  
}

void mouseClicked(){
  for(int i = 0; i < COLUMNCOUNT; i++){
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
  TableReader tr = new TableReader(data);
  categories = tr.getCategories();
  ROWCOUNT = tr.getRowCount();
  COLUMNCOUNT = tr.getColumnCount();
}