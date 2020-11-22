import 'package:cloud_firestore/cloud_firestore.dart';

class GeneroData {
  String nome, idDocument;
  int id;

  GeneroData.fromDocument(DocumentSnapshot snapshot) {
    idDocument = snapshot.id;
    nome = snapshot.get("name");
    id = snapshot.get("id");
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "name": nome,
      "id": id,
    };
  }
}
