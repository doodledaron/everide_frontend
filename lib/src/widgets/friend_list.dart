import 'package:flutter/material.dart';

class FriendList extends StatelessWidget {
  const FriendList({
    super.key,
    required this.friendNameList,
  });

  final List<String> friendNameList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: friendNameList.length,
          itemBuilder: (BuildContext ctx, int index) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: CircleAvatar(
                    radius: 35,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  friendNameList[index],
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            );
          }),
    );
  }
}
