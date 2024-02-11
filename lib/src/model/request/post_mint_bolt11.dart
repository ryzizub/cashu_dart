import 'package:cashu_dart/src/model/types.dart';

class PostMintBolt11Request {
  PostMintBolt11Request({
    required this.quote,
    required this.outputs,
  });

  final String quote;
  final BlindedMessages outputs;

  Map<String, dynamic> toJson() {
    return {
      'quote': quote,
      'outputs': outputs.map((e) => e.toJson()).toList(),
    };
  }
}
