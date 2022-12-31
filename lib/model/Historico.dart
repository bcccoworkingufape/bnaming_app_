//classe que represento uma entidade de histórico

class History {
  late String name;
  late String segment;
  late bool register ;
  late String nomeRegistro;

    History({
    required this.name,
    required this.segment,
    required this.register,
    required this.nomeRegistro
  });

  History.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    segment = json['segment'];
    register = json['register'];
    nomeRegistro = json['nomeRegistro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['segment'] = this.segment;
    data['register'] = this.register;
    data['nomeRegistro'] = this.nomeRegistro;
    return data;
  }
  toLowerCase() {}
}