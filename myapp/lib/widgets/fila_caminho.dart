class No{
  late final int _row;
  late final int _col;
  No? _proximo;
  No? _anterior;

  No(this._col, this._row);

  No? getProximo(){
    return _proximo;
  }

  No? getAnterior(){
    return _anterior;
  }

  int getRow(){
    return _row;
  }

  int getCol(){
    return _col;
  }

  void setProximo(No proximo){
    _proximo = proximo;
  }
  
  void setAnterior(No anterior){
    _anterior = anterior;
  }
}


class FilaCaminho {
  No? primeiro;
  No? ultimo;
  // ignore: prefer_final_fields
  List<List<dynamic>> _path = [];


  FilaCaminho(List<List<dynamic>> caminho) : _path = List<List<dynamic>>.from(caminho);

  void add(int col, int row) {
    No novo = No(col, row);
    if (isEmpty()) {
      primeiro = novo;
    } 
    else {
      novo.setAnterior(ultimo!);
      ultimo?.setProximo(novo);
    }
    ultimo = novo;
  }

  bool pop(int col, int row) {
    No? temp = primeiro;
    bool achou = false;
    while (temp != null) {
      if (temp.getCol() == col && temp.getRow() == row) {
        achou = true;
        break;
      }
      temp = temp.getProximo();
    }

    if (achou) {
      No? anterior = temp?.getAnterior();
      No? proximo = temp?.getProximo();
      
      if (temp == ultimo){
        proximo?.setAnterior(anterior!);
      }
      else{
        anterior?.setProximo(proximo!);
      }

      return true;
    }

    return false;
  }


  bool isEmpty(){
    if (primeiro == null) return true;
    return false;
  }

  void verFila() {
    No? temp = primeiro;

    if(isEmpty()) print("Fila vazia");
    
    else{
      while (temp != null) {
        print('Col: ${temp.getCol()}, Row: ${temp.getRow()}');
        temp = temp.getProximo();
      }
    }
  }
}