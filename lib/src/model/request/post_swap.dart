import 'package:cashu_dart/src/model/types.dart';

class PostSwapRequest {
  PostSwapRequest({
    required this.inputs,
    required this.outputs,
  });

  final Proofs inputs;
  final BlindedMessages outputs;

  Map<String, dynamic> toJson() {
    return {
      'inputs': inputs.map((e) => e.toJson()).toList(),
      'outputs': outputs.map((e) => e.toJson()).toList(),
    };
  }
}
