import 'package:contact_app/domain/model/contact_model.dart';

abstract class AddContactRepositoryAbs {
  Future addContact(ContactModel contact);
}
