import 'package:contact_app/domain/model/contact_model.dart';

import 'package:hive_flutter/hive_flutter.dart';

class ContactHiveAdapter extends TypeAdapter<ContactModel> {
  @override
  final typeId = 0;

  @override
  ContactModel read(BinaryReader reader) {
    return ContactModel(
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ContactModel obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.nickname);
    writer.writeString(obj.email);
    writer.writeString(obj.telephone);
    writer.writeString(obj.gender);
    writer.writeString(obj.birthdate);
    writer.writeString(obj.image);
  }
}
