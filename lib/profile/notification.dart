import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> todayNotifications = [
    NotificationItem(
      icon: Icons.check_circle,
      iconColor: Colors.green,
      title: 'Payment successful',
      subtitle: 'Your payment \$50 successfully paid',
      time: '10.30am',
    ),
    NotificationItem(
      icon: Icons.cancel,
      iconColor: Colors.red,
      title: 'Parking booking canceled',
      subtitle: 'Your DCM parking booking payment failed.',
      time: '11.30am',
    ),
  ];

  List<NotificationItem> yesterdayNotifications = [
    NotificationItem(
      icon: Icons.local_parking,
      iconColor: Colors.orange,
      title: 'Parking booking success',
      subtitle: 'Your payment \$50 successfully paid',
      time: '09.30am',
    ),
    NotificationItem(
      icon: Icons.check_circle,
      iconColor: Colors.green,
      title: 'Payment successful',
      subtitle: 'Your payment \$50 successfully paid',
      time: '11.30am',
    ),
    NotificationItem(
      icon: Icons.local_parking,
      iconColor: Colors.orange,
      title: 'Parking booking success',
      subtitle: 'Your payment \$50 successfully paid',
      time: '10.00am',
    ),
    NotificationItem(
      icon: Icons.cancel,
      iconColor: Colors.red,
      title: 'Parking booking canceled',
      subtitle: 'Your DCM parking booking payment failed.',
      time: '10.30am',
    ),
    NotificationItem(
      icon: Icons.cancel,
      iconColor: Colors.blue,
      title: 'Parking booking canceled',
      subtitle: 'Your DCM parking booking payment failed.',
      time: '10.30am',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Today'),
          ...todayNotifications.map((item) => Dismissible(
                key: Key(item.time),
                onDismissed: (direction) {
                  setState(() {
                    todayNotifications.remove(item);
                  });
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: NotificationTile(
                  icon: item.icon,
                  iconColor: item.iconColor,
                  title: item.title,
                  subtitle: item.subtitle,
                  time: item.time,
                ),
              )),
          const SizedBox(height: 16),
          const SectionTitle(title: 'Yesterday'),
          ...yesterdayNotifications.map((item) => Dismissible(
                key: Key('${item.time}y'),
                onDismissed: (direction) {
                  setState(() {
                    yesterdayNotifications.remove(item);
                  });
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: NotificationTile(
                  icon: item.icon,
                  iconColor: item.iconColor,
                  title: item.title,
                  subtitle: item.subtitle,
                  time: item.time,
                ),
              )),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;

  NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });
}
