

class Recipent {
  final int id;
  final String name;
  final String lastname;
  final String telephoneNumber;
  final String email;
  final String company;
  final String companyAdress;
  final String imageUrl;
  final String position;
  final String positionEN;

  Recipent({
    this.id,
    this.name,
    this.lastname,
    this.telephoneNumber,
    this.email,
    this.company,
    this.companyAdress,
    this.imageUrl,
    this.position,
    this.positionEN});

  factory Recipent.fromJson(Map<String, dynamic> json) {
    return Recipent(
        id: json['id'] as int,
        name: json['name'] as String,
        lastname: json['lastname'] as String,
        telephoneNumber: json['telephoneNumber'] as String,
        email: json['email'] as String,
        company: json['company'] as String,
        companyAdress: json['companyAdress'] as String,
        imageUrl: json['imageUrl'] as String,
        position: json['position'] as String,
        positionEN: json['positionEN'] as String);
  }
}