import 'package:app/Admin/ALLslot.dart';
import 'package:app/Admin/Avaliable%20slot.dart';
import 'package:app/Admin/Book%20slot.dart';
import 'package:flutter/material.dart';

class Design extends StatelessWidget {
  const Design({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    labelPadding: EdgeInsets.all(12),
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black54,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: 'All SLots'),
                      Tab(text: 'Available SLots'),
                      Tab(text: 'Booked Slots'),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  Allslot(),
                  Avaliableslot(),
                  Bookedslot(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
