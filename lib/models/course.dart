

class Course {
  Course();

  String? institutionName;
  String? institutionUnit;
  String? modality;
  String? registrationNumber;
  String? title;
  String? yearCompletion;
  String? paymentRecord;
  String? paymentRecordTime;

  String? dateInclusion;
  bool? validated;

  Course.fromJson(Map<String, dynamic> json) {
    institutionName = json['institutionName'];
    institutionUnit = json['institutionUnit'];
    modality = json['modality'];
    registrationNumber = json['registrationNumber'];
    title = json['title'];
    yearCompletion = json['yearCompletion'];
    paymentRecord = json['paymentRecord'];
    paymentRecordTime = json['paymentRecordTime'];
  }

  void dateInclusionAndValidatedAdd(Map<String, dynamic> json) {
    dateInclusion = json['dateInclusion'];
    validated = json['validated'];
  }

  Map<String, dynamic> toJson() => {
        "institutionName": institutionName,
        "institutionUnit": institutionUnit,
        "modality": modality,
        "registrationNumber": registrationNumber,
        "title": title,
        "yearCompletion": yearCompletion,
      };

  @override
  String toString() {
    return 'Course{institutionName: $institutionName, institutionUnit: $institutionUnit, modality: $modality, registrationNumber: $registrationNumber, title: $title, yearCompletion: $yearCompletion, paymentRecord: $paymentRecord, paymentRecordTime: $paymentRecordTime, dateInclusion: $dateInclusion, validated: $validated}';
  }
}
