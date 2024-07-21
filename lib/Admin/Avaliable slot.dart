import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Avaliableslot extends StatefulWidget {
  const Avaliableslot({super.key});

  @override
  State<Avaliableslot> createState() => _AvaliableslotState();
}

class _AvaliableslotState extends State<Avaliableslot> {
  late String id;

  TextEditingController idController = TextEditingController();
  TextEditingController slotController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController vehicleNoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("slots")
            .where('status', isEqualTo: 'available')
            .orderBy('slotNumber')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No available slots found.'),
            );
          }

          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              var id = document.id;
              return Card(
                margin: const EdgeInsets.all(8),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Slot Number: ${document['slotNumber']}',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text('Status: ${document['status']}'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _showCustomDialog(
                              context, document['slotNumber'], id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .green, // Change the color of the "Book" button to green
                        ),
                        child: const Text(
                          'Book',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
          );
        },
      ),
    );
  }

  Future<void> _showCustomDialog(
      BuildContext context, String slotno, String slotDocId) async {
    try {
      slotController.text = slotno;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Booking details'),
            content: SizedBox(
              height: 308,
              width: 250,
              child: Form(
                key: _formKey,
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
                      decoration:
                          const InputDecoration(labelText: 'Vehicle No'),
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
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _adddata(context, slotDocId);
                    // slotController.clear();
                    nameController.clear();
                    phoneController.clear();
                    vehicleNoController.clear(); // Corrected line

                    Navigator.of(context).pop(); // Close the dialog
                  }
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _adddata(BuildContext context, String slotno) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      const id = '';
      final slot = slotController.text;
      final name = nameController.text;
      final phone = phoneController.text;
      final vehicle = vehicleNoController.text;

      // Add booking details to the "doc" collection
      await firestore.collection('doc').add({
        'name': name,
        'phone': phone,
        'vichle': vehicle,
        'slot': slot,
        'id': id,
      });
      print("slot no $slotno");
      await firestore
          .collection('slots')
          .doc(slotno)
          .update({'status': 'Booked'});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$slot $name $phone $vehicle $id booked successfully.'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Handle errors
      print('Error booking slot: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error booking slot. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
