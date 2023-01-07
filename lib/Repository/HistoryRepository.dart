import 'dart:collection';
import 'dart:convert';

import 'package:bnaming_app/model/Historico.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

//classe para gerenciamento das listas relacionadas ao historico
class HistoryRepository extends ChangeNotifier{
 final List<History> _list=[];
  List<String> conferir=[];
  List<String> salvar=[];
  List<History> _selecionadas=[];




  UnmodifiableListView<History> get Lista => UnmodifiableListView(_list);
  UnmodifiableListView<History> get Selecionadas => UnmodifiableListView(_selecionadas);

//adiciona um historico a lista que é exibida na pagina de historico
  saveAll(History history) async{
    String confere = '';
    confere = history.name+"/"+history.segment;
    confere = confere.toLowerCase();
    if(!conferir.contains(confere)){
      if(_list.length<20){
        _list.insert(0, history);
        conferir.insert(0, confere);

      }else{
        remove(_list[_list.length-1]);
        _list.insert(0, history);
        conferir.insert(0, confere);
      }
    salvar.add(json.encode(history.toJson()));  
    }
    notifyListeners();
  }
  
  //salva a lista "salvar" usando sharedPreferences
  setAll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("history",salvar);
  }

//recupera a lista salva no método anterior
   getAll() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<String>? jsonHistory = preferences.getStringList("history");
      for(int i =0; i< jsonHistory!.length;i++){
        Map<String, dynamic> mapHistory = jsonDecode(jsonHistory[i]);
        History history = History.fromJson(mapHistory);
        saveAll(history);
      }
      
  }
 //remove um historico da lista que é exibida
  remove(History history){
    _list.remove(history);
    conferir.remove(history.name+"/"+history.segment);
    salvar.remove(json.encode(history.toJson()));
    setAll();
    notifyListeners();
  }

  // limpa a lista de históricos exibidos
  removeAll(){
    _list.clear();
    conferir.clear();
    salvar.clear();
    setAll();
    notifyListeners();
  }


  selecionar(History history){
      _selecionadas.add(history);
      notifyListeners();
  }


  removeSelecionadas(History history){
    _selecionadas.remove(history);
    notifyListeners();
  }

  limparSelecionadas(){
    _selecionadas.clear();
    notifyListeners();
  }

//exclui todos os elementos presentes em selecionadas da lista que é exibida
  removerSelecionadasHistorico(){
      _selecionadas.forEach((History history) {
        remove(history);
       });
      limparSelecionadas();
  }

  int tamanho() {
    int tam =_list.length;
    if(tam<10){
        return tam;
    }else{
        return 10;
    }
            
    }
}