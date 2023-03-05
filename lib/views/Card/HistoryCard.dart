
import 'package:bnaming_app/http/RegistroBR.dart';
import 'package:bnaming_app/model/Cor.dart';
import 'package:bnaming_app/model/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Repository/HistoryRepository.dart';
import '../../model/Historico.dart';
import '../evaluationPage/evaluation_page.dart';

//classe para o gerenciamento e exibição dos cards de historico
class HistoryCard extends StatefulWidget {
  History history;

  HistoryCard({Key? key,required this.history}) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  Alert alert = Alert();
  Cor cor = Cor();
  
  mensagem(){
    if(widget.history.register){
        return " Nome já em uso:\n ${widget.history.nomeRegistro}\n CNPJ: ${widget.history.cnpj}";
    }
    else{
    return "Nome Disponível";
    }
  }

//navega para pagina de avaliação atraves de um card de histórico
  @override
   mostrarDetalhes() async {
    Alert alert=Alert();
    if(widget.history.register){  
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
  
  //faz a construção dos cards na tela
  @override
  Widget build(BuildContext context) {
    RBR _api= RBR();
    var historico = context.watch<HistoryRepository>();
    String segment = widget.history.segment;
    Icon icon_segment = widget.history.IconSegment(segment);
    (historico.Selecionadas.contains(widget.history))?cor.opcao2():cor.opcao1();
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
         onTap:()  {
          (historico.Selecionadas.isNotEmpty)

           ?(historico.Selecionadas.contains(widget.history))
              ? historico.removeSelecionadas(widget.history)
              : historico.selecionar(widget.history)
          :null;
        },
        onLongPress: (){
          
          (historico.Selecionadas.contains(widget.history))
              ? historico.removeSelecionadas(widget.history)
              : historico.selecionar(widget.history);  
        },
        child: Center(
          child: ExpansionTile(
            
            collapsedIconColor: cor.corSecundaria,
            iconColor: cor.corSecundaria,
            title:
                Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left:5, right: 5),
              child: Row(
                children: [
                      Visibility(
                        visible: historico.Selecionadas.contains(widget.history),
                        child: Icon(Icons.check_box_outlined,
                        color: cor.corSecundaria,
                        size: 30,
                        ),
                        ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children:[
                            ListTile(
                              title:
                              Center(
                                child: Text(widget.history.name, 
                                style:  TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: cor.corSecundaria
                                  
                        
                                ),
                                  ),
                              ),
                            
                            subtitle: 
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        icon_segment,
                                        Text(" "),
                                        Text(segment,
                                          style:  TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: cor.corSecundaria,
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),     
                            )
                        ]
                        ),   
                    )
                    ),   
                ]
              )
                ),
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Text("${mensagem()}",
                                    style:  TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: cor.corSecundaria,
                                    )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.resolveWith((states) {
                          return const Size(145.0, 10);
                        }),                
                        backgroundColor: MaterialStateProperty.resolveWith<Color?>((states){
                          return cor.corSecundaria;
                        }) ,
                        shape: MaterialStateProperty.resolveWith((states) {
                          return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)  
                        );
                        },),
                        elevation: MaterialStateProperty.resolveWith((states) {
                          return 0;
                      },)

                      ),
                      onPressed: (() {
                        mostrarDetalhes();
                      }),
                       child: Padding(
                         padding: const EdgeInsets.only(left: 4),
                         child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text("Ver avaliação",
                                    style: TextStyle(
                                        color: cor.corPrimaria,
                                        letterSpacing:0,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        
                                            ),
                                        ),
                             Icon(Icons.arrow_right,color: cor.corPrimaria,)           
                           ],
                         ),
                       ),

                       ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}