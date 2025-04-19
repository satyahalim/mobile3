import 'package:flutter/material.dart';
import 'dart:async';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  List<String> _lapTimes = [];

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStopwatch() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {});
    });
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    _lapTimes.clear();
    setState(() {});
  }

  void _recordLap() {
    final current = _formatTime(_stopwatch.elapsedMilliseconds);
    setState(() {
      _lapTimes.insert(0, current);
    });
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    return '${hours.toString().padLeft(2, '0')} : '
        '${(minutes % 60).toString().padLeft(2, '0')} : '
        '${(seconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    if (_stopwatch.isRunning) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = _stopwatch.elapsedMilliseconds;

    return Scaffold(
      backgroundColor: const Color(0xFFF5E1E1), // Soft pink pastel
      appBar: AppBar(
        backgroundColor: const Color(0xFFEA6B8D), // Warm pink
        title: const Text('⏰ Stopwatch Lucu', style: TextStyle(fontFamily: 'Comic Sans MS', fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              "⏱️",
              style: TextStyle(fontSize: 72, color: const Color(0xFFEA6B8D)),
            ),
            const SizedBox(height: 10),
            Text(
              _formatTime(elapsed),
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comic Sans MS',
                color: Color(0xFF6D6875),
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _buildCuteButton("Start", _startStopwatch, Colors.greenAccent),
                _buildCuteButton("Stop", _stopStopwatch, Colors.redAccent),
                _buildCuteButton("Reset", _resetStopwatch, Colors.orangeAccent),
                _buildCuteButton("Lap", _recordLap, Colors.purpleAccent),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              '📋 Lap Times',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: 'Comic Sans MS',
                color: Color(0xFFEA6B8D),
              ),
            ),
            const Divider(),
            Expanded(
              child: _lapTimes.isEmpty
                  ? const Center(
                      child: Text(
                        "Belum ada lap ✨",
                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _lapTimes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: const Color(0xFFF1E5F3),
                          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            leading: Icon(Icons.star, color: Colors.purpleAccent),
                            title: Text(_lapTimes[index], style: const TextStyle(fontFamily: 'Comic Sans MS')),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCuteButton(String label, VoidCallback onPressed, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: const TextStyle(fontFamily: 'Comic Sans MS', fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}