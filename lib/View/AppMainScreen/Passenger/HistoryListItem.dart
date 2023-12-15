import 'package:flutter/material.dart';
import '../../../resources/colors.dart';

class HistoryListItem extends StatefulWidget {
  final route;
  const HistoryListItem({Key? key, this.route}) : super(key: key);

  @override
  State<HistoryListItem> createState() => _HistoryListItemState();
}

class _HistoryListItemState extends State<HistoryListItem> {
  Color getStatusColor(String status){
    if(status == 'Pending'){
      return textGreyColor;
    }
    else if(status == 'Confirmed'){
      return moneyColor;
    }
    else if(status == 'Cancelled'){
      return errorColor;
    }
    return primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('Status: ${widget.route['Status']}',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: getStatusColor(widget.route['Status']),
                  )
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text('Seats: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: textGreyColor,
                        )
                      ),
                      Text(widget.route['Seats'].toString(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        )
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text('${widget.route['Payment']}: ',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: textGreyColor,
                        )
                      ),
                      Text('${widget.route['Cost']} EGP',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: moneyColor,
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
