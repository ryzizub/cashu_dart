import '../keyset.dart';

class GetKeysetsResponse {
  GetKeysetsResponse({
    required this.keysets,
  });

  final List<KeySet> keysets;

  factory GetKeysetsResponse.fromJson(Map<String, dynamic> json) {
    return GetKeysetsResponse(
      keysets: List<KeySet>.from(
        json['keysets'].map((x) => KeySet.fromJson(x)),
      ),
    );
  }
}
