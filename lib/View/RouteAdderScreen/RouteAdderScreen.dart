import 'package:car_sharing_app/Model/Remote/RouteDatabase.dart';
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
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController costController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  RouteDatabase routeDB = RouteDatabase();

  Widget textFieldSeparation(){
    return SizedBox(height: 18,);
  }

  Widget modalButton(String text, TextEditingController controller){
    return ElevatedButton(
      onPressed: (){
        if(text != 'Other'){
          controller.text = text;
        }
        else{
          controller.text = '';
        }
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor
      ),
      child: Text(text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
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
                          onTap: (){
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 100,
                                  child: Container(
                                    color: primaryColor,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          modalButton('Gate 3', pickupController),
                                          modalButton('Gate 4', pickupController),
                                          modalButton('Other', pickupController),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          controller: pickupController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Pickup cannot be empty!';
                            }
                            if(value == 'Gate 3' || value == 'Gate 4'){
                              if(destinationController.text == 'Gate 3' || destinationController.text == 'Gate 4'){
                                return 'Pickup and Destination cannot be both gates!';
                              }
                            }
                            if(value != 'Gate 3' && value != 'Gate 4'){
                              if(destinationController.text != 'Gate 3' && destinationController.text != 'Gate 4'){
                                return 'One of Pickup and Destination must be a gate!';
                              }
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text('Pickup'),
                          ),
                        ),

                        textFieldSeparation(),

                        TextFormField(
                          onTap: (){
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 100,
                                  child: Container(
                                    color: primaryColor,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          modalButton('Gate 3', destinationController),
                                          modalButton('Gate 4', destinationController),
                                          modalButton('Other', destinationController),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          controller: destinationController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Destination cannot be empty!';
                            }
                            if(value == 'Gate 3' || value == 'Gate 4'){
                              if(pickupController.text == 'Gate 3' || pickupController.text == 'Gate 4'){
                                return 'Pickup and Destination cannot be both gates!';
                              }
                            }
                            if(value != 'Gate 3' && value != 'Gate 4'){
                              if(pickupController.text != 'Gate 3' && pickupController.text != 'Gate 4'){
                                return 'One of Pickup and Destination must be a gate!';
                              }
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text('Destination')
                          ),
                        ),

                        textFieldSeparation(),

                        TextFormField(
                          readOnly: true,
                          onTap: () async{
                            DateTime? selectedDateTime = await showDatePicker(
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData(
                                      colorScheme: ColorScheme.fromSeed(
                                        seedColor: primaryColor,
                                        primary: secondaryColor,
                                      ),
                                    ),
                                    child: child ??Text(""),
                                  );
                                },
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100)
                            );
                            if(selectedDateTime != null){
                              dateController.text = selectedDateTime.toString().split(' ')[0];
                            }
                          },
                          controller: dateController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'A Date must be selected!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text('Date')
                          ),
                        ),

                        textFieldSeparation(),

                        TextFormField(
                          readOnly: true,
                          controller: timeController,
                          onTap: (){
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 100,
                                  child: Container(
                                    color: primaryColor,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          modalButton('7:30 AM', timeController),
                                          modalButton('5:30 PM', timeController),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Trip time should be selected!';
                            }
                            if(value == '7:30 AM'){
                              if(destinationController.text != 'Gate 3' && destinationController.text != 'Gate 4'){
                                return '7:30 AM trip should be to one of the gates!';
                              }
                            }
                            if(value == '5:30 PM'){
                              if(pickupController.text != 'Gate 3' && pickupController.text != 'Gate 4'){
                                return '5:30 PM trip should be from one of the gates!';
                              }
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
                            dateController.text,
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
