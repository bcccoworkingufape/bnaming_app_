//classe que represento uma entidade de histórico

class History {
  late String name;
  late String segment;
  late bool register ;
  late String nomeRegistro;
  late String cnpj;

    History({
    required this.name,
    required this.segment,
    required this.register,
    required this.nomeRegistro,
    required this.cnpj
  });

  History.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    segment = json['segment'];
    register = json['register'];
    nomeRegistro = json['nomeRegistro'];
    cnpj = json['cnpj'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['segment'] = this.segment;
    data['register'] = this.register;
    data['nomeRegistro'] = this.nomeRegistro;
    data['cnpj'] = this.cnpj;
    return data;
  }
  toLowerCase() {}
}