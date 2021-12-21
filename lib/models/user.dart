library wallet_whitelabel;

class User {
  User();

  String? email;
  String? password;
  String? name;

  bool? active;

  String? cpf;
  String? code;
  String? address;
  String? addressNumber;
  String? district;
  String? complement;
  String? city;
  String? state;

  int? loggedIn;
  String? token;

  String? idPerson;
  String? idProfessional;
  String? profileUrl;
  int? passwordAndProfessionalLinked;

  void copy(User u) {
    this.email = u.email ?? this.email;
    this.password = u.password ?? this.password;
    this.name = u.name ?? this.name;
    this.active = u.active ?? this.active;
    this.cpf = u.cpf ?? this.cpf;
    this.code = u.code ?? this.code;
    this.address = u.address ?? this.address;
    this.addressNumber = u.addressNumber ?? this.addressNumber;
    this.district = u.district ?? this.district;
    this.complement = u.complement ?? this.complement;
    this.city = u.city ?? this.city;
    this.state = u.state ?? this.state;
    this.loggedIn = u.loggedIn ?? this.loggedIn;
    this.token = u.token ?? this.token;
    this.idPerson = u.idPerson ?? this.idPerson;
    this.idProfessional = u.idProfessional ?? this.idProfessional;
    this.profileUrl = u.profileUrl ?? this.profileUrl;
    this.passwordAndProfessionalLinked =
        u.passwordAndProfessionalLinked ?? this.passwordAndProfessionalLinked;
  }

  User.fromLogin(Map<String, dynamic> json) {
    loggedIn = json['loggedIn'];
    token = json['token'];
  }

  User.fromProfessionalInfo(Map<String, dynamic> json) {
    cpf = json['CPF'];
    active = json['active'];
    address = json['address'];
    addressNumber = json['addressNumber'];
    city = json['city'];
    complement = json['complement'];
    district = json['district'];
    email = json['email'];
    idPerson = json['idPerson'];
    idProfessional = json['idProfessional'];
    name = json['name'];
    profileUrl = json['profileUrl'];
    state = json['state'];
  }

  void onCreate(Map<String, dynamic> json) {
    idProfessional = json['idProfessional'];
    passwordAndProfessionalLinked = json['passwordAndProfessionalLinked'];
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "cpf": cpf,
        "password": password,
        "code": code,
        "address": address,
        "addressNumber": addressNumber,
        "district": district,
        "complement": complement,
        "city": city,
        "state": state,
      };

  @override
  String toString() {
    return 'User{email: $email, password: $password, name: $name,'
        '\n active: $active, cpf: $cpf, code: $code,'
        '\n address: $address, addressNumber: $addressNumber, district: $district,'
        '\n complement: $complement, city: $city, state: $state,'
        '\n loggedIn: $loggedIn, token: $token,'
        '\n idPerson: $idPerson,'
        '\n idProfessional: $idProfessional,'
        '\n profileUrl: $profileUrl,'
        '\n passwordAndProfessionalLinked: $passwordAndProfessionalLinked}';
  }
}
