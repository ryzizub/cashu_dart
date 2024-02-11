import 'package:cashu_dart/src/model/blind_signature.dart';
import 'package:cashu_dart/src/model/types.dart';

class PostMintBolt11Response {
  PostMintBolt11Response({
    required this.signatures,
  });

  final BlindedSignatures signatures;

  factory PostMintBolt11Response.fromJson(Map<String, dynamic> json) {
    final signatures = json['signatures'] as List<dynamic>;

    final signatureList = signatures
        .map((e) => BlindSignature.fromJson(e as Map<String, dynamic>))
        .toList();

    return PostMintBolt11Response(
      signatures: signatureList,
    );
  }
}
