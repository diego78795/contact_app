import 'package:contact_app/domain/model/contact_model.dart';
import 'package:contact_app/domain/repository/contact_repository_domain.dart';

abstract class GetAllContactsAbs {
  Future<List<ContactModel>> call();
}

class GetAllContacts implements GetAllContactsAbs {
  final ContactRepositoryAbs repository;

  GetAllContacts(this.repository);

  @override
  Future<List<ContactModel>> call() async {
    return await repository.getContacts();
  }
}
