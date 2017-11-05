class TableReader{
  Table tableData;
  TableRow types;
  final int COLUMNCOUNT;
  Category[] categories;
  DataEntry[] dataEntries;
  
  TableReader(String data){
    tableData = loadTable(data);
    categories = tableData.getRow(0);
    types = tableData.getRow(1);
    COLUMNCOUNT = tableData.getColumnCount();
    loadDataEntries();
  }
  
  void loadDataEntries(){
    for(int i = 2; i < tableData.getRowCount(); i++){
      TableRow currRow = tableData.getRow(i);
      DataEntry newEntry = new DataEntry();
      for(int j = 0; j < COLUMNCOUNT; j++){
        if(types.get(j)){
        }
        else if(){
        }
        else{
        }
      }
    }
  }
}