import 'package:contact_app/domain/model/contact_model.dart';

abstract class EditContactRepositoryAbs {
  Future editContact(String key, ContactModel contact);
}
