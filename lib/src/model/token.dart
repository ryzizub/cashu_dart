import 'package:cashu/src/model/proof.dart';

class Token {
  Token({
    required this.mint,
    required this.proofs,
  });

  final String mint;
  final List<Proof> proofs;

  factory Token.fromJson(Map<String, dynamic> json) {
    final proofs = json['proofs'] as List<dynamic>;

    final proofList =
        proofs.map((e) => Proof.fromJson(e as Map<String, dynamic>)).toList();

    return Token(
      mint: json['mint'] as String,
      proofs: proofList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mint': mint,
      'proofs': proofs.map((e) => e.toJson()).toList(),
    };
  }
}
