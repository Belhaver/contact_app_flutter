
class ContactDetails {
  final String name;
  final String lastname;
  final String telephoneNumber;
  final String email;
  final String company;
  final String companyAdress;
  final String position;
  final String positionEN;

  ContactDetails( {
    this.name,
    this.lastname,
    this.telephoneNumber,
    this.email,
    this.company,
    this.companyAdress,
    this.position,
    this.positionEN
});

  factory ContactDetails.fromJson(Map<String, dynamic> json) {
    return ContactDetails(
        name: json['name'] as String,
        lastname: json['lastname'] as String,
        telephoneNumber: json['telephoneNumber'] as String,
        email: json['email'] as String,
        company: json['company'] as String,
        companyAdress: json['companyAdress'] as String,
        position: json['position'] as String,
        positionEN: json['positionEN'] as String

    );
  }
}

