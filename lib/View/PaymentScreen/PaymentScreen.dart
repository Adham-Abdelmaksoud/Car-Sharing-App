import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 25,),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 70, right: 20, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total:',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 22,
                            ),
                          ),

                          SizedBox(height: 28,),

                          Center(
                            child: Text('150 EGP',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 13,),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 'Credit Card',
                                groupValue: 'Payment',
                                onChanged: (value){}
                              ),

                              Text('Credit Card',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    label: Text('Card Number',
                                      style: TextStyle(
                                        fontSize: 18
                                      ),
                                    ),
                                  ),
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          label: Text('Expiration Date',
                                            style: TextStyle(
                                                fontSize: 18
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 30,),

                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          label: Text('CVV',
                                            style: TextStyle(
                                                fontSize: 18
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                TextField(
                                  decoration: InputDecoration(
                                    label: Text('Card Holder Name',
                                      style: TextStyle(
                                          fontSize: 18
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 30,),

                          Row(
                            children: [
                              Radio(
                                  value: 'Cash',
                                  groupValue: 'Payment',
                                  onChanged: (value){}
                              ),

                              Text('Cash',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 28,),

                  ElevatedButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(1000, 50),
                    ),
                    onPressed: (){},
                    child: Text('Checkout',)
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
