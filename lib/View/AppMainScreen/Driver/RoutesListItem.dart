import 'package:car_sharing_app/Model/Remote/UserDatabase.dart';
import 'package:car_sharing_app/resources/TimeHelper.dart';
import 'package:flutter/material.dart';
import '../../../resources/colors.dart';

class RoutesListItem extends StatefulWidget {
  final route;
  final driverId;
  const RoutesListItem({Key? key, this.route, this.driverId}) : super(key: key);

  @override
  State<RoutesListItem> createState() => _RoutesListItemState();
}

class _RoutesListItemState extends State<RoutesListItem> {
  UserDatabase userDB = UserDatabase();

  String availableAction = 'Start';

  void goToStartState() async{
    userDB.updateTripState('Started', widget.route['DriverId'], widget.route['Key']);
    setState((){
      widget.route['State'] = 'Started';
      availableAction = 'Finish';
    });
  }
  void goToFinishState(){
    userDB.updateTripState('Finished', widget.route['DriverId'], widget.route['Key']);
    setState(() {
      widget.route['State'] = 'Finished';
      availableAction = '';
    });
  }

  void Function()? getButtonFunctionState(){
    if(widget.route['State'] == 'Waiting'){
      return null;
    }
    else if(widget.route['State'] == 'Ready'){
      return goToStartState;
    }
    else if(widget.route['State'] == 'Started'){
      return goToFinishState;
    }
  }
  void Function()? getForcedButtonFunctionState(){
    if(widget.route['State'] == 'Waiting' || widget.route['State'] == 'Ready'){
      return goToStartState;
    }
    else if(widget.route['State'] == 'Started'){
      return goToFinishState;
    }
  }

  void goToCurrentState(){
    if(widget.route['State'] == 'Waiting'){
      if(compareWithCurrentDate(widget.route['Date']) < 0){
        userDB.updateTripState('Ready', widget.route['DriverId'], widget.route['Key']);
        setState(() {
          widget.route['State'] = 'Ready';
          availableAction = 'Start';
        });
      }
      else if(compareWithCurrentDate(widget.route['Date']) == 0){
        if(!compareWithCurrentTime(widget.route['Time'])){
          userDB.updateTripState('Ready', widget.route['DriverId'], widget.route['Key']);
          setState(() {
            widget.route['State'] = 'Ready';
            availableAction = 'Start';
          });
        }
      }
    }
    else if(widget.route['State'] == 'Ready'){
      setState(() {
        availableAction = 'Start';
      });
    }
    else if(widget.route['State'] == 'Started'){
      setState(() {
        availableAction = 'Finish';
      });
    }
  }

  @override
  void initState() {
    goToCurrentState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            minLeadingWidth: 0,
            contentPadding: EdgeInsets.all(0),

            leading: Image.asset('assets/imgs/route_icon.png',),

            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.route['Pickup'],
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 14,),
                Text(widget.route['Destination'],
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            trailing: Transform.translate(
              offset: Offset(0, -10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(widget.route['Date'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textGreyColor
                      )
                  ),
                  Text(widget.route['Time'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textGreyColor
                      )
                  ),
                ],
              ),
            )
          ),

          Text('${widget.route['Cost']} EGP',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: moneyColor,
            )
          ),

          Padding(
            padding: const EdgeInsets.only(top: 3, bottom: 8),
            child: (widget.route['State'] == 'Finished')?
            Center(
              child: Text('Ride is Completed',
                style: TextStyle(
                  color: moneyColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
                :
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: getButtonFunctionState(),
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.black26,
                    backgroundColor: secondaryColor,
                    fixedSize: Size(150, 45)
                  ),
                  child: Text('$availableAction Trip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    )
                  ),
                ),

                SizedBox(width: 15,),

                TextButton(
                  onPressed: getForcedButtonFunctionState(),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          color: errorColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      )
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text('Forced $availableAction Trip',
                        style: TextStyle(
                          fontSize: 16,
                          color: errorColor,
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}