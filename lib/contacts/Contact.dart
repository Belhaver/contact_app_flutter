
import 'Recipent.dart';

class Contact {
  final int id;
  final Recipent recipent;
  final bool favourite;
  final bool hide;
  final String note;
  final String createdAt;

  Contact({this.id, this.recipent, this.favourite, this.hide, this.note, this.createdAt});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as int,
      recipent: Recipent.fromJson(json['recipent']),
      favourite: json['favourite'] as bool,
      hide: json['hide'] as bool,
      createdAt: json['createdAt'] as String
    );
  }
}
