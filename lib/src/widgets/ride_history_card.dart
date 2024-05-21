// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../constants/app_contants.dart';
// import '../constants/colors.dart';
// import '../provider/user_provider.dart';

// class RideHistoryCard extends StatelessWidget {
//   const RideHistoryCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context).user;
//     final List<Map<String, dynamic>> bookingHistory = user.bookingHistory;
//     final List<dynamic> pickupLocation =
//         bookingHistory.map((booking) => booking['Pickup location']).toList();

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
//       child: Container(
//         height: 500,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(kBorderRadiusCards),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(25.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Ever wonder your history?',
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                   height: 400,
//                   width: 400,
//                   child: ListView.builder(
//                     itemCount: pickupLocation.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(children: [
//                           Container(
//                             width: 50,
//                             height: 50,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: primaryColor,
//                             ),
//                             child: const Center(
//                               child: Icon(
//                                 Icons.location_on,
//                                 color: Colors.white,
//                                 size: 30,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 width: 200,
//                                 child: Text(
//                                   pickupLocation[index],
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 200,
//                                 child: Text(
//                                   '2266, Lorong Inai 2, Taman Ria Jaya, 08000 Sungai Petani, Kedah.',
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(width: 20),
//                           GestureDetector(
//                             onTap: () {},
//                             child: const Icon(
//                               Icons.arrow_forward_ios,
//                               color: Colors.black,
//                             ),
//                           )
//                         ]),
//                       );
//                     },
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
