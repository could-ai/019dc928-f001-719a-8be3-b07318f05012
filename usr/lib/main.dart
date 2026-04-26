import 'package:flutter/material.dart';
import 'models/instrument.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CalibrationApp());
}

class InstrumentProvider extends ChangeNotifier {
  final List<Instrument> _instruments = [
    Instrument.sample('INST-001', 'Vernier Caliper', DateTime.now().subtract(const Duration(days: 60)), 6),
    Instrument.sample('INST-002', 'Micrometer', DateTime.now().subtract(const Duration(days: 120)), 12),
    Instrument.sample('INST-003', 'Pressure Gauge', DateTime.now().subtract(const Duration(days: 10)), 3),
    Instrument.sample('INST-004', 'Temperature Sensor', DateTime.now().subtract(const Duration(days: 200)), 12),
    Instrument.sample('INST-005', 'Weighing Scale', DateTime.now().subtract(const Duration(days: 300)), 6),
  ];

  List<Instrument> get instruments => _instruments;

  void addInstrument(Instrument instrument) {
    _instruments.add(instrument);
    notifyListeners();
  }
}

class CalibrationApp extends StatelessWidget {
  const CalibrationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InstrumentProviderScope(
      provider: InstrumentProvider(),
      child: MaterialApp(
        title: 'Calibration Scope',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class InstrumentProviderScope extends InheritedNotifier<InstrumentProvider> {
  const InstrumentProviderScope({
    Key? key,
    required InstrumentProvider provider,
    required Widget child,
  }) : super(key: key, notifier: provider, child: child);

  static InstrumentProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InstrumentProviderScope>()!.notifier!;
  }
}
