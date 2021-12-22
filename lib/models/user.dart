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
    email = u.email ?? email;
    password = u.password ?? password;
    name = u.name ?? name;
    active = u.active ?? active;
    cpf = u.cpf ?? cpf;
    code = u.code ?? code;
    address = u.address ?? address;
    addressNumber = u.addressNumber ?? addressNumber;
    district = u.district ?? district;
    complement = u.complement ?? complement;
    city = u.city ?? city;
    state = u.state ?? state;
    loggedIn = u.loggedIn ?? loggedIn;
    token = u.token ?? token;
    idPerson = u.idPerson ?? idPerson;
    idProfessional = u.idProfessional ?? idProfessional;
    profileUrl = u.profileUrl ?? profileUrl;
    passwordAndProfessionalLinked = u.passwordAndProfessionalLinked ?? passwordAndProfessionalLinked;
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
