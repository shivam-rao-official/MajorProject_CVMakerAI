import 'Choices.dart';
import 'Usage.dart';

class Skills {
  Skills({
      this.id, 
      this.object, 
      this.created, 
      this.model, 
      this.choices, 
      this.usage,});

  Skills.fromJson(dynamic json) {
    id = json['id'];
    object = json['object'];
    created = json['created'];
    model = json['model'];
    if (json['choices'] != null) {
      choices = [];
      json['choices'].forEach((v) {
        choices!.add(Choices.fromJson(v));
      });
    }
    usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
  }
  String ?id;
  String? object;
  int ?created;
  String? model;
  List<Choices>? choices;
  Usage? usage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['object'] = object;
    map['created'] = created;
    map['model'] = model;
    if (choices != null) {
      map['choices'] = choices!.map((v) => v.toJson()).toList();
    }
    if (usage != null) {
      map['usage'] = usage!.toJson();
    }
    return map;
  }

}