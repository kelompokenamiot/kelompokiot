
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sensordht22/Sensor_1_page.dart';
import 'package:sensordht22/Sensor_2_page.dart';
import 'package:sensordht22/log_activity_page.dart';
import 'package:sensordht22/profile_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final DatabaseReference sensor1Reference =
        // ignore: deprecated_member_use
        FirebaseDatabase.instance.reference().child('sensor1');

    final DatabaseReference sensor2Reference =
        // ignore: deprecated_member_use
        FirebaseDatabase.instance.reference().child('sensor2');

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        sensor1Reference: sensor1Reference,
        sensor2Reference: sensor2Reference,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final DatabaseReference sensor1Reference;
  final DatabaseReference sensor2Reference;

  const MyHomePage({
    Key? key,
    required this.sensor1Reference,
    required this.sensor2Reference,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  late final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    Sensor1Page(databaseReference: FirebaseDatabase.instance.reference().child('sensor1')),
    Sensor2Page(databaseReference: FirebaseDatabase.instance.reference().child('sensor2')),
    const MyLogActivityPage(),
    const MyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        toolbarHeight: 80,
        title: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text('Warehouse Monitoring'),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    print('Ikon Notifikasi diklik');
                  },
                  child: const Icon(Icons.notifications),
                ),
              ],
            ),
          ],
        ),
      ),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        backgroundColor: Color.fromARGB(255, 51, 35, 35),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.av_timer_rounded),
            backgroundColor: Colors.grey,
            label: 'Sensor 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.av_timer_rounded),
            backgroundColor: Colors.grey,
            label: 'Sensor 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            backgroundColor: Colors.grey,
            label: 'Log Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,),
            backgroundColor: Colors.grey,
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
