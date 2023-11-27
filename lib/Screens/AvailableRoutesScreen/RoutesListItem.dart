import 'package:flutter/material.dart';
import '../../resources/colors.dart';

class RoutesListItem extends StatefulWidget {
  const RoutesListItem({Key? key}) : super(key: key);

  @override
  State<RoutesListItem> createState() => _RoutesListItemState();
}

class _RoutesListItemState extends State<RoutesListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
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
                Text('El Rehab',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 14,),
                Text('Abbaseya',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            trailing: Transform.translate(
              offset: Offset(0, -10),
              child: Text('5:30 PM',
                  style: TextStyle(
                    fontSize: 16,
                    color: textGreyColor
                  )
              ),
            )
          ),

          Text('50 EGP',
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
