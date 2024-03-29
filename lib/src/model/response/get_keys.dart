import '../keyset.dart';

class GetKeysResponse {
  GetKeysResponse({
    required this.keysets,
  });

  final List<KeySet> keysets;

  factory GetKeysResponse.fromJson(Map<String, dynamic> json) {
    return GetKeysResponse(
      keysets: List<KeySet>.from(
        json['keysets'].map((x) => KeySet.fromJson(x)),
      ),
    );
  }
}
