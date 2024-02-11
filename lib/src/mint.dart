import 'dart:convert';

import 'package:cashu_dart/src/model/request/post_mint_bolt11.dart';
import 'package:cashu_dart/src/model/request/post_mint_quote_bolt11.dart';
import 'package:cashu_dart/src/model/request/post_swap.dart';
import 'package:cashu_dart/src/model/response/get_info.dart';
import 'package:cashu_dart/src/model/response/get_keys.dart';
import 'package:cashu_dart/src/model/response/get_keysets.dart';
import 'package:cashu_dart/src/model/response/post_mint_bolt11.dart';
import 'package:cashu_dart/src/model/response/post_mint_quote_bolt11.dart';
import 'package:cashu_dart/src/model/response/post_swap.dart';
import 'package:cashu_dart/src/model/types.dart';
import 'package:cashu_dart/src/model/unit.dart';
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

  Future<PostMintQuoteBolt11Response> mintQuoteBolt11(
    int amount, [
    Unit unit = Unit.sat,
  ]) async {
    final requestedData = await mintQuote(
      'bolt11',
      PostMintQuoteBolt11Request(
        amount: amount,
        unit: unit,
      ).toJson(),
    );

    return PostMintQuoteBolt11Response.fromJson(requestedData!);
  }

  Future<Map<String, dynamic>?> mintQuote(
    String method,
    Map<String, dynamic> requestBody,
  ) async {
    final requestedData = await request(
      '$url/v1/mint/quote/$method',
      'POST',
      jsonEncode(requestBody),
    );

    return requestedData;
  }

  Future<Map<String, dynamic>?> quoteSate(String method, String quoteId) async {
    final requestedData = await request(
      '$url/v1/mint/quote/$method/$quoteId',
      'GET',
      null,
    );

    return requestedData;
  }

  Future<PostMintQuoteBolt11Response?> quoteStateBolt11(String quoteId) async {
    final requestedData = await quoteSate('bolt11', quoteId);

    final respon = requestedData != null
        ? PostMintQuoteBolt11Response.fromJson(requestedData)
        : null;
    return respon;
  }

  Future<Map<String, dynamic>?> mint(
      String method, Map<String, dynamic> requestBody) async {
    final requestedData = await request(
      '$url/v1/mint/$method',
      'POST',
      jsonEncode(requestBody),
    );

    return requestedData;
  }

  Future<PostMintBolt11Response?> mintBolt11(
    String quoteId,
    BlindedMessages outputs,
  ) async {
    final requestedData = await mint(
      'bolt11',
      PostMintBolt11Request(quote: quoteId, outputs: outputs).toJson(),
    );

    final respon = requestedData != null
        ? PostMintBolt11Response.fromJson(requestedData)
        : null;
    return respon;
  }

  Future<GetInfoResponse> getInfo() async {
    final requestedData = await request('$url/v1/info', 'GET', null);

    return GetInfoResponse.fromJson(requestedData!);
  }
}
