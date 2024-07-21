// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:app/mainscreen.dart/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Bookedslot extends StatefulWidget {
  const Bookedslot({super.key});

  @override
  State<Bookedslot> createState() => _BookedslotState();
}

late String id;
TextEditingController idController = TextEditingController();
TextEditingController slotController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController vehicleNoController = TextEditingController();

class _BookedslotState extends State<Bookedslot> {
  Stream<QuerySnapshot> get bookedSlots {
    return FirebaseFirestore.instance
        .collection('slots')
        .where('status', isEqualTo: 'Booked')
        .orderBy('slotNumber')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: bookedSlots,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No booked slots found."),
          );
        }

        return GridView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var document = snapshot.data!.docs[index];

            return GestureDetector(
              onTap: () {
                _showCustomDialog(context, document['slotNumber']);
              },
              child: SizedBox(
                height: 9000,
                width: 900,
                child: Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Slot Number: ${document['slotNumber']}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Status: ${document['status']}",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                print("oka");
                                _showCustomDialog(
                                    context, document['slotNumber']);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .green, // Change the color of the "Booked" button
                              ),
                              child: const Text('Booked',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print("oka");
                                _cancelBooking(context, document['slotNumber']);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .red, // Change the color of the "Cancel" button
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
        );
      },
    );
  }
}

Future<void> _showCustomDialog(
  BuildContext context,
  String slotno,
) async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("doc")
        .where("slot", isEqualTo: slotno)
        .get();

    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot document = snapshot.docs.first;
      slotController.text = document["slot"];
      nameController.text = document['name'] ?? '';
      phoneController.text = document['phone'] ?? '';
      vehicleNoController.text = document['vichle'] ?? '';
      idController.text = document['id'];

      id = document["id"];
    } else {
      slotController.clear();
      nameController.clear();
      phoneController.clear();
      vehicleNoController.clear();
    }
  } catch (e) {
    print('Error fetching data: $e');
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      var formKey;
      return AlertDialog(
        title: const Text('Booking details'),
        content: SizedBox(
          height: 308,
          width: 250,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: slotController,
                  decoration: const InputDecoration(labelText: 'Slot'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a slot.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: vehicleNoController,
                  decoration: const InputDecoration(labelText: 'Vehicle No'),
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a vehicle number.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var formKey;
              if (formKey.currentState?.validate() ?? true) {
                {
                  await FirebaseFirestore.instance
                      .collection('slots')
                      .where('slotNumber', isEqualTo: slotno)
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    for (var doc in querySnapshot.docs) {
                      FirebaseFirestore.instance
                          .collection('slots')
                          .doc(doc.id)
                          .update({'status': 'Booked'});
                    }
                  });

                  // _allSlot(context, slotno);

                  print("done");
                }
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

Future<void> _cancelBooking(BuildContext context, String slotno) async {
  try {
    await FirebaseFirestore.instance
        .collection('slots')
        .where('slotNumber', isEqualTo: slotno)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        FirebaseFirestore.instance.collection('slots').doc(doc.id).update({
          'status': 'available',
          'name': '',
          'phone': '',
          'vichle': '',
        });
      }
    });

    // Navigate to the Available Slots screen after canceling the booking

    print("Booking for Slot $slotno canceled successfully");
  } catch (e) {
    print('Error canceling booking: $e');
  }
}
