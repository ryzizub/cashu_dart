class BlindedMessage {
  BlindedMessage({
    required this.amount,
    required this.id,
    required this.B_,
  });

  final int amount;
  final String id;
  final String B_;
}

typedef BlindedMessages = List<BlindedMessage>;
