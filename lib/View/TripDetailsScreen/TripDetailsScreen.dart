import 'package:car_sharing_app/resources/widgets.dart';
import 'package:flutter/material.dart';

import '../../Model/Remote/UserDatabase.dart';
import '../../resources/colors.dart';
import '../../resources/TimeHelper.dart';
import 'DetailsSections.dart';

class TripDetailsScreen extends StatefulWidget {
  final route;
  final passengerId;
  const TripDetailsScreen({Key? key, this.passengerId, this.route}) : super(key: key);

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
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
    widget.route['OrderDateTime'] = DateTime.now().toString();
    userDB.submitOrder(widget.route);

    Navigator.pop(context);
    ShowSnackBar(context, 'Order Confirmed Successfully', 1000, moneyColor);
  }

  void handleConfirmOrder(){
    String referenceDate = getRideOrderReferenceDate(widget.route['Date'], widget.route['Time']);
    String referenceTime = getRideOrderReferenceTime(widget.route['Time']);
    if(compareWithCurrentDate(referenceDate) > 0){
      submitOrder();
    }
    else if(compareWithCurrentDate(referenceDate) == 0){
      if(compareWithCurrentTime(referenceTime)){
        submitOrder();
      }
    }
    else{
      ShowSnackBar(context, 'This Trip has Expired!', 1200, darkRedColor);
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
                                          DriverDetails(snapshot.data!['Username'], snapshot.data!['PhoneNumber']),

                                          DetailsDivider(),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              PickupDestinationDetails(widget.route['Pickup'], widget.route['Destination']),

                                              DateTimeDetails(widget.route['Date'], widget.route['Time'])
                                            ],
                                          ),

                                          DetailsDivider(),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              TotalPriceDetails(totalPrice),

                                              SeatsDetails(
                                                numberOfSeats: numberOfSeats,
                                                onIncrease: (){
                                                  if(numberOfSeats < 6){
                                                    setState(() {
                                                      numberOfSeats++;
                                                      totalPrice = numberOfSeats * int.parse(widget.route['Cost']);
                                                    });
                                                  }
                                                },
                                                onDecrease: (){
                                                  if(numberOfSeats > 1){
                                                    setState(() {
                                                      numberOfSeats--;
                                                      totalPrice = numberOfSeats * int.parse(widget.route['Cost']);
                                                    });
                                                  }
                                                },
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
                                        PaymentRadioButton(
                                          value: 'Credit Card',
                                          groupValue: paymentType,
                                          onChanged: (value){
                                            setState(() {
                                              paymentType = value!;
                                            });
                                          }
                                        ),

                                        CreditCardDetails(),

                                        SizedBox(height: 30,),

                                        PaymentRadioButton(
                                          value: 'Cash',
                                          groupValue: paymentType,
                                          onChanged: (value){
                                            setState(() {
                                              paymentType = value!;
                                            });
                                          }
                                        )
                                      ],
                                    ),

                                    SizedBox(height: 40,),

                                    Column(
                                      children: [
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

                                        SizedBox(height: 13,),

                                        TextButton(
                                          onPressed: (){
                                            submitOrder();
                                          },
                                          style: ButtonStyle(
                                            fixedSize: MaterialStatePropertyAll(Size(280, 0)),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: darkRedColor,
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.circular(20),
                                              )
                                            ),
                                          ),
                                          child: Text('Forced Confirm Order',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: darkRedColor,
                                            )
                                          ),
                                        ),
                                      ],
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
