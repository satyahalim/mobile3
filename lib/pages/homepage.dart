import 'package:flutter/material.dart';
import 'package:projektugas3/pages/lbs.dart';
import 'package:projektugas3/pages/numtypes.dart';
import 'package:projektugas3/pages/stopwatch.dart';
import 'package:projektugas3/pages/timeconvert.dart';
import '../util/local_storage.dart';
import 'loginpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    if (index == 2) {
      // Kalau klik Logout
      await LocalStorage.logout();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu', style: TextStyle(fontFamily: 'Comic Sans MS')),
        backgroundColor: const Color(0xFFEA6B8D), // Matching the stopwatch color
        elevation: 4, // Agar tetap ada bayangan tipis
      ),
      body: _selectedIndex == 0 ? _buildMainMenu(context) : _buildHelpPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFFEA6B8D), // Matching the stopwatch color
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFF5E1E1), // Soft pastel background
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }

  Widget _buildMainMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: [
          _buildMenuItem(
            context,
            icon: Icons.access_time,
            label: 'Konversi Waktu',
            destination: const TimeConvert(),
          ),
          _buildMenuItem(
            context,
            icon: Icons.my_location,
            label: 'Location Tracking',
            destination: const LBS(),
          ),
          _buildMenuItem(
            context,
            icon: Icons.numbers,
            label: 'Tipe Bilangan',
            destination: const NumTypes(),
          ),
          _buildMenuItem(
            context,
            icon: Icons.timer,
            label: 'Stopwatch',
            destination: const StopWatch(),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpPage() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Selamat datang di menu Help!\n\n'
            '1. Pilih fitur di Home untuk menggunakan aplikasi.\n'
            '2. Tekan Logout untuk keluar.\n\n'
            'Semoga membantu!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Comic Sans MS', // Playful font
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon,
      required String label,
      required Widget destination}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: const Color(0xFFF5E1E1), // Soft pink background similar to stopwatch
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 5), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 500),
              child: Icon(
                icon,
                size: 60,
                color: const Color(0xFFEA6B8D), // Warm pink icon
              ),
            ),
            const SizedBox(height: 8),
            AnimatedDefaultTextStyle(
              style: TextStyle(
                fontSize: 18, // Larger font for better readability
                color: Color(0xFF6D6875), // Soft greyish text color
                fontWeight: FontWeight.bold,
                fontFamily: 'Comic Sans MS', // Playful font
              ),
              duration: const Duration(milliseconds: 300),
              child: Text(
                label,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}