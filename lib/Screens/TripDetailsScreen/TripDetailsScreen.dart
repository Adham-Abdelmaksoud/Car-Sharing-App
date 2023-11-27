import 'package:flutter/material.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          Image.asset('assets/imgs/details_bg.jpg'),

          ElevatedButton(
            onPressed: () {},
            child: Icon(Icons.arrow_back,
              size: 32,
              color: Colors.black,
            ),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(6),
              backgroundColor: Colors.white70
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Trip Details',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20,),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Driver: Adham Abdelmaksoud',
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),

                          Text('Car: Hyundai Verna',
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),

                          SizedBox(height: 20,),

                          Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              Text('Pickup: El Rehab',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(Icons.location_on),
                              Text('Destination: Abbaseya',
                                style: TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20,),

                          Text('Pickup Time: 5:30 PM',
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),

                          SizedBox(height: 20,),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Fee: 50 EGP',
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.add_circle_outline,
                                size: 29,
                              ),
                            ),

                            Text('1 Seat',
                              style: TextStyle(
                                fontSize: 22,
                              )
                            ),

                            IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.remove_circle_outline,
                                size: 29,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 90,),

                    SizedBox(
                      height: 38,
                      width: 1000,
                      child: ElevatedButton(
                        onPressed: (){},
                        child: Text('Add to Cart'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
