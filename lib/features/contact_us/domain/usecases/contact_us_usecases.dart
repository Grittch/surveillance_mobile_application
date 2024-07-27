import 'package:iot_app_prot1/features/contact_us/domain/entities/contact_us_entities.dart';
import 'package:iot_app_prot1/features/contact_us/domain/repository/contact_us_repository.dart';

class SendMessage {
  final ContactUsRepository repository;

  SendMessage(this.repository);

  Future<void> call(ContactUsEntities message) async {
    await repository.sendMessage(message);
  }
}
