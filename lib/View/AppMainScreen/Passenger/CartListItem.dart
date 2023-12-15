import 'package:flutter/material.dart';
import '../../../Model/Remote/UserDatabase.dart';
import '../../../resources/colors.dart';
import '../../TripDetailsScreen/TripDetailsScreen.dart';

class CartListItem extends StatefulWidget {
  final passengerId;
  final route;
  const CartListItem({Key? key, this.passengerId, this.route}) : super(key: key);

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  UserDatabase userDB = UserDatabase();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TripDetailsScreen(passengerId: widget.passengerId, route: widget.route)
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
                userDB.removeRouteFromPassengerHistory(widget.passengerId, widget.route['Key']);
                setState(() {});
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
