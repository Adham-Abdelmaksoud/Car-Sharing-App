import 'package:car_sharing_app/Model/RouteDatabase.dart';
import 'package:car_sharing_app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutesAdderScreen extends StatefulWidget {
  const RoutesAdderScreen({Key? key}) : super(key: key);

  @override
  State<RoutesAdderScreen> createState() => _RoutesAdderScreenState();
}

class _RoutesAdderScreenState extends State<RoutesAdderScreen> {
  TextEditingController pickupController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController costController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  RouteDatabase routeDB = RouteDatabase();

  Widget textFieldSeparation(){
    return SizedBox(height: 18,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 50, left: 40, right: 40),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add a New Route',
                            style: TextStyle(
                                fontSize: 31,
                                fontWeight: FontWeight.bold
                            )
                        ),

                        textFieldSeparation(),

                        TextFormField(
                          controller: pickupController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Pickup cannot be empty!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text('Pickup')
                          ),
                        ),

                        textFieldSeparation(),

                        TextFormField(
                          controller: destinationController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Destination cannot be empty!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text('Destination')
                          ),
                        ),

                        textFieldSeparation(),

                        TextFormField(
                          controller: timeController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Time cannot be empty!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text('Time')
                          ),
                        ),

                        textFieldSeparation(),

                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: costController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Cost cannot be empty!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text('Cost')
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 60,),

                    ElevatedButton(
                      onPressed: () async{
                        if(formKey.currentState!.validate()){
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          String? userId = prefs.getString('userId');
                          routeDB.addNewRoute(
                            userId!,
                            pickupController.text,
                            destinationController.text,
                            timeController.text,
                            costController.text
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        fixedSize: Size(1000, 50),
                      ),
                      child: Text('Add Route',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                      )
                    )
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
