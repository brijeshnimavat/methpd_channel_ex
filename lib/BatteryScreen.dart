import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryScreeen extends StatefulWidget {
  const BatteryScreeen({super.key});

  @override
  State<BatteryScreeen> createState() => _BatteryScreeenState();
}

class _BatteryScreeenState extends State<BatteryScreeen> {
  static const platform = MethodChannel("battery_channel");

  String _batteryLevel = "Unknown";

  Future<void> _getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod("getBatteryLevel");
      setState(() {
        _batteryLevel = "Battery Level : $result";
      });
    } on PlatformException catch (e) {
      setState(() {
        _batteryLevel = "Failed : ${e.message}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Battery Level")),
      body: Center(
        child: Text(_batteryLevel, style: const TextStyle(fontSize: 20)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getBatteryLevel,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
