import 'package:cashu/src/utils/base64.dart';
import 'package:cashu/src/constants.dart';
import 'package:cashu/src/model/token.dart';

class CashuToken {
  CashuToken({
    required this.token,
    this.unit,
    this.memo,
  });

  final String? unit;
  final String? memo;
  final List<Token> token;

  factory CashuToken.fromJson(Map<String, dynamic> json) {
    final token = json['token'] as List<dynamic>;

    final tokenList =
        token.map((e) => Token.fromJson(e as Map<String, dynamic>)).toList();

    final unit = json['unit'] as String?;
    final memo = json['memo'] as String?;

    return CashuToken(
      token: tokenList,
      unit: unit,
      memo: memo,
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token.map((e) => e.toJson()).toList(),
        if (unit != null) 'unit': unit,
        if (memo != null) 'memo': memo,
      };

  String serialize() {
    final json = toJson();

    final base64url = encodeJsonToBase64(json);

    final token = '$kTokenPrefix$kTokenVersion3$base64url';
    return token;
  }
}
