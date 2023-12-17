import 'package:flutter/material.dart';

import '../../resources/colors.dart';

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

Widget DriverDetails(String driverName){
  return Row(
    children: [
      Image.asset('assets/imgs/user.png',
        height: 60,
      ),
      SizedBox(width: 15,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(driverName,
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
  );
}

Widget PickupDestinationDetails(String pickup, String destination){
  return Row(
    children: [
      Image.asset('assets/imgs/route_icon1.png',
        height: 90,
      ),
      SizedBox(width: 10,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pickup,
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 35,),
          Text(destination,
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    ],
  );
}

Widget DateTimeDetails(String date, String time){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(date,
        style: TextStyle(
          fontSize: 19,
        ),
      ),
      Text(time,
        style: TextStyle(
          fontSize: 19,
        ),
      ),
    ],
  );
}

Widget TotalPriceDetails(int totalPrice){
  return Text('${totalPrice} EGP',
    style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: moneyColor
    ),
  );
}

Widget SeatsDetails({
  required int numberOfSeats,
  required void Function()? onIncrease,
  required void Function()? onDecrease,
}){
  return Column(
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
            onPressed: onIncrease,
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
            onPressed: onDecrease,
            icon: Icon(Icons.remove_circle_outline,
              size: 28,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget CreditCardDetails(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
  );
}