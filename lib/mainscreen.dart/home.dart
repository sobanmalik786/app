import 'dart:async';
import 'package:app/Admin/ALLslot.dart';
import 'package:app/Admin/Avaliable%20slot.dart';
import 'package:app/Admin/Book%20slot.dart';
import 'package:app/Admin/design.dart';
import 'package:app/mainscreen.dart/map.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imageUrls = [
    'https://parkmobile.io/wp-content/uploads/2023/08/reporting-analytics-5.jpg',
    'https://t4.ftcdn.net/jpg/03/30/78/77/360_F_330787755_RSUhTI7LvN3UUvGWus7t90Sh8yACJ8Lb.jpg',
    'https://assets-prd.raicore.com/-/media/project/rai-amsterdam/intertraffic/news/2022/parkingshape1-550-x-300-px.png?h=300&iar=0&w=550&rev=cb95d922f0984100ba4515d55baca3b0&extension=,webp&hash=643D7E1F1F3FD4BC9C577BEAEC3F7DCD'
        'https://www.engineeringcivil.com/wp-content/uploads/2013/04/off-street-parking.jpg'
    // Add more image URLs as needed
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Set up a timer to move to the next card every 2 seconds
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (mounted) {
        setState(() {
          currentIndex = (currentIndex + 1) % imageUrls.length;
        });
        print('Current Index: $currentIndex');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black,
          elevation: 1,
          leading: Container(),
          actions: [
            IconButton(
              alignment: Alignment.topRight,
              icon: const Icon(Icons.location_on),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CallMapWithMarker(
                      lat: 31.419190,
                      long: 74.230511,
                      SuperiorUnvirestyGlodCampus:
                          'Superior Unviresty Glod Campus',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Vertical Slider
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: 200,
              width: double.infinity,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
                items: imageUrls
                    .map((item) => Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: 1000,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),

            // TabBar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const TabBar(
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  Tab(text: 'All Slots'),
                  Tab(text: 'Available Slots'),
                  Tab(text: 'Book Slots'),
                ],
              ),
            ),

            // TabBarView
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
