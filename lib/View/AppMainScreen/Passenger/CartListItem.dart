import 'package:car_sharing_app/Model/UserDatabase.dart';
import 'package:flutter/material.dart';
import '../../../resources/colors.dart';
import '../../TripDetailsScreen/TripDetailsScreen.dart';

class CartListItem extends StatefulWidget {
  final userId;
  final route;
  const CartListItem({Key? key, this.userId, this.route}) : super(key: key);

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  UserDatabase userDB = UserDatabase();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TripDetailsScreen(passengerId: widget.userId, route: widget.route)
                )
              );
            },
            minLeadingWidth: 0,
            contentPadding: EdgeInsets.all(0),

            leading: Image.asset('assets/imgs/route_icon.png',),

            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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

                Column(
                  children: [
                    Text(widget.route['Time'],
                        style: TextStyle(
                            fontSize: 16,
                            color: textGreyColor
                        )
                    ),
                    SizedBox(height: 18,),
                    Text('${widget.route['Cost']} EGP',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: moneyColor,
                        )
                    ),
                  ],
                )
              ],
            ),
          ),

          SizedBox(
            height: 45,
            width: 45,
            child: FloatingActionButton(
              backgroundColor: secondaryColor,
              onPressed: (){
                userDB.removeRouteFromPassengerHistory(widget.userId, widget.route['Key']);
              },
              child: Icon(Icons.remove,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
