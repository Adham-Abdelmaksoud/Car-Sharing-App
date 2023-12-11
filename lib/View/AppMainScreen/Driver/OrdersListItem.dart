import 'package:car_sharing_app/Model/UserDatabase.dart';
import 'package:flutter/material.dart';
import '../../../resources/colors.dart';

class OrdersListItem extends StatefulWidget {
  final route;
  const OrdersListItem({Key? key, this.route}) : super(key: key);

  @override
  State<OrdersListItem> createState() => _OrdersListItemState();
}

class _OrdersListItemState extends State<OrdersListItem> {
  UserDatabase userDB = UserDatabase();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
                child: Text(widget.route['Time'],
                  style: TextStyle(
                    fontSize: 16,
                    color: textGreyColor
                  )
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
                        color: textGreyColor,
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
                    ElevatedButton(
                      onPressed: (){
                        userDB.updateRouteStatus('Confirmed',
                            widget.route['DriverId'],
                            widget.route['PassengerId'],
                            widget.route['Key']
                        );
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

                    ElevatedButton(
                      onPressed: (){
                        userDB.updateRouteStatus('Cancelled',
                            widget.route['DriverId'],
                            widget.route['PassengerId'],
                            widget.route['Key']
                        );
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
