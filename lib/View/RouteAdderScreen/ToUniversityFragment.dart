import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/Remote/RouteDatabase.dart';
import '../../resources/TimeHelper.dart';
import '../../resources/colors.dart';

class ToUniversityFragment extends StatefulWidget {
  const ToUniversityFragment({Key? key}) : super(key: key);

  @override
  State<ToUniversityFragment> createState() => _ToUniversityFragmentState();
}

class _ToUniversityFragmentState extends State<ToUniversityFragment> {
  TextEditingController pickupController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController(text: '07:30 AM');
  TextEditingController costController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  RouteDatabase routeDB = RouteDatabase();

  String destinationItem = '';
  List<String> universityGates = [
    'Gate 3',
    'Gate 4'
  ];
  bool failedAdding = false;
  String errorMessage = '';
  bool addingValid = true;


  void addTrip() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    routeDB.addNewRoute(
        userId!,
        pickupController.text,
        destinationItem,
        dateController.text,
        timeController.text,
        costController.text
    );
    Navigator.pop(context);
  }


  void handleAddingNewRoute() async{
    String referenceDate = getRouteAddingReferenceDate(dateController.text, timeController.text);
    String referenceTime = getRouteAddingReferenceTime(timeController.text);
    if(compareWithCurrentDate(referenceDate) > 0){
      addTrip();
    }
    else if(compareWithCurrentDate(referenceDate) == 0){
      if(compareWithCurrentTime(referenceTime)){
        addTrip();
      }
    }
    else{
      setState(() {
        failedAdding = true;
        errorMessage = "Trip date and time are too soon";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget textFieldSeparation(){
      return SizedBox(height: 27,);
    }

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: pickupController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Pickup cannot be empty!';
                  }
                  if(value.replaceAll(" ", "").toLowerCase() == 'gate3' || value.replaceAll(" ", "").toLowerCase() == 'gate4'){
                    return 'Pickup must not be a university gate!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Pickup',),
                  border: OutlineInputBorder(),
                ),
              ),

              textFieldSeparation(),

              DropdownButtonFormField(
                onChanged: (value) {
                  destinationItem = value!;
                },
                hint: Text('Destination',),
                decoration: InputDecoration(
                    border: OutlineInputBorder()
                ),
                dropdownColor: primaryColor,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Destination cannot be empty!';
                  }
                  return null;
                },
                items: universityGates.map((value){
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
                    border: OutlineInputBorder(),
                    label: Text('Date')
                ),
              ),

              textFieldSeparation(),

              TextFormField(
                readOnly: true,
                controller: timeController,
                decoration: InputDecoration(
                    label: Text('Time'),
                    border: OutlineInputBorder()
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
                    label: Text('Cost'),
                    border: OutlineInputBorder()
                ),
              )
            ],
          ),

          SizedBox(height: 60,),

          Column(
            children: [
              ElevatedButton(
                onPressed: () async{
                  if(formKey.currentState!.validate()){
                    handleAddingNewRoute();
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
              ),

              SizedBox(height: 8,),

              Text(errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: errorColor,
                  fontSize: failedAdding? 14: 0
                ),
              ),

              SizedBox(height: 8,),

              TextButton(
                onPressed: (){
                  addTrip();
                },
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(280, 0)),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          color: darkRedColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),
                child: Text('Forced Add Route',
                    style: TextStyle(
                      fontSize: 16,
                      color: darkRedColor,
                    )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
