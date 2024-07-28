import 'package:isar/isar.dart';

@Collection()
class BeaconNames {
  @Id()
  late int id; // Non-nullable id

  @Index()
  late String macAddress;
  late String name;
  late String description;
  late String lastSeen;

  BeaconNames({required this.id, required this.macAddress, required this.name, required this.description, required this.lastSeen});
}
