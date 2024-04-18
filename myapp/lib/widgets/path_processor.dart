// Trata os dados do pathfinder para saber quais pedaços do grid foram encontrados para o caminho mais curto
class PathProcessor {
  // Cria listas para armazenar a coordenada das colunas e fileiras
  final List<int> _cols = [];
  final List<int> _rows = [];

  // Getters para _cols e _rows retornados como cols e rows para outras classes
  List<int> get cols => List<int>.from(_cols);
  List<int> get rows => List<int>.from(_rows);

  // Metodo para separar os dados do path encontrado pelo algoritimo
  void processPath(List<List<dynamic>> path) {
    for (var pair in path) {
      _cols.add(pair[0]);
      _rows.add(pair[1]);
    }
  }
}