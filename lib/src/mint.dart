import 'dart:convert';

import 'package:cashu_dart/src/model/request/post_swap.dart';
import 'package:cashu_dart/src/model/response/get_keys.dart';
import 'package:cashu_dart/src/model/response/get_keysets.dart';
import 'package:cashu_dart/src/model/response/post_swap.dart';
import 'package:cashu_dart/src/model/types.dart';
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

  Future<GetKeysetsResponse> getKeysets() async {
    final requestedData = await request('$url/v1/keysets', 'GET', null);

    return GetKeysetsResponse.fromJson(requestedData!);
  }

  Future<PostSwapResponse> swap({
    required Proofs proofs,
    required BlindedMessages messages,
  }) async {
    // Ascending sort of messages by amount
    final orderedMessages = messages
      ..sort((a, b) => a.amount.compareTo(b.amount));

    final requestedData = await request(
      '$url/v1/swap',
      'POST',
      jsonEncode(
        PostSwapRequest(inputs: proofs, outputs: orderedMessages).toJson(),
      ),
    );

    return PostSwapResponse.fromJson(requestedData!);
  }
}
