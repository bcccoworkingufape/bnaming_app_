//classe que represento uma entidade de histórico

class History {
  late String name;
  late String segment;
  late bool register ;

    History({
    required this.name,
    required this.segment,
    required this.register
  });

  History.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    segment = json['segment'];
    register = json['register'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['segment'] = this.segment;
    data['register'] = this.register;
    return data;
  }
  toLowerCase() {}
}