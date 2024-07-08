import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/provider/rewards_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  Widget build(BuildContext context) {
    final rewards =
        Provider.of<RewardsProvider>(context, listen: false).rewards;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 223, 255, 223),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize
                        .min, // Ensure the row takes only the necessary space
                    children: [
                      Icon(
                        FontAwesomeIcons.crown,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Gold Tier',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Text(
                  "Your Carbon Footprint",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '16869',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: 5),
                Padding(
                  padding: EdgeInsets.only(top: 45.0),
                  child: Text(
                    'gram',
                    style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  final reward = rewards[index];
                  return SizedBox(
                    height: 130, // Set the desired fixed height
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Logo Container
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            // Add your logo widget here, e.g., Image.asset('assets/logo.png'),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset('assets/everide_logo.jpg')),
                          ),
                          const SizedBox(
                              width: 10), // Spacer between logo and text
                          // Reward details
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                reward.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                reward.amountNeeded,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: tertiaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
