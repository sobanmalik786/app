import 'package:app/create.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String slotNo;
  final String vehicle;
  final String slotDocId;
  final String name;
  final String phone;
  const PaymentMethodScreen(
      {super.key,
      required this.slotNo,
      required this.vehicle,
      required this.slotDocId,
      required this.name,
      required this.phone});

  @override
  PaymentMethodScreenState createState() => PaymentMethodScreenState();
}

class PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedPaymentMethod = 'Credit card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Payment'),
        backgroundColor: Colors.white10,
      ),
      body: Column(
        children: [
          RadioListTile(
            selected: true,
            value: 'Jazz Cash',
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value.toString();
              });
            },
            title: const Text('Jazz Cash'),
            secondary: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Image.asset('assets/jazz.png'), // Add appropriate asset image
              // Increase the size of the icon
            ),
          ),
          RadioListTile(
            value: 'EasyPaisa',
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value.toString();
              });
            },
            title: const Text('EasyPaisa'),
            secondary: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                  'assets/easypaisa.png'), // Add appropriate asset image
              // Increase the size of the icon
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Total payment : \$20.00',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Create(
                              slotDocId: widget.slotDocId,
                              slotNo: widget.slotNo,
                              name: widget.name,
                              phone: widget.phone,
                              vehicle: widget.vehicle,
                            ),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
