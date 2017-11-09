class Category{
  HashMap<Integer, Object> dataEntries;
  HashMap<Integer, Float> indexToYCoord;
  String name;
  String type;
  Float fMin, fMax, x;
  Integer iMin, iMax;
  ArrayList<String> uniqueEntry;
  float filterUpper, filterLower;
  float HIGH, LOW;
  
  
  Category(String tempName, String tempType, float tempX , float tempHigh, float tempLow){
    dataEntries = new HashMap<Integer, Object>();
    indexToYCoord = new HashMap<Integer, Float>();
    uniqueEntry = new ArrayList<String>();
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
  }
  
  
  
  void setX(float newX){
    x = newX;
  }
  
  void setFilterUpper(float newUpper){
    //Check if the new position has passed or on the other limit
    if (! (newUpper>=filterLower || newUpper < LOW || newUpper > HIGH)){
      filterUpper = newUpper;
    }
  }
  
  void setFilterLower(float newLower){
    //Check if the new position has passed or on the other limit
    if (! (newLower<=filterUpper || newLower < LOW || newLower > HIGH)){
      filterLower = newLower;
    }
  }
  
  float getFilterUpper(){return filterUpper;}
  float getFilterLower(){return filterLower;}
  
  float getX(){
    return x;
  }
  
  void addEntry(Integer index, String value){
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

  void setIntegerMinMax(int value){
    if (value > iMax){
      iMax = value;
    }
    else if (value < iMin || iMin == -1){
      iMin = value;
    }
  }
  
  void setFloatMinMax(float value){
    if (value > fMax){
      fMax = value;
    }
    else if (value < fMin || fMin == -1.0){
      fMin = value;
    }
  }
    
  Object getEntry(int index){
    return dataEntries.get(index);
  }
  
  String getType(){
    return type;
  }
  
  float getFloatMin(){
    return fMin;
  }
  
  float getFloatMax(){
    return fMax;
  }
  
  int getIntMin(){
    return iMin;
  }
  
  int getIntMax(){
    return iMax;
  }
  
  float getY(int index){
    return indexToYCoord.get(index);
  }
  
  String getCatName(){
    return name;
  }
  
}