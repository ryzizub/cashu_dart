import 'package:cashu/src/base64.dart';
import 'package:cashu/src/constants.dart';
import 'package:cashu/src/model/cashu_token.dart';

class Cashu {
  static CashuToken getDecodedToken(String serialized) {
    final prefix = serialized.startsWith(kTokenPrefix);

    if (!prefix) {
      throw Exception('Invalid token prefix');
    }

    final version =
        serialized.substring(kTokenPrefix.length, kTokenPrefix.length + 1);

    if (!kSupportedVersions.contains(version)) {
      throw Exception('Unsupported token version');
    }

    final base64Dirty = serialized.substring(kTokenPrefix.length + 1);

    final cleanedBase64url = base64UrlToBase64(base64Dirty);

    final json = base64toJson(cleanedBase64url);

    return CashuToken.fromJson(json);
  }

  static CashuToken getDecodedTokenUri(Uri uri) {
    if (kCashuUriSchemes.contains(uri.scheme)) {
      throw Exception('Invalid scheme');
    }

    final token = uri.host;

    return getDecodedToken(token);
  }
}
