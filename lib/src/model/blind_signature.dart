class BlindSignature {
  BlindSignature({
    required this.amount,
    required this.id,
    required this.C,
  });

  final int amount;
  final String id;
  final String C;

  factory BlindSignature.fromJson(Map<String, dynamic> json) {
    return BlindSignature(
      amount: json['amount'] as int,
      id: json['id'] as String,
      C: json['C_'] as String,
    );
  }
}
