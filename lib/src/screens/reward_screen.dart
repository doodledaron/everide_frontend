import 'package:everide_frontend/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Reward {
  final String imageUrl;
  final String title;
  final String description;
  final String amountNeeded;

  Reward({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.amountNeeded,
  });
}

class RewardScreen extends StatelessWidget {
  RewardScreen({super.key});

  static const String url =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Touch_%27n_Go_eWallet_logo.svg/1200px-Touch_%27n_Go_eWallet_logo.svg.png';

  final List<Reward> rewards = [
    Reward(
      imageUrl: url,
      title: 'Everide Wallet Credit RM5',
      description: 'Get RM1 credit to your Everide wallet',
      amountNeeded: 'Spend 10000 carbon footprint',
    ),
    Reward(
      imageUrl: url,
      title: 'Everide Wallet Credit RM5',
      description: 'Get RM1 credit to your Everide wallet',
      amountNeeded: 'Spend 10000 carbon footprint',
    ),
    Reward(
      imageUrl: url,
      title: 'Everide Wallet Credit RM5',
      description: 'Get RM1 credit to your Everide wallet',
      amountNeeded: 'Spend 10000 carbon footprint',
    ),
    Reward(
      imageUrl: url,
      title: 'Everide Wallet Credit RM5',
      description: 'Get RM1 credit to your Everide wallet',
      amountNeeded: 'Spend 10000 carbon footprint',
    ),
    Reward(
      imageUrl: url,
      title: 'Everide Wallet Credit RM5',
      description: 'Get RM1 credit to your Everide wallet',
      amountNeeded: 'Spend 10000 carbon footprint',
    ),
    Reward(
      imageUrl: url,
      title: 'Everide Wallet Credit RM5',
      description: 'Get RM1 credit to your Everide wallet',
      amountNeeded: 'Spend 10000 carbon footprint',
    ),
    Reward(
      imageUrl: url,
      title: 'Everide Wallet Credit RM5',
      description: 'Get RM1 credit to your Everide wallet',
      amountNeeded: 'Spend 10000 carbon footprint',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor: backgroundColor),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '16869',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: Text(
                    'gram',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.green[800],
                    ),
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
                            child: Image.network(reward.imageUrl,
                                fit: BoxFit.contain),
                          ),
                          const SizedBox(
                              width: 10), // Spacer between logo and text
                          // Reward details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reward.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  reward.description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  reward.amountNeeded,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
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
