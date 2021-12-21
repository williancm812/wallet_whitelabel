library wallet_whitelabel;

class FileApp {
  FileApp();

  String? dateInclusion;
  String? externalUrl;
  String? fileDescription;
  String? fileName;
  int? idProfessionalFiles;
  String? originalFileName;
  String? tag;

  FileApp.fromJson(Map<String, dynamic> json) {
    dateInclusion = json['dateInclusion'];
    externalUrl = json['externalUrl'];
    fileDescription = json['fileDescription'];
    fileName = json['fileName'];
    idProfessionalFiles = json['idProfessionalFiles'];
    originalFileName = json['originalFileName'];
    tag = json['tag'];
  }
}
