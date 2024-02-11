class BlindedMessage {
  BlindedMessage({
    required this.amount,
    required this.id,
    required this.B,
  });

  final int amount;
  final String id;
  final String B;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'id': id,
      'B_': B,
    };
  }
}
