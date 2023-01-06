import 'package:hive/hive.dart';
part 'contact.g.dart';

@HiveType(typeId: 1)
class Contacts {
  Contacts({this.name, this.phoneNumber});
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? phoneNumber;
}
