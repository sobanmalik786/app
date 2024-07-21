// ignore_for_file: use_build_context_synchronously

import 'package:app/mainscreen.dart/dashboard.dart';
import 'package:app/mainscreen.dart/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Create extends StatelessWidget {
  final String slotNo;
  final String slotDocId;
  final String vehicle;
  final String name;
  final String phone;
  const Create(
      {super.key,
      required this.slotDocId,
      required this.slotNo,
      required this.vehicle,
      required this.name,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(),
        title: const Text('Payment with jazzcash'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image widget
            Image.asset(
              'assets/qr.jpg', // Replace with your image URL
            ),
            // Text widget
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Please pay 200 Rs to complete the booking process\nAfter payment click on verify',
                style: TextStyle(fontSize: 18),
              ),
            ),
            // Button widget
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Payment"),
                      content: const Text("Admin is verifying your payment"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              _adddata(context, slotNo);
                            },
                            child: const Text("ok"))
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 27),
                textStyle: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _adddata(BuildContext context, String slotno) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add booking details to the "doc" collection
      await firestore.collection('doc').add({
        'name': name,
        'phone': phone,
        'vichle': vehicle,
        'slot': slotno,
        'uid': FirebaseAuth.instance.currentUser!.uid
      });

      await firestore.collection('slots').doc(slotDocId).update({
        'status': 'Booked',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$slotno booked successfully.'),
          action: SnackBarAction(label: "ok", onPressed: () {}),
        ),
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const dashboard(),
          ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error booking slot. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
