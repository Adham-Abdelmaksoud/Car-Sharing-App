import 'package:car_sharing_app/Model/RouteDatabase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../../resources/colors.dart';
import 'RoutesListItem.dart';

class AvailableRoutesScreen extends StatefulWidget {
  const AvailableRoutesScreen({Key? key}) : super(key: key);

  @override
  State<AvailableRoutesScreen> createState() => _AvailableRoutesScreenState();
}

class _AvailableRoutesScreenState extends State<AvailableRoutesScreen> {
  List actualRoutes = [];
  List filteredRoutes = [];
  bool loading = false;

  RouteDatabase routesDB = RouteDatabase();

  void getRoutesList() async{
    setState(() {
      loading = true;
    });
    actualRoutes = await routesDB.getAllRoutes();
    filteredRoutes = List.from(actualRoutes);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getRoutesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 5,
      ),
      body: Column(
        children: [
          TextField(
            cursorColor: secondaryColor,
            onChanged: (value){
              if(value != ''){
                setState(() {
                  filteredRoutes = actualRoutes.where((element){
                    return element['Pickup'].toLowerCase().contains(value.toLowerCase());
                  }).toList();
                });
              }
              else{
                setState(() {
                  filteredRoutes = List.from(actualRoutes);
                });
              }
            },
            decoration: InputDecoration(
              hintText: 'Pickup Location',
              prefixIcon: Icon(Icons.location_on_outlined),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: secondaryColor
                  )
              ),
              iconColor: secondaryColor
            ),
          ),

          TextField(
            cursorColor: secondaryColor,
            onChanged: (value){
              if(value != ''){
                setState(() {
                  filteredRoutes = actualRoutes.where((element){
                      return element['Destination'].toLowerCase().contains(value.toLowerCase());
                  }).toList();
                });
              }
              else{
                setState(() {
                  filteredRoutes = List.from(actualRoutes);
                });
              }
            },
            decoration: InputDecoration(
              hintText: 'Destination',
              prefixIcon: Icon(Icons.location_on),
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: loading? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ) : ListView.builder(
                  itemCount: filteredRoutes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                      child: Card(
                        color: primaryColor,
                        child: RoutesListItem(
                          route: filteredRoutes[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
