class Category{
  HashMap<Integer, Object> dataEntries;
  HashMap<Integer, Float> indexToYCoord;
  String name;
  String type;
  Float fMin, fMax, x;
  Integer iMin, iMax;
  ArrayList<String> uniqueEntry;
  
  
  Category(String tempName, String tempType, float tempX){
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
  }
  
  void setX(float newX){
    x = newX;
  }
  
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
  
  void setY(float high, float low){
    if (type.equals("Integer")){
      setIntegerY(high, low);
    }
    else if (type.equals("Float")){
      setFloatY(high, low);
    }
    else {
      setStringY(high, low);
    }
  }
  
  void setIntegerY(float high, float low){
    float len = high - low;
    for (HashMap.Entry<Integer, Object> entry: dataEntries.entrySet()){
      Integer s = (Integer)entry.getValue();
      indexToYCoord.put(entry.getKey(),len*(((float)iMax-(float)s)/((float)iMax - (float)iMin))+low);
    }
  }
  
  void setFloatY(float high, float low){
    float len = high - low;
    for (HashMap.Entry<Integer, Object> entry: dataEntries.entrySet()){
      Float s = (Float)entry.getValue();
      indexToYCoord.put(entry.getKey(),len*((fMax-s)/(fMax - fMin))+low);
    }
  }
  
  void setStringY(float high, float low){
    float len = high - low;
    for (HashMap.Entry<Integer, Object> entry: dataEntries.entrySet()){
      String s = (String)entry.getValue();
      int i = uniqueEntry.indexOf(s);
      indexToYCoord.put(entry.getKey(),i*(len/(uniqueEntry.size() - 1))+low);
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