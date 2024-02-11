import 'package:cashu_dart/src/model/unit.dart';

class PostMintQuoteBolt11Request {
  PostMintQuoteBolt11Request({
    required this.amount,
    this.unit = Unit.sat,
  });

  final int amount;
  final Unit unit;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'unit': unit.val,
    };
  }
}
