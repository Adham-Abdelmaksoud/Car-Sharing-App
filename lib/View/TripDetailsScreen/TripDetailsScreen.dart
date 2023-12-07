import 'package:flutter/material.dart';

import '../../resources/colors.dart';

class TripDetailsScreen extends StatefulWidget {
  final route;
  const TripDetailsScreen({Key? key, this.route}) : super(key: key);

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
      SizedBox(height: 20,),
      Divider(
        color: Colors.black38,
        thickness: 1,
      ),
      SizedBox(height: 20,),
    ],
  );
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  String paymentType = 'Cash';
  int numberOfSeats = 1;

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
                        child: Padding(
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
                                            Text('Adham Abdelmaksoud',
                                              style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Text('Hyundai Verna',
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
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

                                        Text(widget.route['Time'],
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                      ],
                                    ),

                                    DetailsDivider(),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${widget.route['Cost']} EGP',
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
                              
                              SizedBox(height: 10,),
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
                                  onPressed: (){},
                                  child: Text('Add to Cart',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    )
                                  ),
                                ),
                              ),
                            ],
                          ),
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
