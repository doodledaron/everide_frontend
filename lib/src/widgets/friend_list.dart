import 'package:everide_frontend/src/models/my_user_model.dart';
import 'package:flutter/material.dart';

class FriendList extends StatelessWidget {
  const FriendList({
    super.key,
    required this.friendNameList,
  });

  final List<MyUser> friendNameList;

  @override
  Widget build(BuildContext context) {
    //just a temp friend list as there is a problem on sending ride
    final List<MyUser> tempFriendList = [
      MyUser(
          id: '2',
          username: 'sample',
          email: 'email',
          password: 'password',
          phoneNumber: 'phoneNumber',
          profilePicture: 'assets/billie.jpeg',
          friends: []),
      MyUser(
          id: '3',
          username: 'sampless',
          email: 'email',
          password: 'password',
          phoneNumber: 'phoneNumber',
          profilePicture: 'assets/billie.jpeg',
          friends: []),
    ];

    return SizedBox(
      height: 100,
      width: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tempFriendList.length,
          itemBuilder: (BuildContext ctx, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/haaland.jpg'),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 70,
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      tempFriendList[index].username,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
