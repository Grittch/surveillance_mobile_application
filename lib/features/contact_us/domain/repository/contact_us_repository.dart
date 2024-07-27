import 'package:iot_app_prot1/features/contact_us/domain/entities/contact_us_entities.dart';

abstract class ContactUsRepository {
  Future<void> sendMessage(ContactUsEntities message);
}
