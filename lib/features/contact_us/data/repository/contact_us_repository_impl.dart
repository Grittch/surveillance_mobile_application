import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iot_app_prot1/features/contact_us/domain/entities/contact_us_entities.dart';
import 'package:iot_app_prot1/features/contact_us/domain/repository/contact_us_repository.dart';

class ContactUsRepositoryImpl implements ContactUsRepository {
  @override
  Future<void> sendMessage(ContactUsEntities message) async {
    const userId = "UWNHFXzYiVCx7nz5AdGI";
    final contactUsId = FirebaseFirestore.instance.collection("user").doc(userId).collection("contactUs").doc().id;

    await FirebaseFirestore.instance.collection('user').doc(userId).collection('contactUs').doc(contactUsId).set({
      'description': message.description,
      'problem': message.problem,
      'solved': message.solved,
    });
  }
}
