import 'package:cashu/cashu.dart';
import 'package:cashu/src/model/cashu_token.dart';
import 'package:cashu/src/bdkhe.dart';
import 'package:test/test.dart';

/// Tests are based on the following test vectors:
/// https://github.com/cashubtc/nuts/blob/main/test-vectors/00-tests.md
void main() {
  group('hash-to-curve tests', () {
    test('Test 1 (hex encoded)', () async {
      const x =
          '0000000000000000000000000000000000000000000000000000000000000000';
      const expectedPoint =
          '0266687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925';
      final point = hashHexToCurveHex(x);

      expect(point, matches(expectedPoint));
    });

    test('Test 2 (hex encoded)', () async {
      const x =
          '0000000000000000000000000000000000000000000000000000000000000001';
      const expectedPoint =
          '02ec4916dd28fc4c10d78e287ca5d9cc51ee1ae73cbfde08c6b37324cbfaac8bc5';
      final point = hashHexToCurveHex(x);

      expect(point, matches(expectedPoint));
    });

    test('Test 3 (hex encoded)', () async {
      const x =
          '0000000000000000000000000000000000000000000000000000000000000002';
      const expectedPoint =
          '02076c988b353fcbb748178ecb286bc9d0b4acf474d4ba31ba62334e46c97c416a';
      final point = hashHexToCurveHex(x);

      expect(point, matches(expectedPoint));
    });
  });

  group('Blinded messages', () {
    test('Test 1 (hex encoded)', () async {
      const x = 'test_message';
      const r =
          '0000000000000000000000000000000000000000000000000000000000000001';
      const expectedResult =
          "02a9acc1e48c25eeeb9289b5031cc57da9fe72f3fe2861d264bdc074209b107ba2";
      final point = getBlindingHex(x, blindingFactor: r);

      expect(point, matches(expectedResult));
    });

    test('Test 2 (hex encoded)', () async {
      const x = 'hello';
      const r =
          '6d7e0abffc83267de28ed8ecc8760f17697e51252e13333ba69b4ddad1f95d05';
      const expectedResult =
          "0249eb5dbb4fac2750991cf18083388c6ef76cde9537a6ac6f3e6679d35cdf4b0c";
      final point = getBlindingHex(x, blindingFactor: r);

      expect(point, matches(expectedResult));
    });
  });

  group('Deserialization of TokenV3', () {
    test('Incorrect prefix (casshuA)', () async {
      const x =
          'casshuAeyJ0b2tlbiI6IFt7InByb29mcyI6IFt7ImlkIjogIkplaFpMVTZuQ3BSZCIsI'
          'CJhbW91bnQiOiAyLCAic2VjcmV0IjogIjBFN2lDazRkVmxSZjVQRjFnNFpWMnciLCAi'
          'QyI6ICIwM2FiNTgwYWQ5NTc3OGVkNTI5NmY4YmVlNjU1ZGJkN2Q2NDJmNWQzMmRlOGUy'
          'NDg0NzdlMGI0ZDZhYTg2M2ZjZDUifSwgeyJpZCI6ICJKZWhaTFU2bkNwUmQiLCAiYW1'
          'vdW50IjogOCwgInNlY3JldCI6ICJzNklwZXh3SGNxcXVLZDZYbW9qTDJnIiwgIkMiOi'
          'AiMDIyZDAwNGY5ZWMxNmE1OGFkOTAxNGMyNTliNmQ2MTRlZDM2ODgyOWYwMmMzODc3M2'
          'M0NzIyMWY0OTYxY2UzZjIzIn1dLCAibWludCI6ICJodHRwOi8vbG9jYWxob3N0OjMzM'
          'zgifV19';

      expect(() => Cashu.getDecodedToken(x), throwsException);
    });

    test('No prefix', () async {
      const x = 'eyJ0b2tlbiI6IFt7InByb29mcyI6IFt7ImlkIjogIkplaFpMVTZuQ3BSZCIsI'
          'CJhbW91bnQiOiAyLCAic2VjcmV0IjogIjBFN2lDazRkVmxSZjVQRjFnNFpWMnciLCAi'
          'QyI6ICIwM2FiNTgwYWQ5NTc3OGVkNTI5NmY4YmVlNjU1ZGJkN2Q2NDJmNWQzMmRlOGUy'
          'NDg0NzdlMGI0ZDZhYTg2M2ZjZDUifSwgeyJpZCI6ICJKZWhaTFU2bkNwUmQiLCAiYW1v'
          'dW50IjogOCwgInNlY3JldCI6ICJzNklwZXh3SGNxcXVLZDZYbW9qTDJnIiwgIkMiOiAi'
          'MDIyZDAwNGY5ZWMxNmE1OGFkOTAxNGMyNTliNmQ2MTRlZDM2ODgyOWYwMmMzODc3M2M'
          '0NzIyMWY0OTYxY2UzZjIzIn1dLCAibWludCI6ICJodHRwOi8vbG9jYWxob3N0OjMzMzg'
          'ifV19';

      expect(() => Cashu.getDecodedToken(x), throwsException);
    });

    test('Serialization', () async {
      const json = {
        "token": [
          {
            "mint": "https://8333.space:3338",
            "proofs": [
              {
                "amount": 2,
                "id": "009a1f293253e41e",
                "secret": "407915bc212be61a77e3e6d2aeb4c727980bda51cd06a6afc29"
                    "e2861768a7837",
                "C": "02bc9097997d81afb2cc7346b5e4345a9346bd2a506eb795859"
                    "8a72f0cf85163ea"
              },
              {
                "amount": 8,
                "id": "009a1f293253e41e",
                "secret": "fe15109314e61d7756b0f8ee0f23a624acaa3f4e042f6143"
                    "3c728c7057b931be",
                "C": "029e8e5050b890a7d6c0968db16bc1d5d5fa040ea1de284f6ec69"
                    "d61299f671059"
              }
            ]
          }
        ],
        "unit": "sat",
        "memo": "Thank you."
      };

      final token = CashuToken.fromJson(json);

      final serialized = token.serialize();

      const expectedResult =
          'cashuAeyJ0b2tlbiI6W3sibWludCI6Imh0dHBzOi8vODMzMy5zcGFjZTozMzM4Iiwic'
          'HJvb2ZzIjpbeyJhbW91bnQiOjIsImlkIjoiMDA5YTFmMjkzMjUzZTQxZSIsInNlY3Jl'
          'dCI6IjQwNzkxNWJjMjEyYmU2MWE3N2UzZTZkMmFlYjRjNzI3OTgwYmRhNTFjZDA2YTZ'
          'hZmMyOWUyODYxNzY4YTc4MzciLCJDIjoiMDJiYzkwOTc5OTdkODFhZmIyY2M3MzQ2Yj'
          'VlNDM0NWE5MzQ2YmQyYTUwNmViNzk1ODU5OGE3MmYwY2Y4NTE2M2VhIn0seyJhbW91b'
          'nQiOjgsImlkIjoiMDA5YTFmMjkzMjUzZTQxZSIsInNlY3JldCI6ImZlMTUxMDkzMTRl'
          'NjFkNzc1NmIwZjhlZTBmMjNhNjI0YWNhYTNmNGUwNDJmNjE0MzNjNzI4YzcwNTdiOTM'
          'xYmUiLCJDIjoiMDI5ZThlNTA1MGI4OTBhN2Q2YzA5NjhkYjE2YmMxZDVkNWZhMDQwZW'
          'ExZGUyODRmNmVjNjlkNjEyOTlmNjcxMDU5In1dfV0sInVuaXQiOiJzYXQiLCJtZW1vI'
          'joiVGhhbmsgeW91LiJ9';

      expect(serialized, expectedResult);
    });
  });

  group('Deserialization of TokenV3', () {
    test('Incorrect prefix (casshuA)', () async {
      const x =
          'casshuAeyJ0b2tlbiI6IFt7InByb29mcyI6IFt7ImlkIjogIkplaFpMVTZuQ3BSZCIsI'
          'CJhbW91bnQiOiAyLCAic2VjcmV0IjogIjBFN2lDazRkVmxSZjVQRjFnNFpWMnciLCAi'
          'QyI6ICIwM2FiNTgwYWQ5NTc3OGVkNTI5NmY4YmVlNjU1ZGJkN2Q2NDJmNWQzMmRlOGUy'
          'NDg0NzdlMGI0ZDZhYTg2M2ZjZDUifSwgeyJpZCI6ICJKZWhaTFU2bkNwUmQiLCAiYW1'
          'vdW50IjogOCwgInNlY3JldCI6ICJzNklwZXh3SGNxcXVLZDZYbW9qTDJnIiwgIkMiOi'
          'AiMDIyZDAwNGY5ZWMxNmE1OGFkOTAxNGMyNTliNmQ2MTRlZDM2ODgyOWYwMmMzODc3M2'
          'M0NzIyMWY0OTYxY2UzZjIzIn1dLCAibWludCI6ICJodHRwOi8vbG9jYWxob3N0OjMzM'
          'zgifV19';

      expect(() => Cashu.getDecodedToken(x), throwsException);
    });

    test('No prefix', () async {
      const x = 'eyJ0b2tlbiI6IFt7InByb29mcyI6IFt7ImlkIjogIkplaFpMVTZuQ3BSZCIsI'
          'CJhbW91bnQiOiAyLCAic2VjcmV0IjogIjBFN2lDazRkVmxSZjVQRjFnNFpWMnciLCAi'
          'QyI6ICIwM2FiNTgwYWQ5NTc3OGVkNTI5NmY4YmVlNjU1ZGJkN2Q2NDJmNWQzMmRlOGUy'
          'NDg0NzdlMGI0ZDZhYTg2M2ZjZDUifSwgeyJpZCI6ICJKZWhaTFU2bkNwUmQiLCAiYW1v'
          'dW50IjogOCwgInNlY3JldCI6ICJzNklwZXh3SGNxcXVLZDZYbW9qTDJnIiwgIkMiOiAi'
          'MDIyZDAwNGY5ZWMxNmE1OGFkOTAxNGMyNTliNmQ2MTRlZDM2ODgyOWYwMmMzODc3M2M'
          '0NzIyMWY0OTYxY2UzZjIzIn1dLCAibWludCI6ICJodHRwOi8vbG9jYWxob3N0OjMzMzg'
          'ifV19';

      expect(() => Cashu.getDecodedToken(x), throwsException);
    });

    test('Correst deserialization', () async {
      const x =
          'cashuAeyJ0b2tlbiI6W3sibWludCI6Imh0dHBzOi8vODMzMy5zcGFjZTozMzM4Iiwi'
          'cHJvb2ZzIjpbeyJpZCI6IkRTQWw5bnZ2eWZ2YSIsImFtb3VudCI6Miwic2VjcmV0Ij'
          'oiRWhwZW5uQzlxQjNpRmxXOEZaX3BadyIsIkMiOiIwMmMwMjAwNjdkYjcyN2Q1ODZiY'
          'zMxODNhZWNmOTdmY2I4MDBjM2Y0Y2M0NzU5ZjY5YzYyNmM5ZGI1ZDhmNWI1ZDQifSx7'
          'ImlkIjoiRFNBbDludnZ5ZnZhIiwiYW1vdW50Ijo4LCJzZWNyZXQiOiJUbVM2Q3YwWVQ'
          '1UFVfNUFUVktudWt3IiwiQyI6IjAyYWM5MTBiZWYyOGNiZTVkNzMyNTQxNWQ1YzI2Mz'
          'AyNmYxNWY5Yjk2N2EwNzljYTk3NzlhYjZlNWMyZGIxMzNhNyJ9XX1dLCJtZW1vIjoi'
          'VGhhbmt5b3UuIn0=';

      final token = Cashu.getDecodedToken(x);

      expect(token.memo, 'Thankyou.');
      expect(token.unit, null);
      expect(token.token.length, 1);
      expect(token.token.first.mint, 'https://8333.space:3338');
      expect(token.token.first.proofs.length, 2);
    });
  });
}
