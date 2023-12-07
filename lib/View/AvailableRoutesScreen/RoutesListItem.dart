import 'package:car_sharing_app/View/TripDetailsScreen/TripDetailsScreen.dart';
import 'package:flutter/material.dart';
import '../../resources/colors.dart';

class RoutesListItem extends StatefulWidget {
  final route;
  const RoutesListItem({Key? key, this.route}) : super(key: key);

  @override
  State<RoutesListItem> createState() => _RoutesListItemState();
}

class _RoutesListItemState extends State<RoutesListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TripDetailsScreen(route: widget.route)
                )
              );
            },
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
              child: Text(widget.route['Time'],
                  style: TextStyle(
                    fontSize: 16,
                    color: textGreyColor
                  )
              ),
            )
          ),

          Text('${widget.route['Cost']} EGP',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: moneyColor,
              )
          )
        ],
      ),
    );
  }
}
