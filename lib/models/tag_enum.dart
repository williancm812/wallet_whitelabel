library wallet_whitelabel;

import 'package:flutter/foundation.dart';

enum TagEnum {
  others,
  lifeProof,
  boleto,
  profile,
}

extension TagEnumExtension on TagEnum {
  String get name => describeEnum(this);

  String get getName {
    switch (this) {
      case TagEnum.others:
        return 'others';
      case TagEnum.lifeProof:
        return 'life_proof';
      case TagEnum.boleto:
        return 'march_receipt_tag';
      case TagEnum.profile:
        return 'profile';
      default:
        throw Exception();
    }
  }
}
