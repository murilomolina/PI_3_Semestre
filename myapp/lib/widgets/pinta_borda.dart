import 'package:flutter/material.dart';

// Utilizada para pintar as bordas do ginásio e futuramente outros limites que vão vir por padrão, como a arquibancada
class PintaBorda{
  var cor = Colors.black;
  Border pintaBorda(bool isObstacle, bool isTopo, bool isBase, bool isEsquerda, bool isDireita){
    if(isObstacle){
      return Border.all(color: Colors.black);
    }
    else if(isTopo){
      return Border(bottom: BorderSide(color: cor, width: 2));
    }
    else if(isBase){
      return Border(top: BorderSide(color: cor, width: 2));
    }
    else if(isEsquerda){
      return Border(right: BorderSide(color: cor, width: 2));
    }
    else if(isDireita){
      return Border(left: BorderSide(color: cor, width: 2));
    }
    return Border.all(color: Colors.transparent);
  }
}