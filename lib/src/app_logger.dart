import 'package:logger/logger.dart';

class AppLogger extends LogPrinter {
  final String className;

  AppLogger(this.className);

  @override
  void log(LogEvent event) {
    final String emoji = PrettyPrinter.levelEmojis[event.level];
    if (event.error != null) {
      println(
          '$emoji${event.level} - [$className] ${event.message} ${event.error} ${event.stackTrace}');
    } else {
      println('$emoji${event.level} - [$className] ${event.message}');
    }
  }
}
