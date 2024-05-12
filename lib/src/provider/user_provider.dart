//since we dont have a backend yet, we mimic user data fetching here

import 'package:flutter/material.dart';

import '../models/models.dart';

class UserProvider extends ChangeNotifier {
  late MyUser _user;
  bool loading = false;
  MyUser get user => _user; //getters

  // Method to fetch user data asynchronously
  Future<void> fetchUserData() async {
    // Simulate delay to mimic network request
    loading = true;
    await Future.delayed(const Duration(seconds: 1));

    // Mock user data
    _user = MyUser(
      id: '1',
      username: 'doodle',
      email: 'john@example.com',
      password: 'password123',
      phoneNumber: '+1234567890',
      profilePicture: 'https://example.com/profile.jpg',
      bookingHistory: [
        {
          'bookingId': '1',
          'date': '2024-05-12',
          'Pickup location': 'Mid Valley',
          'Payment method': 'Touch n Go'
        },
        {
          'bookingId': '2',
          'date': '2024-05-10',
          'Pickup location': 'Central Square',
          'Payment method': 'Card'
        },
        {
          'bookingId': '3',
          'date': '2024-05-08',
          'Pickup location': 'Multimedia University',
          'Payment method': 'Cash'
        },
      ],
      friends: [
        MyUser(
          id: '2',
          username: 'Alpha',
          email: 'jane@example.com',
          password: 'password456',
          phoneNumber: '+9876543210',
          profilePicture: 'https://example.com/profile2.jpg',
          bookingHistory: [
            {
              'bookingId': '4',
              'date': '2024-05-06',
              'Pickup location': 'Times Square',
              'Payment method': 'Card'
            },
            {
              'bookingId': '5',
              'date': '2024-05-04',
              'Pickup location': 'Sunway Pyramid',
              'Payment method': 'Touch n Go'
            },
            {
              'bookingId': '6',
              'date': '2024-05-02',
              'Pickup location': 'KLCC',
              'Payment method': 'Cash'
            },
          ],
          friends: [],
        ),
        MyUser(
          id: '3',
          username: 'Song',
          email: 'james@example.com',
          password: 'password789',
          phoneNumber: '+2468135790',
          profilePicture: 'https://example.com/profile3.jpg',
          bookingHistory: [
            {
              'bookingId': '7',
              'date': '2024-04-30',
              'Pickup location': 'Pavilion',
              'Payment method': 'Card'
            },
            {
              'bookingId': '8',
              'date': '2024-04-28',
              'Pickup location': 'One Utama',
              'Payment method': 'Touch n Go'
            },
            {
              'bookingId': '9',
              'date': '2024-04-26',
              'Pickup location': 'Sunway Velocity',
              'Payment method': 'Cash'
            },
          ],
          friends: [],
        ),
        MyUser(
          id: '4',
          username: 'Alan',
          email: 'emma@example.com',
          password: 'passwordabc',
          phoneNumber: '+1357924680',
          profilePicture: 'https://example.com/profile4.jpg',
          bookingHistory: [
            {
              'bookingId': '10',
              'date': '2024-04-24',
              'Pickup location': 'IOI City Mall',
              'Payment method': 'Card'
            },
            {
              'bookingId': '11',
              'date': '2024-04-22',
              'Pickup location': 'The Gardens Mall',
              'Payment method': 'Touch n Go'
            },
            {
              'bookingId': '12',
              'date': '2024-04-20',
              'Pickup location': 'Empire Shopping Gallery',
              'Payment method': 'Cash'
            },
          ],
          friends: [],
        ),
      ],
    );

    loading = false;
    // Notify listeners that user data has been updated
    notifyListeners();
  }
}
