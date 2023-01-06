import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class RBR{

// CLASSE QUE VERIFICA SE NOME ESTÁ REGISTRADO NO REGISTRO.BR
  Future<bool> getAPI(String nome) async{
    String nome1 = nome.replaceAll( ' ', '');
   var  url = 'https://rdap.registro.br/domain/$nome1.com.br';
   var response = await http.get(Uri.parse(url));
    print("Executando método GET na rota registroBR");
    print(response.statusCode);
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    } 
  }
  
  Future<String> nomeRegistro(String nome) async {
   String nomeRegistro;
   String nome1 = nome.replaceAll( ' ', '');
   var  url = 'https://rdap.registro.br/domain/$nome1.com.br';
   var response = await http.get(Uri.parse(url));
   var dado = jsonDecode(response.body);
   print("executando metodo nome registro");
   var dado1 = dado['entities'];
   var dado2 = dado1[0];
   var dado3 = dado2['vcardArray'];
   var dado4 = dado3[1][2][3];
    nomeRegistro = dado4;
    return nomeRegistro;
  }
    
    Future<String> cnpj(String nome) async{
      String cnpj;
      String nome1 = nome.replaceAll( ' ', '');
      var  url = 'https://rdap.registro.br/domain/$nome1.com.br';
      var response =  await http.get(Uri.parse(url));
      var dado = jsonDecode(response.body);
      print("executando metodo cnpj");
      var dado1 = dado['entities'][0];
      var dado2 = dado1['publicIds'][0];
      var dado3 = dado2['identifier'];
      cnpj=dado3;
      return cnpj;
    }

    //"publicIds"


   
  
}