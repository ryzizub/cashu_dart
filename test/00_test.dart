import 'package:cashu/cashu.dart';
import 'package:cashu/src/model/cashu_token.dart';
import 'package:cashu/src/utils.dart';
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
      final point = hashToCurve(hexToBytes(x));
      final pointResult = bytesToHex(point.getEncoded());

      expect(pointResult, matches(expectedPoint));
    });

    test('Test 2 (hex encoded)', () async {
      const x =
          '0000000000000000000000000000000000000000000000000000000000000001';
      const expectedPoint =
          '02ec4916dd28fc4c10d78e287ca5d9cc51ee1ae73cbfde08c6b37324cbfaac8bc5';
      final point = hashToCurve(hexToBytes(x));
      final pointResult = bytesToHex(point.getEncoded());

      expect(pointResult, matches(expectedPoint));
    });

    test('Test 3 (hex encoded)', () async {
      const x =
          '0000000000000000000000000000000000000000000000000000000000000002';
      const expectedPoint =
          '02076c988b353fcbb748178ecb286bc9d0b4acf474d4ba31ba62334e46c97c416a';
      final point = hashToCurve(hexToBytes(x));
      final pointResult = bytesToHex(point.getEncoded());

      expect(pointResult, matches(expectedPoint));
    });
  });

  group('Blinded messages', () {
    test('Test 1 (hex encoded)', () async {
      const x =
          '0000000000000000000000000000000000000000000000000000000000000000';
      const expectedPoint =
          '0266687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925';
      final point = hashToCurve(hexToBytes(x));
      final pointResult = bytesToHex(point.getEncoded());

      expect(pointResult, matches(expectedPoint));
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
        'token': [
          {
            'mint': 'https://8333.space:3338',
            'proofs': [
              {
                'id': 'DSAl9nvvyfva',
                'amount': 2,
                'secret': 'EhpennC9qB3iFlW8FZ_pZw',
                'C': '02c020067db727d586bc3183aecf97fcb'
                    '800c3f4cc4759f69c626c9db5d8f5b5d4',
              },
              {
                'id': 'DSAl9nvvyfva',
                'amount': 8,
                'secret': 'TmS6Cv0YT5PU_5ATVKnukw',
                'C': '02ac910bef28cbe5d7325415d5c263026f15f9'
                    'b967a079ca9779ab6e5c2db133a7',
              }
            ],
          }
        ],
        'memo': 'Thank you.',
      };

      final token = CashuToken.fromJson(json);

      final serialized = token.serialize();

      const expectedResult =
          'cashuAeyJ0b2tlbiI6W3sibWludCI6Imh0dHBzOi8vODMzMy5zcGFjZTozMzM4Iiwi'
          'cHJvb2ZzIjpbeyJpZCI6IkRTQWw5bnZ2eWZ2YSIsImFtb3VudCI6Miwic2VjcmV0Ijo'
          'iRWhwZW5uQzlxQjNpRmxXOEZaX3BadyIsIkMiOiIwMmMwMjAwNjdkYjcyN2Q1ODZiYz'
          'MxODNhZWNmOTdmY2I4MDBjM2Y0Y2M0NzU5ZjY5YzYyNmM5ZGI1ZDhmNWI1ZDQifSx7I'
          'mlkIjoiRFNBbDludnZ5ZnZhIiwiYW1vdW50Ijo4LCJzZWNyZXQiOiJUbVM2Q3YwWVQ'
          '1UFVfNUFUVktudWt3IiwiQyI6IjAyYWM5MTBiZWYyOGNiZTVkNzMyNTQxNWQ1YzI2Mz'
          'AyNmYxNWY5Yjk2N2EwNzljYTk3NzlhYjZlNWMyZGIxMzNhNyJ9XX1dLCJtZW1vIjoiVG'
          'hhbmt5b3UuIn0';

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
