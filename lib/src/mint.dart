import 'package:cashu_dart/src/model/response/get_keys.dart';
import 'package:cashu_dart/src/utils/request.dart';

/// Class that handles Cashu Mint API.
class CashuMint {
  /// Takes [String] url as a parameter
  CashuMint({
    required this.url,
  });

  final String url;

  Future<GetKeysResponse?> getKeys({
    String? keysetId,
  }) async {
    var endpoint = '$url/v1/keys';

    if (keysetId != null) {
      endpoint = '$endpoint/$keysetId';
    }

    final requestedData = await request(endpoint, 'GET', null);

    final respon =
        requestedData != null ? GetKeysResponse.fromJson(requestedData) : null;
    return respon;
  }
}
