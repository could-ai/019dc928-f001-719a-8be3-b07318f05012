class Instrument {
  final String id;
  final String name;
  final DateTime lastCalibrationDate;
  final int calibrationFrequencyMonths;

  Instrument({
    required this.id,
    required this.name,
    required this.lastCalibrationDate,
    required this.calibrationFrequencyMonths,
  });

  DateTime get nextCalibrationDate {
    return DateTime(
      lastCalibrationDate.year,
      lastCalibrationDate.month + calibrationFrequencyMonths,
      lastCalibrationDate.day,
    );
  }

  // Helper for generating sample data
  factory Instrument.sample(String id, String name, DateTime last, int freq) {
    return Instrument(
      id: id,
      name: name,
      lastCalibrationDate: last,
      calibrationFrequencyMonths: freq,
    );
  }
}
