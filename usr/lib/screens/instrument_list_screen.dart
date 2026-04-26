import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/date_formatter.dart';
import 'add_instrument_screen.dart';

class InstrumentListScreen extends StatelessWidget {
  const InstrumentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = InstrumentProviderScope.of(context);
    final instruments = provider.instruments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Instruments'),
      ),
      body: instruments.isEmpty
          ? const Center(child: Text('No instruments added.'))
          : ListView.separated(
              itemCount: instruments.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final instrument = instruments[index];
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.build),
                  ),
                  title: Text(instrument.name),
                  subtitle: Text('ID: ${instrument.id}\nFrequency: ${instrument.calibrationFrequencyMonths} months'),
                  isThreeLine: true,
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Next Due', style: TextStyle(fontSize: 12)),
                      Text(
                        DateFormatter.formatDayMonthYear(instrument.nextCalibrationDate),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddInstrumentScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
