//classe que represento uma entidade de histórico

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

   Icon IconSegment(String segment){
    
    switch(segment){
      case 'alimentos/bebidas':
        return const Icon(Icons.restaurant);

      case 'automotivo':
        return const Icon(Icons.time_to_leave);

      case 'bens de consumo':
        return const Icon(Icons.shopping_cart);

      case 'energia/combustível':
        return const Icon(Icons.wb_incandescent);

      case 'entretenimento':
        return const Icon(Icons.music_note);

      case 'financeiro':
        return const Icon(Icons.local_atm);

      case 'logistica':
        return const Icon(Icons.insert_chart);
        
      case 'serviços':
        return const Icon(Icons.build);

      case 'tecnologia':
        return const Icon(Icons.laptop);

      case 'varejo':
        return const Icon(Icons.local_offer);

    }
    return const Icon(Icons.error);

  }
}