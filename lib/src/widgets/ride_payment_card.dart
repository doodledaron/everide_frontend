import 'package:flutter/material.dart';


import '../constants/app_contants.dart';
import '../constants/colors.dart';

class RidePaymentCard extends StatefulWidget {
  final int carbonValue;

  const RidePaymentCard({
    super.key,
    required this.carbonValue,
  });

  @override
  State<RidePaymentCard> createState() => _RidePaymentCardState();
}

class _RidePaymentCardState extends State<RidePaymentCard> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: "cash",
        child: Row(
          children: [
            Icon(Icons.attach_money_rounded),
            SizedBox(
              width: 10,
            ),
            Text("cash"),
          ],
        ),
      ),
      const DropdownMenuItem(
        value: "card",
        child: Row(
          children: [
            Icon(Icons.add_card),
            SizedBox(
              width: 10,
            ),
            Text("card"),
          ],
        ),
      ),
      const DropdownMenuItem(
        value: "e-wallet",
        child: Row(
          children: [
            Icon(Icons.mobile_friendly_rounded),
            SizedBox(
              width: 10,
            ),
            Text("e-wallet"),
          ],
        ),
      ),
    ];
    return menuItems;
  }

  String selectedValue = "cash";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(kBorderRadiusCards),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/car.jpg',
                          width: 80,
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Container(
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Any Ride ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            'Up to 4 pax + 2 baggage',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    Text(
                      'RM69',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                  width: 150,
                  child: DropdownButtonFormField(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(15),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: secondaryColor,
                    ),
                    dropdownColor: secondaryColor,
                    value: selectedValue,
                    items: dropdownItems,
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                      // print(selectedValue);
                    },
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          )),
    );
  }
}
