import 'package:flutter/material.dart';
import '../../../Model/Remote/UserDatabase.dart';
import '../../../resources/colors.dart';

class OrdersListItem extends StatefulWidget {
  final route;
  const OrdersListItem({Key? key, this.route}) : super(key: key);

  @override
  State<OrdersListItem> createState() => _OrdersListItemState();
}

class _OrdersListItemState extends State<OrdersListItem> {
  UserDatabase userDB = UserDatabase();

  Map passengerInfo = {};

  Color getStatusColor(String status){
    if(status == 'Pending'){
      return textGreyColor;
    }
    else if(status == 'Confirmed' || status == 'Finished'){
      return moneyColor;
    }
    else if(status == 'Cancelled' || status == 'Expired'){
      return errorColor;
    }
    else if(status == 'Started'){
      return secondaryColor;
    }
    return textGreyColor;
  }

  void setPassengerInfo() async{
    passengerInfo = await userDB.getUserInfo(widget.route['PassengerId']);
  }

  @override
  void initState() {
    setPassengerInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Passenger: ',
                          style: TextStyle(color: textGreyColor,),
                        ),
                        TextSpan(
                          text: passengerInfo['Username'],
                          style: TextStyle(color: secondaryColor),
                        )
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 5,
            thickness: 0.5,
            color: textGreyColor,
          ),

          ListTile(
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.all(0),

              leading: Image.asset('assets/imgs/route_icon.png',),

              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.route['Pickup'],
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 14,),
                  Text(widget.route['Destination'],
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              trailing: Transform.translate(
                offset: Offset(0, -10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(widget.route['Date'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textGreyColor
                      )
                    ),
                    Text(widget.route['Time'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textGreyColor
                      )
                    ),
                  ],
                ),
              )
          ),

          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('Status: ${widget.route['Status']}',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: getStatusColor(widget.route['Status']),
                      )
                    ),
                  ),

                  Column(
                    children: [
                      Row(
                        children: [
                          Text('Seats: ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: textGreyColor,
                            )
                          ),
                          Text(widget.route['Seats'].toString(),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            )
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text('${widget.route['Payment']}: ',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: textGreyColor,
                            )
                          ),
                          Text('${widget.route['Cost']} EGP',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: moneyColor,
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            if(widget.route['Status'] == 'Pending'){
                              userDB.updateRouteStatus('Confirmed',
                                  widget.route['DriverId'],
                                  widget.route['PassengerId'],
                                  widget.route['Key']
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            fixedSize: Size(150, 45)
                          ),
                          child: Text('Confirm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            )
                          ),
                        ),

                        TextButton(
                          onPressed: (){
                            userDB.updateRouteStatus('Confirmed',
                                widget.route['DriverId'],
                                widget.route['PassengerId'],
                                widget.route['Key']
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: secondaryColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                )
                            ),
                          ),
                          child: Text('Forced Confirm',
                              style: TextStyle(
                                fontSize: 16,
                                color: secondaryColor,
                              )
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            if(widget.route['Status'] == 'Pending') {
                              userDB.updateRouteStatus('Cancelled',
                                  widget.route['DriverId'],
                                  widget.route['PassengerId'],
                                  widget.route['Key']
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: errorColor,
                            fixedSize: Size(150, 45)
                          ),
                          child: Text('Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            )
                          ),
                        ),

                        TextButton(
                          onPressed: (){
                            userDB.updateRouteStatus('Cancelled',
                                widget.route['DriverId'],
                                widget.route['PassengerId'],
                                widget.route['Key']
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: errorColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                )
                            ),
                          ),
                          child: Text('Forced Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                color: errorColor,
                              )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
