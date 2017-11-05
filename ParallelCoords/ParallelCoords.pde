void setup() {
  size(1500, 1500, P2D);
  background(0);
  loadData();
}

void loadData(){
  TableReader tr = new TableReader("cameras-cleaned.tsv");
}