import 'package:contact_app/domain/entity/contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel(
    super.name,
    super.nickname,
    super.email,
    super.telephone,
    super.gender,
    super.birthdate,
    super.image,
  );

  factory ContactModel.fromEntity(ContactEntity contact) {
    return ContactModel(contact.name, contact.nickname, contact.email,
        contact.telephone, contact.gender, contact.birthdate, contact.image);
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(json['name'], json['nickname'], json['email'],
        json['telephone'], json['gender'], json['birthdate'], json['image']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['nickname'] = nickname;
    data['email'] = email;
    data['telephone'] = telephone;
    data['gender'] = gender;
    data['birthdate'] = birthdate;
    data['image'] = image;
    return data;
  }
}
