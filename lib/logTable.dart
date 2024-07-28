import 'package:isar/isar.dart';
import 'log_entry.dart';
part 'logTable.g.dart';

@Collection()
class Log {
  @Id()
  late int id;

  DateTime timestamp;
  EventType eventType;
  String source;
  String message;

  Log({
    required this.timestamp,
    required this.eventType,
    required this.source,
    required this.message,
  });

  @override
  String toString() {
    return 'Log{timestamp: $timestamp, eventType: $eventType, source: $source, message: $message}';
  }
}