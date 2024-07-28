import 'package:isar/isar.dart';
part 'device_room.g.dart';

@Collection()
class DeviceRoom {
  @Id()
  late int id;

  String? name;

  @Index(unique: true)
  late String macAddress;
  late String room;
}