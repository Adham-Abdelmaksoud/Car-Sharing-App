import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/Remote/UserDatabase.dart';
import '../../resources/colors.dart';

class RoutesListItem extends StatefulWidget {
  final route;
  const RoutesListItem({Key? key, this.route}) : super(key: key);

  @override
  State<RoutesListItem> createState() => _RoutesListItemState();
}

class _RoutesListItemState extends State<RoutesListItem> {
  String addToCartMessage = "";

  UserDatabase userDB = UserDatabase();

  Future<bool> addTripToCart() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    bool statusCode = await userDB.addRouteToPassengerCart(userId!, widget.route);
    return statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
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
              onPressed: () async{
                bool statusCode = await addTripToCart();
                setState(() {
                  addToCartMessage = statusCode? "Trip added to Cart": "Trip already added";
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 750),
                    backgroundColor: secondaryColor,
                    content: Text(addToCartMessage,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                );
              },
              child: Icon(Icons.add,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
