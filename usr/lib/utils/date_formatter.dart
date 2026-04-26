class DateFormatter {
  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  static const List<String> _fullMonths = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static String formatMonthYear(DateTime date) {
    return '${_fullMonths[date.month - 1]} ${date.year}';
  }

  static String formatDayMonth(DateTime date) {
    final dayStr = date.day.toString().padLeft(2, '0');
    return '$dayStr ${_months[date.month - 1]}';
  }

  static String formatDayMonthYear(DateTime date) {
    final dayStr = date.day.toString().padLeft(2, '0');
    return '$dayStr ${_months[date.month - 1]} ${date.year}';
  }
}
