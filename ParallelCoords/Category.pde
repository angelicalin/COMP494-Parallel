class Category{
  HashMap<Integer, Object> dataEntries;
  HashMap<Integer, Float> indexToYCoord;
  HashMap<Integer, Boolean> indexToIfDisplay;
  HashMap<Integer, String> YCoordToLabel;
  String name;
  String type;
  Float fMin, fMax, x;
  Integer iMin, iMax;
  int rowCount;
  ArrayList<String> uniqueEntry;
  float filterUpper, filterLower;
  float HIGH, LOW;
  boolean isUpper;
  
  Category(String tempName, String tempType, float tempX , float tempHigh, float tempLow){
    dataEntries = new HashMap<Integer, Object>();
    indexToYCoord = new HashMap<Integer, Float>();
    uniqueEntry = new ArrayList<String>();
    indexToIfDisplay = new HashMap<Integer, Boolean>();
    YCoordToLabel = new HashMap<Integer, String>();
    name = tempName;
    type = tempType;
    x = tempX;
    fMin = -1.0;
    fMax = -1.0;
    iMin = -1;
    iMax = -1;
    HIGH = tempHigh;
    LOW = tempLow;
    filterUpper = tempLow;
    filterLower = tempHigh;
    isUpper = false;
    rowCount = 0;
  }
  
  //Recalculates which links get displayed
  private void checkIfDisplay(){
    indexToIfDisplay.clear();
    for (int i = 0 ; i < indexToYCoord.size(); i++){
      float y = indexToYCoord.get(i);
      if (y>filterLower || y < filterUpper ){
        indexToIfDisplay.put(i, false);
      }
    }
  }
  
  //sets the new upper filter point
  void setFilterUpper(float mouse, float filterBarSize){
    //Check if the new position has passed or on the other limit
    float newUpper = mouse + filterBarSize;
    if (! (newUpper>=filterLower || newUpper < LOW || newUpper > HIGH)){
      filterUpper = newUpper;
      checkIfDisplay();
    }
  }
  
  //sets the new lower filter point
  void setFilterLower(float mouse, float filterBarSize){
    //Check if the new position has passed or on the other limit
    float newLower = mouse - filterBarSize;
    if (! (newLower<=filterUpper || newLower < LOW || newLower > HIGH)){
      filterLower = newLower;
      checkIfDisplay();
    }
  }
  
  //Checks wich filter to change
  void setFilter(float mouse, float filterBarSize){
    if(isUpper){
      if((mouse+filterBarSize)>=filterLower){
        isUpper = false;
      }
      setFilterUpper(mouse, filterBarSize);
    }
    else{
      if((mouse-filterBarSize)<=filterUpper){
        isUpper = true;
      }
      setFilterLower(mouse, filterBarSize);
    }
  }
  
  //Add's an entry to the category while associating an index to each data point.
  void addEntry(Integer index, String value){
    rowCount ++;
    if (type.equals("Integer")){
      Integer nValue = Integer.parseInt(value);
      dataEntries.put(index, nValue);
      setIntegerMinMax(nValue);
    }
    else if (type.equals("Float")){
      Float nValue = Float.parseFloat(value);
      dataEntries.put(index, nValue);
      setFloatMinMax(nValue);
    }
    else {
      dataEntries.put(index, value);
      if(!uniqueEntry.contains(value)){
        uniqueEntry.add(value);
      }
    }
  }
  
  
  //Set's the y position for each label on the category bar depending on if 
  //the category data is Integer, Float, or String
  void setLabels(){
    if (type.equals("Integer")){
      setIntegerLabels();
    }
    else if (type.equals("Float")){
      setFloatLabels();
    }
    else {
      setStringLabels();
    }
  }
  
  void setIntegerLabels(){
    float lenSec = (HIGH - LOW)/10;
    float range = iMax - iMin;
    if(range < 10.0){
      for (int i = 0; i <= 10; i++){
        String s = Float.toString(float(i)*range+ iMin);
        YCoordToLabel.put(int((10-i)*lenSec + LOW), s);
      }
    }
    else{
      for (int i = 0; i <= 10; i++){
        String s = Integer.toString(int(i*range + iMin));
        YCoordToLabel.put(int((10-i)*lenSec + LOW), s);
      }
    }
  }
  
  void setFloatLabels(){
    float lenSec = (HIGH - LOW)/10;
    float range = fMax - fMin;
    if(range < 10.0){
      for (int i = 0; i <= 10; i++){
        String s = Float.toString(float(i)*range + fMin);
        YCoordToLabel.put(int((10-i)*lenSec + LOW), s);
      }
    }
    else{
      for (int i = 0; i <= 10; i++){
        String s = Integer.toString(int(i*range + fMin));
        YCoordToLabel.put(int((10-i)*lenSec + LOW), s);
      }
    }
  }
  
  void setStringLabels(){
    float len = HIGH - LOW;
    for (HashMap.Entry<Integer, Object> entry: dataEntries.entrySet()){
      String s = (String)entry.getValue();
      YCoordToLabel.put(int(entry.getKey()*len/rowCount + LOW), s);
    }
  }
  
  //Set's the y position for each data point on the category bar depending on if 
  //the category data is Integer, Float, or String
  void setY(){
    if (type.equals("Integer")){
      setIntegerY();
    }
    else if (type.equals("Float")){
      setFloatY();
    }
    else {
      setStringY();
    }
  }
  
  void setIntegerY(){
    float len = HIGH - LOW;
    for (HashMap.Entry<Integer, Object> entry: dataEntries.entrySet()){
      Integer s = (Integer)entry.getValue();
      indexToYCoord.put(entry.getKey(),len*(((float)iMax-(float)s)/((float)iMax - (float)iMin))+LOW);
    }
  }
  
  void setFloatY(){
    float len = HIGH - LOW;
    for (HashMap.Entry<Integer, Object> entry: dataEntries.entrySet()){
      Float s = (Float)entry.getValue();
      indexToYCoord.put(entry.getKey(),len*((fMax-s)/(fMax - fMin))+LOW);
    }
  }
  
  void setStringY(){
    float len = HIGH - LOW;
    for (HashMap.Entry<Integer, Object> entry: dataEntries.entrySet()){
      String s = (String)entry.getValue();
      int i = uniqueEntry.indexOf(s);
      indexToYCoord.put(entry.getKey(),i*(len/(uniqueEntry.size() - 1))+LOW);
    }
  }

  //sets the min and max if the Category is an Integer value
  void setIntegerMinMax(int value){
    if (value > iMax){
      iMax = value;
    }
    else if (value < iMin || iMin == -1){
      iMin = value;
    }
  }
  
  //sets the min and max if the Category is a Float value
  void setFloatMinMax(float value){
    if (value > fMax){
      fMax = value;
    }
    else if (value < fMin || fMin == -1.0){
      fMin = value;
    }
  }
      
  void setIsUpper(boolean isIt){isUpper = isIt;}
  void setX(float newX){x = newX;}
  float getX(){return x;}
  float getFilterUpper(){return filterUpper;}
  float getFilterLower(){return filterLower;}
  HashMap<Integer, Boolean> getIndexToIfDisplayMap(){return indexToIfDisplay;}
  HashMap<Integer, String> getYCoordToLabel(){return YCoordToLabel;}
  Object getEntry(int index){return dataEntries.get(index);}
  String getType(){return type;}
  float getFloatMin(){return fMin;}
  float getFloatMax(){return fMax;}
  int getIntMin(){return iMin;}
  int getIntMax(){return iMax;}
  float getY(int index){return indexToYCoord.get(index);}
  String getCatName(){return name;}
}