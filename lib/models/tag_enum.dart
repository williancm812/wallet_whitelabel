import 'package:flutter/foundation.dart';

enum TagEnum {
  others,
  lifeProofFront,
  lifeProofBack,
  boleto,
  profile,
}

extension TagEnumExtension on TagEnum {
  String get name => describeEnum(this);

  String get getName {
    switch (this) {
      case TagEnum.others:
        return 'others';
      case TagEnum.lifeProofFront:
        return 'life_proof';
      case TagEnum.lifeProofBack:
        return 'life_proof_back';
      case TagEnum.boleto:
        return 'march_receipt_tag';
      case TagEnum.profile:
        return 'profile';
      default:
        throw Exception();
    }
  }
}
