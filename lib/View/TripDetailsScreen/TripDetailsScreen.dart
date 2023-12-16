import 'package:flutter/material.dart';

import '../../Model/Remote/UserDatabase.dart';
import '../../resources/colors.dart';

class TripDetailsScreen extends StatefulWidget {
  final route;
  final passengerId;
  const TripDetailsScreen({Key? key, this.passengerId, this.route}) : super(key: key);

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

Widget SectionTitle(String title){
  return Text(title,
    style: TextStyle(
      fontSize: 37,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget DetailsDivider(){
  return Column(
    children: [
      SizedBox(height: 17,),
      Divider(
        color: Colors.black38,
        thickness: 1,
      ),
      SizedBox(height: 17,),
    ],
  );
}

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

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  String paymentType = 'Cash';
  int numberOfSeats = 1;
  int totalPrice = 0;

  UserDatabase userDB = UserDatabase();

  void submitOrder(){
    widget.route['Cost'] = totalPrice;
    widget.route['Seats'] = numberOfSeats;
    widget.route['Payment'] = paymentType;
    widget.route['Status'] = 'Pending';
    widget.route['PassengerId'] = widget.passengerId;
    userDB.submitOrder(widget.route);
  }

  void handleConfirmOrder(){
    List<String> tripDate = widget.route['Date'].split('-');
    String tripTime = widget.route['Time'];
    String referenceDate = '';
    String referenceTime = '';
    if(tripTime == '7:30 AM'){
      referenceTime = '10:00 PM';
      referenceDate = DateTime(
          int.parse(tripDate[0]),
          int.parse(tripDate[1]),
          int.parse(tripDate[2])-1
      ).toString().split(' ')[0];
    }
    else if(tripTime == '5:30 PM'){
      referenceTime = '01:00 PM';
      referenceDate = tripDate.join('-');
    }
    if(compareWithCurrentDate(referenceDate) > 0){
      submitOrder();
      Navigator.pop(context);
    }
    else if(compareWithCurrentDate(referenceDate) == 0){
      if(compareWithCurrentTime(referenceTime)){
        submitOrder();
        Navigator.pop(context);
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: darkRedColor,
            content: Text('This Trip has Expired!',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          )
      );
    }
  }

  Future<Map> getDriverData(String driverId) async{
    Map driverData = await userDB.getUserInfo(driverId);
    return driverData;
  }

  @override
  void initState() {
    totalPrice = int.parse(widget.route['Cost']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Stack(
                  children: [
                    Image.asset('assets/imgs/details_bg.jpg'),

                    Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                        ),
                        child: FutureBuilder(
                          future: getDriverData(widget.route['DriverId']),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SectionTitle('Trip Details'),

                                    SizedBox(height: 35,),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset('assets/imgs/user.png',
                                                height: 60,
                                              ),
                                              SizedBox(width: 15,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data!['Username'],
                                                    style: TextStyle(
                                                        fontSize: 19,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  // Text('Hyundai Verna',
                                                  //   style: TextStyle(
                                                  //     fontSize: 17,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ]
                                          ),

                                          DetailsDivider(),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset('assets/imgs/route_icon1.png',
                                                    height: 90,
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(widget.route['Pickup'],
                                                        style: TextStyle(
                                                          fontSize: 19,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      SizedBox(height: 35,),
                                                      Text(widget.route['Destination'],
                                                        style: TextStyle(
                                                          fontSize: 19,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(widget.route['Date'],
                                                    style: TextStyle(
                                                      fontSize: 19,
                                                    ),
                                                  ),
                                                  Text(widget.route['Time'],
                                                    style: TextStyle(
                                                      fontSize: 19,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                          DetailsDivider(),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${totalPrice} EGP',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: moneyColor
                                                ),
                                              ),

                                              Column(
                                                children: [
                                                  Text('Number of Seats',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold
                                                      )
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                        onPressed: (){
                                                          setState(() {
                                                            numberOfSeats++;
                                                            totalPrice = numberOfSeats * int.parse(widget.route['Cost']);
                                                          });
                                                        },
                                                        icon: Icon(Icons.add_circle_outline,
                                                          size: 28,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      Text(numberOfSeats.toString(),
                                                          style: TextStyle(
                                                            fontSize: 22,
                                                          )
                                                      ),

                                                      IconButton(
                                                        onPressed: (){
                                                          if(numberOfSeats > 1){
                                                            setState(() {
                                                              numberOfSeats--;
                                                              totalPrice = numberOfSeats * int.parse(widget.route['Cost']);
                                                            });
                                                          }
                                                        },
                                                        icon: Icon(Icons.remove_circle_outline,
                                                          size: 28,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    DetailsDivider(),

                                    SizedBox(height: 18,),
                                    SectionTitle('Payment'),
                                    SizedBox(height: 25,),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                              value: 'Credit Card',
                                              groupValue: paymentType,
                                              onChanged: (value){
                                                setState(() {
                                                  paymentType = value!;
                                                });
                                              }
                                            ),
                                            Text('Credit Card',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Column(
                                            children: [
                                              TextField(
                                                decoration: InputDecoration(
                                                  label: Text('Card Number',
                                                    style: TextStyle(
                                                      fontSize: 18
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                        label: Text('Expiration Date',
                                                          style: TextStyle(
                                                            fontSize: 18
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 30,),

                                                  Expanded(
                                                    flex: 1,
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                        label: Text('CVV',
                                                          style: TextStyle(
                                                            fontSize: 18
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              TextField(
                                                decoration: InputDecoration(
                                                  label: Text('Card Holder Name',
                                                    style: TextStyle(
                                                      fontSize: 18
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 30,),

                                        Row(
                                          children: [
                                            Radio(
                                              value: 'Cash',
                                              groupValue: paymentType,
                                              onChanged: (value){
                                                setState(() {
                                                  paymentType = value!;
                                                });
                                              }
                                            ),
                                            Text('Cash',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 40,),

                                    SizedBox(
                                      height: 45,
                                      width: 1000,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: secondaryColor,
                                        ),
                                        onPressed: (){
                                          handleConfirmOrder();
                                        },
                                        child: Text('Confirm Order',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            else if(snapshot.hasError){
                              return Center(
                                child: Text('Some Error Occurred!'),
                              );
                            }
                            else{
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
                                ),
                              );
                            }
                          }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Positioned(
            top: 25,
            left: 10,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,
                size: 32,
                color: Colors.black,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(6),
                backgroundColor: primaryColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}
