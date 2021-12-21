library wallet_whitelabel;

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
