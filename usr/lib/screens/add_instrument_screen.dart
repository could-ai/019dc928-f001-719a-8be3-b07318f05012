import 'package:flutter/material.dart';
import '../models/instrument.dart';
import '../main.dart';
import '../utils/date_formatter.dart';

class AddInstrumentScreen extends StatefulWidget {
  const AddInstrumentScreen({Key? key}) : super(key: key);

  @override
  State<AddInstrumentScreen> createState() => _AddInstrumentScreenState();
}

class _AddInstrumentScreenState extends State<AddInstrumentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _id = '';
  String _name = '';
  int _frequency = 6;
  DateTime _lastCalibrationDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _lastCalibrationDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _lastCalibrationDate) {
      setState(() {
        _lastCalibrationDate = picked;
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final newInstrument = Instrument(
        id: _id,
        name: _name,
        lastCalibrationDate: _lastCalibrationDate,
        calibrationFrequencyMonths: _frequency,
      );

      final provider = InstrumentProviderScope.of(context);
      provider.addInstrument(newInstrument);
      
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Instrument'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Instrument ID'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter ID' : null,
                onSaved: (value) => _id = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Instrument Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter Name' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Calibration Frequency (Months)'),
                initialValue: _frequency.toString(),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter frequency';
                  if (int.tryParse(value) == null) return 'Must be a number';
                  return null;
                },
                onSaved: (value) => _frequency = int.parse(value!),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Last Calibrated: ${DateFormatter.formatDayMonthYear(_lastCalibrationDate)}'),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save Instrument'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
