import 'package:car_sharing_app/resources/colors.dart';
import 'package:flutter/material.dart';

import 'RoutesListItem.dart';


class HistoryFragment extends StatefulWidget {
  const HistoryFragment({Key? key}) : super(key: key);

  @override
  State<HistoryFragment> createState() => _HistoryFragmentState();
}

class _HistoryFragmentState extends State<HistoryFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index){
            return Card(
              color: primaryColor,
              child: RoutesListItem()
            );
          }
      ),
    );
  }
}
