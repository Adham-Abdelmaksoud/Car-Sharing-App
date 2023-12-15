import 'package:car_sharing_app/Model/Remote/RouteDatabase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../resources/colors.dart';
import 'RoutesListItem.dart';

class AvailableRoutesScreen extends StatefulWidget {
  const AvailableRoutesScreen({Key? key}) : super(key: key);

  @override
  State<AvailableRoutesScreen> createState() => _AvailableRoutesScreenState();
}

class _AvailableRoutesScreenState extends State<AvailableRoutesScreen> {
  bool loading = false;
  String pickupFilter = '';
  String destinationFilter = '';

  RouteDatabase routesDB = RouteDatabase();

  List filterRoutes(routes, pickupFilter, destinationFilter){
    List filteredRoutes = List.from(routes);
    if(pickupFilter != ''){
      filteredRoutes = routes.where((element){
        return element['Pickup'].toLowerCase().contains(pickupFilter.toLowerCase()) as bool;
      }).toList();
    }
    if(destinationFilter != ''){
      filteredRoutes = filteredRoutes.where((element){
        return element['Destination'].toLowerCase().contains(destinationFilter.toLowerCase()) as bool;
      }).toList();
    }
    return filteredRoutes;
  }

  List getFilteredRoutesList(DatabaseEvent streamSnapshotData){
    Map routesMap = streamSnapshotData.snapshot.value as Map;
    List routesList = routesMap.values.toList();
    List filteredRoutes = filterRoutes(routesList, pickupFilter, destinationFilter);
    return filteredRoutes;
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
              setState(() {
                pickupFilter = value;
              });
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
              setState(() {
                destinationFilter = value;
              });
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
                child: StreamBuilder(
                  stream: routesDB.getRoutesDatabaseReference().onValue,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      List filteredRoutes = getFilteredRoutesList(snapshot.data!);
                      return ListView.builder(
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
                      );
                    }
                    else if(snapshot.hasError){
                      return Center(child: Text('Some Error Occurred!'));
                    }
                    else{
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      );
                    }
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
