import 'package:app/Admin/addslotdeatils.dart';
import 'package:app/mainscreen.dart/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Allslot extends StatefulWidget {
  const Allslot({super.key});

  @override
  State<Allslot> createState() => _AllslotState();
}

TextEditingController idController = TextEditingController();
TextEditingController slotController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController vehicleNoController = TextEditingController();

class _AllslotState extends State<Allslot> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("slots")
            .orderBy('slotNumber')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("No slots available"));
          }

          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              var id = document.id;

              bool isBooked = document['status'] == "Booked";
              String buttonText = isBooked ? 'Booked' : 'Book';
              return SizedBox(
                height: 150,
                width: 200,
                child: Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Slot Number: ${document['slotNumber']}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Status: ${document['status']}",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (!isBooked) {
                              _showCustomDialog(
                                  context, document['slotNumber'], id);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text("This Slot is already booked"),
                                  action: SnackBarAction(
                                      label: 'OK', onPressed: () {}),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isBooked ? Colors.red : Colors.green,
                          ),
                          child: Text(
                            buttonText,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
            ),
          );
        },
      ),
      floatingActionButton: true == true
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddSlot();
                  },
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
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
                      enabled: false,
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
                        if (value.split(' ').length > 2) {
                          return 'Name must be at most 2 words.';
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
                        if (value.length != 11) {
                          return 'Phone number must be 10 digits long.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: vehicleNoController,
                      decoration:
                          const InputDecoration(labelText: 'Vehicle No'),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a vehicle number.';
                        }

                        // Check if it contains exactly 3 letters and 3 numbers
                        int letterCount = 0;
                        int numberCount = 0;

                        for (var i = 0; i < value.length; i++) {
                          if (value[i].toUpperCase() !=
                              value[i].toLowerCase()) {
                            // Found a letter
                            letterCount++;
                          } else if (int.tryParse(value[i]) != null) {
                            // Found a number
                            numberCount++;
                          }
                        }

                        if (letterCount != 3 || numberCount != 3) {
                          return 'Vehicle number must contain exactly 3 letters and 3 numbers.';
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
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PaymentMethodScreen(
                        slotDocId: slotDocId,
                        slotNo: slotno,
                        name: nameController.text,
                        phone: phoneController.text,
                        vehicle: vehicleNoController.text,
                      ),
                    ));

                    nameController.clear();
                    phoneController.clear();
                    vehicleNoController.clear();
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
}
