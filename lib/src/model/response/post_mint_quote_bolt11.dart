class PostMintQuoteBolt11Response {
  PostMintQuoteBolt11Response({
    required this.quote,
    required this.request,
    required this.paid,
    required this.expiry,
  });

  final String quote;
  final String request;
  final bool paid;
  final int expiry;

  factory PostMintQuoteBolt11Response.fromJson(Map<String, dynamic> json) {
    return PostMintQuoteBolt11Response(
      quote: json['quote'] as String,
      request: json['request'] as String,
      paid: json['paid'] as bool,
      expiry: json['expiry'] as int,
    );
  }
}
