import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black,
        elevation: 1,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. Nullam ac erat ante. Proin scelerisque luctus elit vel tincidunt. Nulla facilisi. Morbi vehicula dignissim nulla, at suscipit erat ultricies ut. Donec commodo sapien sit amet turpis ultricies, sit amet auctor justo scelerisque.',
              style:
                  TextStyle(fontSize: 16, letterSpacing: 0.1, wordSpacing: 0.2),
            ),
            SizedBox(height: 16),
            Text(
              'Praesent vitae enim tristique, vehicula odio ac, facilisis lacus. Vivamus et quam vel orci luctus eleifend. Maecenas eget bibendum lacus. Pellentesque consectetur diam ut ex fringilla, a vehicula justo aliquet. Quisque ut urna vitae est aliquam vestibulum.',
              style:
                  TextStyle(fontSize: 16, letterSpacing: 0.1, wordSpacing: 0.2),
            ),
            SizedBox(height: 16),
            Text(
              'Donec aliquet malesuada eros, at gravida augue tristique non. Duis a libero vitae felis pharetra cursus at eu lectus. Integer vehicula, augue a efficitur dapibus, mi risus hendrerit erat, eu congue libero mauris non lorem. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. Nullam ac erat ante. Proin scelerisque luctus elit vel tincidunt. Nulla facilisi. Morbi vehicula dignissim nulla, at suscipit erat ultricies ut. Donec commodo sapien sit amet turpis ultricies, sit amet auctor justo scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. Nullam ac erat ante. Proin scelerisque luctus elit vel tincidunt. Nulla facilisi. Morbi vehicula dignissim nulla, at suscipit erat ultricies ut. Donec commodo sapien sit amet turpis ultricies, sit amet auctor justo scelerisque.',
              style:
                  TextStyle(fontSize: 16, letterSpacing: 0.1, wordSpacing: 0.2),
            ),
            SizedBox(height: 16),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. Nullam ac erat ante. Proin scelerisque luctus elit vel tincidunt. Nulla facilisi. Morbi vehicula dignissim nulla, at suscipit erat ultricies ut. Donec commodo sapien sit amet turpis ultricies, sit amet auctor justo scelerisque.Donec aliquet malesuada eros, at gravida augue tristique non. Duis a libero vitae felis pharetra cursus at eu lectus. Integer vehicula, augue a efficitur dapibus, mi risus hendrerit erat, eu congue libero mauris non lorem. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. Nullam ac erat ante. Proin scelerisque luctus elit vel tincidunt. Nulla facilisi. Morbi vehicula dignissim nulla, at suscipit erat ultricies ut. Donec commodo sapien sit amet turpis ultricies, sit amet auctor justo scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. Nullam ac erat ante. Proin scelerisque luctus elit vel tincidunt. Nulla facilisi. Morbi vehicula dignissim nulla, at suscipit erat ultricies ut. Donec commodo sapien sit amet turpis ultricies, sit amet auctor justo scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. Nullam ac erat ante. Proin scelerisque luctus elit vel tincidunt. Nulla facilisi. Morbi vehicula dignissim nulla, at suscipit erat ultricies ut. Donec commodo sapien sit amet turpis ultricies, sit amet auctor justo scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. Nullam ac erat ante. Proin scelerisque luctus elit vel tincidunt. Nulla facilisi. Morbi vehicula dignissim nulla, at suscipit erat ultricies ut. Donec commodo sapien sit amet turpis ultricies, sit amet auctor justo scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. Nullam ac erat ante. Proin scelerisque luctus elit vel tincidunt. Nulla facilisi. Morbi vehicula dignissim nulla, at suscipit erat ultricies ut. Donec commodo sapien sit amet turpis ultricies, sit amet auctor justo scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. Nullam ac erat ante. Proin scelerisque luctus elit vel tincidunt. Nulla facilisi. Morbi vehicula dignissim nulla, at suscipit erat ultricies ut. Donec commodo sapien sit amet turpis ultricies, sit amet auctor justo scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. Nullam ac erat ante. Proin scelerisque luctus elit vel tincidunt. Nulla facilisi. Morbi vehicula dignissim nulla, at suscipit erat ultricies ut. Donec commodo sapien sit amet turpis ultricies, sit amet auctor justo scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. Nullam ac erat ante. Proin scelerisque luctus elit vel tincidunt. Nulla facilisi. Morbi vehicula dignissim nulla, at suscipit erat ultricies ut. Donec commodo sapien sit amet turpis ultricies, sit amet auctor justo scelerisque.',
              style:
                  TextStyle(fontSize: 16, letterSpacing: 0.1, wordSpacing: 0.2),
            ),
          ],
        ),
      ),
    );
  }
}
