import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isDefaultPaymentMethod = false;
  final List<Transaction> transactions = [
    Transaction('Payment', '-RM 10.00', '24/05/2024 8:20 PM'),
    Transaction('Payment', '-RM 3.50', '24/05/2024 12:43 PM'),
    Transaction('Carbon Footprint Earning', '+RM 1.00', '24/05/2024 12:00 AM'),
    Transaction('Payment', '-RM 4.80', '22/05/2024 6:09 PM'),
    Transaction('Payment', '-RM 15.00', '22/05/2024 1:56 PM'),
    Transaction('Carbon Footprint Earning', '+RM 0.90', '22/05/2024 12:00 AM'),
    Transaction('Payment', '-RM 7.00', '20/05/2024 10:12 PM'),
    Transaction('Payment', '-RM 2.89', '20/05/2024 10:10 AM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  "EveRide Wallet",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(), // Add some spacing between the text and the avatar
                CircleAvatar(
                  radius: 30,
                  backgroundColor: primaryColor,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'RM',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.green[800],
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  '0.00',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
              ],
            ),
            const SizedBox(
                height: 10), // Add spacing between balance and buttons
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle button press
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15), // Set the desired border radius here
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Top Up',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                                width:
                                    5), // Add some space between icon and text
                            Icon(
                              Icons.wallet,
                              color: Colors.black,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle button press
                        },
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15), // Set the desired border radius here
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Send Money',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                                width:
                                    5), // Add some space between icon and text
                            Icon(
                              Icons.send,
                              color: Colors.black,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const Text(
                  'Set as default payment method',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                CupertinoSwitch(
                    value: isDefaultPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        isDefaultPaymentMethod = value;
                      });
                    })
              ],
            ),
            Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: const Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(transactions[index].title,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(transactions[index].time),
                        trailing: Text(transactions[index].amount,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                        height: 1,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final String title;
  final String amount;
  final String time;

  Transaction(this.title, this.amount, this.time);
}
