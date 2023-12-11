import 'package:car_sharing_app/resources/colors.dart';
import 'package:flutter/material.dart';

import '../../../Model/UserDatabase.dart';
import 'CartListItem.dart';

class CartFragment extends StatefulWidget {
  final String userId;
  const CartFragment({Key? key, required this.userId}) : super(key: key);

  @override
  State<CartFragment> createState() => _CartFragmentState();
}

class _CartFragmentState extends State<CartFragment> {
  UserDatabase userDB = UserDatabase();

  Future<List> getCartList() async{
    List cartItems = await userDB.getPassengerCartRoutes(widget.userId);
    return cartItems;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCartList(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Container(
            decoration: BoxDecoration(
                color: bluishWhite
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return Card(
                        color: primaryColor,
                        child: CartListItem(userId: widget.userId, route: snapshot.data![index])
                      );
                    }
                ),
              ),
            ),
          );
        }
        else if(snapshot.hasError){
          return Container(
            color: Colors.black,
            child: Center(
              child: Text('Cart is Empty!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                )
              )
            ),
          );
        }
        else{
          return Container(
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
          );
        }
      },
    );
  }
}
