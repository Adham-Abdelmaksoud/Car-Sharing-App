import 'package:car_sharing_app/Model/Remote/RouteDatabase.dart';
import 'package:car_sharing_app/resources/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../resources/colors.dart';
import '../../resources/TimeHelper.dart';
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

  List filterRoutes(List routes, String pickupFilter, String destinationFilter){
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
    DataSnapshot databaseSnapshot = streamSnapshotData.snapshot;
    if(!databaseSnapshot.exists){
      return [];
    }
    Map routesMap = streamSnapshotData.snapshot.value as Map;
    List routesList = routesMap.values.toList();
    List filteredRoutes = filterRoutes(routesList, pickupFilter, destinationFilter);
    return filteredRoutes;
  }

  bool checkIfStarted(Map route){
    String referenceDate = route['Date'];
    String referenceTime = route['Time'];
    if(compareWithCurrentDate(referenceDate) > 0){
      return false;
    }
    else if(compareWithCurrentDate(referenceDate) == 0){
      if(compareWithCurrentTime(referenceTime)){
        return false;
      }
    }
    return true;
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
          AvailableRoutesSearchbar(
            hintText: "Pickup Location",
            icon: Icon(Icons.location_on_outlined),
            onChanged: (value){
              setState(() {
                pickupFilter = value;
              });
            },
          ),

          AvailableRoutesSearchbar(
            hintText: "Destination",
            icon: Icon(Icons.location_on),
            onChanged: (value){
              setState(() {
                destinationFilter = value;
              });
            },
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
                      for(int i=0 ; i<filteredRoutes.length ; i++){
                        if(checkIfStarted(filteredRoutes[i])){
                          routesDB.removeRoute(filteredRoutes[i]['Key']);
                        }
                      }
                      filteredRoutes.sort((a, b) => a['Time'].compareTo(b['Time']));
                      filteredRoutes.sort((a, b) => a['Date'].compareTo(b['Date']));
                      if(filteredRoutes.isEmpty){
                        return Center(
                          child: Text('No Available Routes!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                            )
                          )
                        );
                      }
                      else{
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
