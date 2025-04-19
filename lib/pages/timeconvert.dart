import 'package:flutter/material.dart';

class TimeConvert extends StatefulWidget {
  const TimeConvert({super.key});

  @override
  State<TimeConvert> createState() => _TimeConvertState();
}

class _TimeConvertState extends State<TimeConvert> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _convertTime() {
    final input = int.tryParse(_controller.text);
    if (input == null) {
      setState(() {
        _result = 'Masukkan angka detik yang valid.';
      });
      return;
    }

    int seconds = input;
    int years = seconds ~/ (365 * 24 * 60 * 60);
    seconds %= (365 * 24 * 60 * 60);

    int days = seconds ~/ (24 * 60 * 60);
    seconds %= (24 * 60 * 60);

    int hours = seconds ~/ (60 * 60);
    seconds %= (60 * 60);

    int minutes = seconds ~/ 60;
    seconds %= 60;

    setState(() {
      _result = '$input detik = $years tahun, $days hari, $hours jam, $minutes menit, $seconds detik';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E1E1), // Soft pink pastel
      appBar: AppBar(
        title: const Text('Konversi Waktu', style: TextStyle(fontFamily: 'Comic Sans MS', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFEA6B8D), // Warm pink
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              'Masukkan detik yang ingin dikonversi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFEA6B8D)),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Contoh: 123456789',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFFEA6B8D)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFFEA6B8D), width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              style: TextStyle(fontSize: 18, color: Color(0xFF6D6875)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTime,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: const Color(0xFFEA6B8D), // Warm pink
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 5,
              ),
              child: const Text(
                'Konversi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEA6B8D).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFEA6B8D)),
              ),
              child: Text(
                _result.isEmpty ? 'Hasil konversi akan ditampilkan di sini' : _result,
                style: TextStyle(fontSize: 16, color: Color(0xFF6D6875), fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}