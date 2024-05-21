// import 'package:everide_frontend/src/models/models.dart';
// import 'package:everide_frontend/src/provider/user_provider.dart';
// import 'package:everide_frontend/src/widgets/friend_list.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../constants/app_contants.dart';
// import '../constants/colors.dart';

// class RideDetailsCard extends StatelessWidget {
//   const RideDetailsCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context).users;
//     final List<User> friendList = user.friends;
//     final List<String> friendNameList =
//         friendList.map((friend) => friend.username).toList();
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
//       child: Container(
//         height: 560,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(kBorderRadiusCards),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(25.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   Positioned(
//                     top: 5,
//                     child: Container(
//                       width: 50,
//                       height: 50,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: primaryColor,
//                       ),
//                       child: const Center(
//                         child: Icon(
//                           Icons.location_on,
//                           color: Colors.white,
//                           size: 30,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(
//                         left: 60), // Adjust the left padding as needed
//                     child: Padding(
//                       // width: 250,
//                       padding: EdgeInsets.only(right: 25),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Multimedia University Melaka',
//                             overflow: TextOverflow.visible,
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             'Jalan Ayer Keroh Lama, 75450 Bukit Beruang, Melaka',
//                             overflow: TextOverflow.visible,
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Center(
//                 child: SizedBox(
//                   height: 65,
//                   width: 290,
//                   child: Divider(
//                     color: Colors.grey[300],
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Date: 2024-05-06',
//                       style: TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Pickup location: UMP Pekan',
//                       style: TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Fare: RM69.69',
//                       style: TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Payment method: Touch n Go',
//                       style: TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Center(
//                 child: SizedBox(
//                   height: 65,
//                   width: 290,
//                   child: Divider(
//                     color: Colors.grey[300],
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 10),
//                 child: Text(
//                   'Your Eve-squad:',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               FriendList(friendNameList: friendNameList),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
