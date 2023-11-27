import 'package:flutter/material.dart';
import '../../resources/colors.dart';
import 'RoutesListItem.dart';

class AvailableRoutesScreen extends StatefulWidget {
  const AvailableRoutesScreen({Key? key}) : super(key: key);

  @override
  State<AvailableRoutesScreen> createState() => _AvailableRoutesScreenState();
}

class _AvailableRoutesScreenState extends State<AvailableRoutesScreen> {
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
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index){
                    return Card(
                      color: primaryColor,
                      child: RoutesListItem(),
                    );
                  }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
