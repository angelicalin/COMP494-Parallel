class TableReader{
  String[] tableData;
  String[] types;
  String[] categoryNames;
  final int COLUMNCOUNT;
  final int ROWCOUNT;
  float HIGH;
  float LOW;
  
  Category[] categories;
  
  TableReader(String data, float tempHigh, float tempLow){
    tableData = loadStrings(data);
    categoryNames = tableData[0].split("\\t");
    types = tableData[1].split("\\t");
    COLUMNCOUNT = categoryNames.length;
    ROWCOUNT = tableData.length - 2;
    categories = new Category[COLUMNCOUNT];
    HIGH = tempHigh;
    LOW = tempLow;
    loadCategories();
    loadDataEntries();
   
    
  }
  
  void loadCategories(){
    for(int i = 0; i < COLUMNCOUNT; i++){
      Category c = new Category(categoryNames[i], types[i], (float)i, HIGH, LOW);
      categories[i] = c;
    }
  }
  
  void loadDataEntries(){
    for(int i = 2; i < tableData.length; i++){
      String[] currRow = tableData[i].split("\\t");
      for(int j = 0; j < COLUMNCOUNT; j++){
        categories[j].addEntry(i-2, currRow[j]);
      }
    }
  }
  
  Category[] getCategories(){
    return categories;
  }
  
  int getColumnCount(){
    return COLUMNCOUNT;
  }
  
  int getRowCount(){
    return ROWCOUNT;
  }
}