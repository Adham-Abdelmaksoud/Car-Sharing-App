bool compareTimes(String currentTime, String referenceTime){
  List<String> referenceTimeList = referenceTime.split(' ');
  List<String> currentTimeList = currentTime.split(' ');
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

int compareDates(String currentDate, String referenceDate){
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

int compareWithCurrentDate(String referenceDate){
  String currentDate = DateTime.now().toString().split(' ')[0];
  return compareDates(currentDate, referenceDate);
}

bool compareWithCurrentTime(String referenceTime){
  DateTime currentDateTime = DateTime.now();

  String currentHour = '';
  String currentMinute = '';
  String timePeriod = '';
  if(currentDateTime.hour >= 12){
    currentHour = '${currentDateTime.hour - 12}';
    timePeriod = 'PM';
  }
  else{
    if(currentDateTime.hour < 10){
      currentHour = '0${currentDateTime.hour}';
    }
    else{
      currentHour = '${currentDateTime.hour}';
    }
    timePeriod = 'AM';
  }
  if(currentDateTime.minute < 10){
    currentMinute = '0${currentDateTime.minute}';
  }
  else{
    currentMinute = '${currentDateTime.minute}';
  }
  String currentTime = '$currentHour:$currentMinute $timePeriod';
  return compareTimes(currentTime, referenceTime);
}


String getRideConfirmationReferenceDate(String date, String time){
  List<String> tripDate = date.split('-');
  String referenceDate = '';
  if(time == '07:30 AM'){
    referenceDate = DateTime(
        int.parse(tripDate[0]),
        int.parse(tripDate[1]),
        int.parse(tripDate[2])-1
    ).toString().split(' ')[0];
  }
  else if(time == '05:30 PM'){
    referenceDate = tripDate.join('-');
  }
  return referenceDate;
}

String getRideConfirmationReferenceTime(String time){
  String referenceTime = '';
  if(time == '07:30 AM'){
    referenceTime = '11:30 PM';
  }
  else if(time == '05:30 PM'){
    referenceTime = '04:30 PM';
  }
  return referenceTime;
}

String getRideOrderReferenceDate(String date, String time){
  List<String> tripDate = date.split('-');
  String referenceDate = '';
  if(time == '07:30 AM'){
    referenceDate = DateTime(
        int.parse(tripDate[0]),
        int.parse(tripDate[1]),
        int.parse(tripDate[2])-1
    ).toString().split(' ')[0];
  }
  else if(time == '05:30 PM'){
    referenceDate = tripDate.join('-');
  }
  print(referenceDate);
  return referenceDate;
}

String getRideOrderReferenceTime(String time){
  String referenceTime = '';
  if(time == '07:30 AM'){
    referenceTime = '10:00 PM';
  }
  else if(time == '05:30 PM'){
    referenceTime = '01:00 PM';
  }
  return referenceTime;
}

String getRouteAddingReferenceDate(String date, String time){
  List<String> tripDate = date.split('-');
  String referenceDate = '';
  if(time == '07:30 AM'){
    referenceDate = DateTime(
        int.parse(tripDate[0]),
        int.parse(tripDate[1]),
        int.parse(tripDate[2])-1
    ).toString().split(' ')[0];
  }
  else if(time == '05:30 PM'){
    referenceDate = tripDate.join('-');
  }
  return referenceDate;
}

String getRouteAddingReferenceTime(String time){
  String referenceTime = '';
  if(time == '07:30 AM'){
    referenceTime = '09:00 PM';
  }
  else if(time == '05:30 PM'){
    referenceTime = '12:00 PM';
  }
  return referenceTime;
}