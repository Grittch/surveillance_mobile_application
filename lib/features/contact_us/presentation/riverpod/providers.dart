import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_app_prot1/features/contact_us/data/repository/contact_us_repository_impl.dart';
import 'package:iot_app_prot1/features/contact_us/domain/entities/contact_us_entities.dart';
import 'package:iot_app_prot1/features/contact_us/domain/repository/contact_us_repository.dart';

class SendMessage {
  final ContactUsRepository repository;

  SendMessage(this.repository);

  Future<void> call(ContactUsEntities message) async {
    await repository.sendMessage(message);
  }
}

final contactUsRepositoryProvider = Provider<ContactUsRepository>((ref) {
  return ContactUsRepositoryImpl();
});

final sendMessageProvider = Provider<SendMessage>((ref) {
  final repository = ref.read(contactUsRepositoryProvider);
  return SendMessage(repository);
});
