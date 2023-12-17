int compareWithCurrentDate(String referenceDate){
  String currentDate = DateTime.now().toString().split(' ')[0];
  if(currentDate.compareTo(referenceDate) < 0){
    return 1;
  }
  else if(currentDate.compareTo(referenceDate) > 0){
    return -1;
  }
  else{
    return 0;
  }
}

bool compareWithCurrentTime(String referenceTime){
  List<String> referenceTimeList = referenceTime.split(' ');
  DateTime currentDateTime = DateTime.now();

  List<String> currentTimeList = [];
  if(currentDateTime.hour >= 12){
    currentTimeList.add('${currentDateTime.hour - 12}:${currentDateTime.minute}');
    currentTimeList.add('PM');
  }
  else{
    currentTimeList.add('${currentDateTime.hour}:${currentDateTime.minute}');
    currentTimeList.add('AM');
  }

  if(currentTimeList[1].compareTo(referenceTimeList[1]) < 0){
    return true;
  }
  else if(currentTimeList[1].compareTo(referenceTimeList[1]) > 0){
    return false;
  }
  else{
    if(currentTimeList[0].compareTo(referenceTimeList[0]) <= 0){
      return true;
    }
    else{
      return false;
    }
  }
}