import 'package:car_sharing_app/View/AvailableRoutesScreen/AvailableRoutesScreen.dart';
import 'package:car_sharing_app/resources/colors.dart';
import 'package:flutter/material.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  void navigateToAvailableRoutes(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AvailableRoutesScreen()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            color: primaryColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 17, left: 10, right: 10),
                  child: Image.asset('assets/imgs/google_maps.png'),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Container(
                            color: bluishWhite,
                            child: TextField(
                              readOnly: true,
                              onTap: (){
                                navigateToAvailableRoutes();
                              },
                              decoration: InputDecoration(
                                hintText: 'Pickup Location',
                                prefixIcon: Icon(Icons.location_on_outlined),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: Colors.black87),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 25,),

                        SizedBox(
                          child: Container(
                            color: bluishWhite,
                            child: TextField(
                              readOnly: true,
                              onTap: (){
                                navigateToAvailableRoutes();
                              },
                              decoration: InputDecoration(
                                hintText: 'Destination',
                                prefixIcon: Icon(Icons.location_on),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: Colors.black87),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 25,),

                        ElevatedButton(
                          onPressed: (){
                            navigateToAvailableRoutes();
                          },
                          child: Text('Find a Ride',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white
                            ),
                          ),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            fixedSize: Size(1000, 53),
                            backgroundColor: secondaryColor
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
