// ignore_for_file: override_on_non_overriding_member, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors, avoid_print, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSlot extends StatefulWidget {
  @override
  _AddSlotState createState() => _AddSlotState();
}

class _AddSlotState extends State<AddSlot> {
  TextEditingController slotNumberController = TextEditingController();
  TextEditingController statusController =
      TextEditingController(text: "available");
  @override
  Future<void> _addSlot() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      String slotNumber = slotNumberController.text;
      String status = statusController.text;

      // Check if the slot with the given slotNumber already exists
      QuerySnapshot querySnapshot = await firestore
          .collection('slots')
          .where('slotNumber', isEqualTo: slotNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Slot with the same slotNumber already exists
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Slot $slotNumber already exists.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Slot with the given slotNumber doesn't exist, add it
        await firestore.collection('slots').add({
          'slotNumber': slotNumber,
          'status': status,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Slot $slotNumber added successfully.'),
            duration: Duration(seconds: 2),
          ),
        );
      }

      slotNumberController.clear();
      statusController.clear();
    } catch (e) {
      print('Error adding slot: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding slot. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return AlertDialog(
        surfaceTintColor: Colors.white,
        elevation: 10,
        title: Text("Add slot"),
        content: SizedBox(
          height: 200,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: slotNumberController,
                  decoration: InputDecoration(
                    labelText: 'Slot Number',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a slot number.';
                    }
                    // Additional validation logic can be added here
                    return null; // Return null if the input is valid
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  enabled: false,
                  controller: statusController,
                  decoration: InputDecoration(labelText: 'Status'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a status.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Validation passed, perform the action
                      _addSlot();
                      slotNumberController.clear();
                      statusController.clear();

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Add Slot"),
                ),
              ],
            ),
          ),
        ));
  }
}
