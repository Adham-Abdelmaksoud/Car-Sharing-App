import 'package:car_sharing_app/resources/colors.dart';
import 'package:flutter/material.dart';

import 'RoutesListItem.dart';

class CartFragment extends StatefulWidget {
  const CartFragment({Key? key}) : super(key: key);

  @override
  State<CartFragment> createState() => _CartFragmentState();
}

class _CartFragmentState extends State<CartFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bluishWhite
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index){
                      return Card(
                        color: primaryColor,
                        child: RoutesListItem()
                      );
                    }
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            child: ElevatedButton(
              onPressed: (){},
              child: Text('Make Payment',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                fixedSize: Size(1000, 45),
                backgroundColor: secondaryColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}
