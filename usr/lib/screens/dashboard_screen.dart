import 'package:flutter/material.dart';
import '../main.dart';
import '../models/instrument.dart';
import '../utils/date_formatter.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = InstrumentProviderScope.of(context);
    final instruments = provider.instruments;

    // Group instruments by month/year of their next calibration
    final Map<String, List<Instrument>> groupedInstruments = {};
    
    // Sort instruments by next calibration date first
    final sortedInstruments = List<Instrument>.from(instruments)
      ..sort((a, b) => a.nextCalibrationDate.compareTo(b.nextCalibrationDate));

    for (var instrument in sortedInstruments) {
      final monthYear = DateFormatter.formatMonthYear(instrument.nextCalibrationDate);
      if (!groupedInstruments.containsKey(monthYear)) {
        groupedInstruments[monthYear] = [];
      }
      groupedInstruments[monthYear]!.add(instrument);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calibration Scope'),
      ),
      body: groupedInstruments.isEmpty
          ? const Center(child: Text('No upcoming calibrations.'))
          : ListView.builder(
              itemCount: groupedInstruments.length,
              itemBuilder: (context, index) {
                final monthYear = groupedInstruments.keys.elementAt(index);
                final items = groupedInstruments[monthYear]!;

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    initiallyExpanded: index == 0,
                    title: Text(
                      monthYear,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${items.length} instruments due'),
                    children: items.map((instrument) {
                      return ListTile(
                        leading: const Icon(Icons.build_circle_outlined),
                        title: Text(instrument.name),
                        subtitle: Text('ID: ${instrument.id}'),
                        trailing: Text(
                          DateFormatter.formatDayMonth(instrument.nextCalibrationDate),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
    );
  }
}
