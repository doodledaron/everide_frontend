import 'package:flutter/material.dart';

class FriendList extends StatelessWidget {
  const FriendList({
    super.key,
    required this.friendNameList,
  });

  final List<dynamic> friendNameList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: friendNameList.length,
          itemBuilder: (BuildContext ctx, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    friendNameList.isEmpty ? '' : friendNameList[index],
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
