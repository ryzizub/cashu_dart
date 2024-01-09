class Proof {
  Proof({
    required this.amount,
    required this.id,
    required this.secret,
    required this.C,
  });

  final int amount;
  final String id;
  final String secret;
  final String C;

  factory Proof.fromJson(Map<String, dynamic> json) {
    return Proof(
      amount: json['amount'] as int,
      id: json['id'] as String,
      secret: json['secret'] as String,
      C: json['C'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'secret': secret,
      'C': C,
    };
  }
}
