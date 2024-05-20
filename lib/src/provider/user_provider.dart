//since we dont have a backend yet, we mimic user data fetching here

import 'package:flutter/material.dart';

import '../models/my_user_model.dart';

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
          'Payment method': 'Touch n Go',
          'destination': '103 Coffee Chowkit',
          'destination address':
              'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
          'carpool': [
            MyUser(
              id: '2',
              username: 'Alpha',
              email: 'jane@example.com',
              password: 'password456',
              phoneNumber: '+9876543210',
              profilePicture: 'https://example.com/profile2.jpg',
              bookingHistory: [
                {
                  'bookingId': '1',
                  'date': '2024-05-12',
                  'Pickup location': 'Mid Valley',
                  'Payment method': 'Touch n Go',
                  'destination': 'Tamarind Square',
                  'destination address':
                      'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
                },
                {
                  'bookingId': '2',
                  'date': '2024-05-10',
                  'Pickup location': 'Central Square',
                  'Payment method': 'Card',
                  'destination': 'Tamarind Square',
                  'destination address':
                      'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
                },
                {
                  'bookingId': '3',
                  'date': '2024-05-08',
                  'Pickup location': 'Multimedia University',
                  'Payment method': 'Cash',
                  'destination': 'Tamarind Square',
                  'destination address':
                      'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
                },
              ],
              friends: [],
            ),
            MyUser(
              id: '2',
              username: 'Alpha',
              email: 'jane@example.com',
              password: 'password456',
              phoneNumber: '+9876543210',
              profilePicture: 'https://example.com/profile2.jpg',
              bookingHistory: [
                {
                  'bookingId': '1',
                  'date': '2024-05-12',
                  'Pickup location': 'Mid Valley',
                  'Payment method': 'Touch n Go',
                  'destination': 'Tamarind Square',
                  'destination address':
                      'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
                },
                {
                  'bookingId': '2',
                  'date': '2024-05-10',
                  'Pickup location': 'Central Square',
                  'Payment method': 'Card',
                  'destination': 'Tamarind Square',
                  'destination address':
                      'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
                },
                {
                  'bookingId': '3',
                  'date': '2024-05-08',
                  'Pickup location': 'Multimedia University',
                  'Payment method': 'Cash',
                  'destination': 'Tamarind Square',
                  'destination address':
                      'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
                },
              ],
              friends: [],
            ),
          ]
        },
        {
          'bookingId': '2',
          'date': '2024-05-10',
          'Pickup location': 'Central Square',
          'Payment method': 'Card',
          'destination': 'KLCC',
          'destination address':
              'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
        },
        {
          'bookingId': '3',
          'date': '2024-05-08',
          'Pickup location': 'Multimedia University',
          'Payment method': 'Cash',
          'destination': 'Tamarind Square',
          'destination address':
              'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
        },
        {
          'bookingId': '4',
          'date': '2024-05-12',
          'Pickup location': 'Mid Valley',
          'Payment method': 'Touch n Go',
          'destination': '1Utama',
          'destination address':
              'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
        },
        {
          'bookingId': '5',
          'date': '2024-05-10',
          'Pickup location': 'Glenmerie',
          'Payment method': 'Card',
          'destination': 'Tamarind Square',
          'destination address':
              'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
        },
        {
          'bookingId': '6',
          'date': '2024-05-08',
          'Pickup location': 'Multimedia University',
          'Payment method': 'Cash',
          'destination': 'Bukit Kinrara',
          'destination address':
              'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
        },
        {
          'bookingId': '5',
          'date': '2024-05-10',
          'Pickup location': 'Glenmerie',
          'Payment method': 'Card',
          'destination': 'Tamarind Square',
          'destination address':
              'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
        },
        {
          'bookingId': '6',
          'date': '2024-05-08',
          'Pickup location': 'Multimedia University',
          'Payment method': 'Cash',
          'destination': 'Bukit Kinrara',
          'destination address':
              'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
        },
        {
          'bookingId': '6',
          'date': '2024-05-08',
          'Pickup location': 'Multimedia University',
          'Payment method': 'Cash',
          'destination': 'Bukit Kinrara',
          'destination address':
              'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
        },
        {
          'bookingId': '5',
          'date': '2024-05-10',
          'Pickup location': 'Glenmerie',
          'Payment method': 'Card',
          'destination': 'Tamarind Square',
          'destination address':
              'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
        },
        {
          'bookingId': '6',
          'date': '2024-05-08',
          'Pickup location': 'Multimedia University',
          'Payment method': 'Cash',
          'destination': 'Bukit Kinrara',
          'destination address':
              'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
        },
      ],
      friends: [
        MyUser(
          id: '3',
          username: 'Song',
          email: 'james@example.com',
          password: 'password789',
          phoneNumber: '+2468135790',
          profilePicture: 'https://example.com/profile3.jpg',
          bookingHistory: [
            {
              'bookingId': '1',
              'date': '2024-05-12',
              'Pickup location': 'Mid Valley',
              'Payment method': 'Touch n Go',
              'destination': 'Tamarind Square',
              'destination address':
                  'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
            },
            {
              'bookingId': '2',
              'date': '2024-05-10',
              'Pickup location': 'Central Square',
              'Payment method': 'Card',
              'destination': 'Tamarind Square',
              'destination address':
                  'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
            },
            {
              'bookingId': '3',
              'date': '2024-05-08',
              'Pickup location': 'Multimedia University',
              'Payment method': 'Cash',
              'destination': 'Tamarind Square',
              'destination address':
                  'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
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
              'bookingId': '1',
              'date': '2024-05-12',
              'Pickup location': 'Mid Valley',
              'Payment method': 'Touch n Go',
              'destination': 'Tamarind Square',
              'destination address':
                  'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
            },
            {
              'bookingId': '2',
              'date': '2024-05-10',
              'Pickup location': 'Central Square',
              'Payment method': 'Card',
              'destination': 'Tamarind Square',
              'destination address':
                  'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
            },
            {
              'bookingId': '3',
              'date': '2024-05-08',
              'Pickup location': 'Multimedia University',
              'Payment method': 'Cash',
              'destination': 'Tamarind Square',
              'destination address':
                  'ET2-31-05 Tower 2 Eclipse Residence, Persiaran Multimedia, Cyber 11, 63000 Cyberjaya',
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
