


import 'package:bnaming_app/http/RegistroBR.dart';
import 'package:bnaming_app/model/Cor.dart';
import 'package:bnaming_app/model/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Repository/HistoryRepository.dart';
import '../../model/Historico.dart';
import '../evaluationPage/evaluation_page.dart';

class HistoryCard extends StatefulWidget {
  History history;
  
  
  
  

  HistoryCard({Key? key,required this.history}) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  List<String> selecionadas =[];
  Cor cor = Cor();
  
  

  @override
   mostrarDetalhes() async {
    Alert alert=Alert();
    final RBR _api = RBR();
    var registrado = _api.getAPI(widget.history.name);
    bool registro = await registrado;
    if(registro){  
      alert.snackBar1(context) ; 
    } 
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EvaluationPage(),
      settings: RouteSettings(
      arguments: {
      "name": widget.history.name,
      "segment": widget.history.segment
      }
      )
      )
      );
  }
  
  @override
  Widget build(BuildContext context) {
      cor.opcao1();
    return Card (
      
      
      shape: RoundedRectangleBorder(
        side:  BorderSide(
          color:cor.corSecundaria,
          width: 5,
          
          ),
        borderRadius: BorderRadius.circular(15.0)
      ),
        
        color: cor.corPrimaria,
      
      
      margin: const EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => mostrarDetalhes(),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left:20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children:[
                      
                        ListTile(
                          title:
                          Text(widget.history.name, 
                          style:  TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: cor.corSecundaria
                    
                          ),
                            ),
                        
                        subtitle: Text("Segmento: ${widget.history.segment}",
                        style:  TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: cor.corSecundaria,
                        ),
                        ),
                       
                            
                        )
                    ]
                    ),
                    
                    
                )
                
                ),
                PopupMenuButton(
                  color:  cor.corSecundaria,
                  icon: const Icon(Icons.more_vert,color:  Colors.white,),
                  itemBuilder: (context) =>[
                    PopupMenuItem(child: ListTile(
                      title: const Text("remover do Histórico"),
                      onTap: (){
                        Navigator.pop(context);
                        Provider.of<HistoryRepository>(context,listen: false).remove(widget.history);
                      }
                      )
                      )
                  ]
                  )
            ]),
          )
      )
    );
  }
}