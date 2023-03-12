//classe que represento uma entidade de histórico

import 'package:bnaming_app/model/Cor.dart';
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

   Icon IconSegment(String segment, Color cor){
    
    
    switch(segment){
      case 'alimentos/bebidas':
        return  Icon(Icons.restaurant, color: cor);

      case 'automotivo':
        return  Icon(Icons.time_to_leave, color: cor);

      case 'bens de consumo':
        return  Icon(Icons.shopping_cart, color: cor);

      case 'energia/combustível':
        return  Icon(Icons.wb_incandescent, color: cor);

      case 'entretenimento':
        return  Icon(Icons.music_note, color: cor);

      case 'financeiro':
        return  Icon(Icons.local_atm, color: cor);

      case 'logistica':
        return  Icon(Icons.insert_chart, color: cor);
        
      case 'serviços':
        return  Icon(Icons.build, color: cor);

      case 'tecnologia':
        return  Icon(Icons.laptop, color: cor);

      case 'varejo':
        return  Icon(Icons.local_offer, color: cor);

    }
    return  Icon(Icons.error, color: cor);

  }
}