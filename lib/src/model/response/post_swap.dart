import 'package:cashu_dart/src/model/blind_signature.dart';

class PostSwapResponse {
  PostSwapResponse({
    required this.signatures,
  });

  final List<BlindSignature> signatures;

  factory PostSwapResponse.fromJson(Map<String, dynamic> json) {
    final signatures = json['signatures'] as List<dynamic>;

    final signatureList = signatures
        .map((e) => BlindSignature.fromJson(e as Map<String, dynamic>))
        .toList();

    return PostSwapResponse(
      signatures: signatureList,
    );
  }
}
