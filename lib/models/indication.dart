// {"idIndications":3,
// "image":"https://storage.googleapis.com/rodopay-indications-fil",
// "uri":"https://sites.google.com/view/prototypeideas",}
class Indication {
  Indication();

  num? idIndications;
  String? image;
  String? uri;

  Indication.fromJson(Map<String, dynamic> json) {
    idIndications = json['idIndications'];
    image = json['image'];
    uri = json['uri'];
  }

  @override
  String toString() {
    return 'Indication{idIndications: $idIndications, image: $image, uri: $uri}';
  }
}
