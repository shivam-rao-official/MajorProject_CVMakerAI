class Choices {
  Choices({
      this.text, 
      this.index, 
      this.logprobs, 
      this.finishReason,});

  Choices.fromJson(dynamic json) {
    text = json['text'];
    index = json['index'];
    logprobs = json['logprobs'];
    finishReason = json['finish_reason'];
  }
  String? text;
  int? index;
  dynamic logprobs;
  String? finishReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['index'] = index;
    map['logprobs'] = logprobs;
    map['finish_reason'] = finishReason;
    return map;
  }

}