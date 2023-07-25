import 'package:hive_flutter/hive_flutter.dart';

class StringHiveAdapter extends TypeAdapter<String> {
  @override
  final typeId = 0;

  @override
  String read(BinaryReader reader) {
    return reader.readString();
  }

  @override
  void write(BinaryWriter writer, String obj) {
    writer.writeString(obj);
  }
}
