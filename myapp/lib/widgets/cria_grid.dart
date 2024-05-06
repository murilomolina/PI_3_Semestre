import 'package:flutter/material.dart';
import 'package:pathfinding/core/grid.dart';
import 'package:pathfinding/finders/astar.dart';
import 'package:myapp/widgets/path_processor.dart';
import 'package:myapp/pages/pagina_inicial.dart';
import 'package:myapp/widgets/pinta_borda.dart';

class CriaGrid extends StatefulWidget {
  const CriaGrid({super.key});

  @override
  State<CriaGrid> createState() => _CriaGridState();
}

class _CriaGridState extends State<CriaGrid> {
  // Grid com informações para o pacote de pathfinding saber o que é andavel ou não
  // 0 é andavel e 1 não é
  final List<List<int>> gridData = [
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 1, 1, 0, 0, 1, 1, 0, 1],
    [1, 0, 1, 1, 0, 0, 1, 1, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 1, 1, 0, 0, 1, 1, 0, 1],
    [1, 0, 1, 1, 0, 0, 1, 1, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
  ];
  @override
  Widget build(BuildContext context) {
    var pintor = PintaBorda();
    var grid = Grid(10, 10, gridData);
    // Cria um pathfinder usando o algoritimo A*
    var pathFinder = AStarFinder();
    // Cria um pathProcessor pra tratar os dados das coordenadas encontradas pelo pathfinder
    var pathProcessor = PathProcessor();
    // Lista do tipo usado pelo pathFinder
    List<List<dynamic>> path;
    // Marcador da posição atual das listas de cols e rows
    int pos = 0;
    try {
      if (coordenadas.isNotEmpty) {
        // Acha um caminho originando das coordenadas 1,1 indo até 9,9
        path = pathFinder.findPath(
            1, 1, coordenadas[0], coordenadas[1], grid.clone());
        // Chama o nosso metodo para filtrar o path
        pathProcessor.processPath(path);
        // Coloca os valores filtrados em novas variaveis
        var rows = pathProcessor.rows;
        var cols = pathProcessor.cols;
        // Reseta a pos para novas coordenadas enviadas pelo usuario
        pos = 0;

        return GridView.builder(
          // Limita o maximo de containers para 100
          itemCount: 100,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            // Limita o maximo de colunas em 10
            crossAxisCount: 10,
          ),
          itemBuilder: (context, index) {
            // Descobre a posição da coluna e fileira da iteração atual
            int row = index ~/ gridData[0].length;
            int col = index % gridData[0].length;
            Color? color;
            bool isTopo = (row == 0 && col > 0 && col < 9);
            bool isBase = (row == 9 && col > 0 && col < 9);
            bool isEsquerda = (col == 0 && row > 0 && row < 9);
            bool isDireita = (col == 9 && row > 0 && row < 9);
            // Colore os tiles que são andaveis ou não e deixa as bordas brancas
            if (gridData[row][col] == 1 &&
                (row > 0 && row < 9 && col > 0 && col < 9)) {
              color = Colors.grey;
            } else {
              color = Colors.white;
            }
            // Colore o tile do grid caso a row e col estejam na mesma posição que as coordenas de cols e rows na pos atual
            if ((cols.isNotEmpty && rows.isNotEmpty) && (cols[pos] == col && rows[pos] == row)) {
              // Se for a última posição (destino final), define uma cor diferente
              if (cols[pos] == col && rows[pos] == row && pos == cols.length - 1) {
                color = Colors.indigo[600]; // Cor para o destino final
              } else {
                color = Colors.blue[600]; // Cor para o caminho percorrido
              }
              // Passa a pos pro proximo index de cols e rows
              if (pos < cols.length - 1) {
                pos++;
              }
            }

            // Verificar se o quadrado atual é um obstáculo (valor 1) ou não
            bool isObstacle = gridData[row][col] == 1 &&
                col > 0 &&
                col < 9 &&
                row > 0 &&
                row < 9;

            // Devolve o container que vai ser a grid da coordenada da atual iteração
            return Container(
              decoration: BoxDecoration(
                color: color,
                border: pintor.pintaBorda(
                    isObstacle, isTopo, isBase, isEsquerda, isDireita),
              ),
            );
          },
        );
      }
    } catch (e) {
      // previne erros no display caso uma coordenada inalcancavel seja inserida, passar a mensagem na tela para o usuario no futuro
      print("Escolha uma coordenada que pode ser alcancada");
    }
    // Monta o grid sem pathfinding
    return GridView.builder(
      // Limita o maximo de containers para 100
      itemCount: 100,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // Limita o maximo de colunas em 10
        crossAxisCount: 10,
      ),
      itemBuilder: (context, index) {
        // Descobre a posição da coluna e fileira da iteração atual
        int row = index ~/ gridData.length;
        int col = index % gridData.length;
        Color color;
        bool isTopo = (row == 0 && col > 0 && col < 9);
        bool isBase = (row == 9 && col > 0 && col < 9);
        bool isEsquerda = (col == 0 && row > 0 && row < 9);
        bool isDireita = (col == 9 && row > 0 && row < 9);

        // Colore os tiles que são andaveis ou não e deixa as bordas brancas
        if (gridData[row][col] == 1 &&
            (row > 0 && row < 9 && col > 0 && col < 9)) {
          color = Colors.grey;
        } else {
          color = Colors.white;
        }

        // Verificar se o quadrado atual é um obstáculo (valor 1) ou não
        bool isObstacle =
            gridData[row][col] == 1 && col > 0 && col < 9 && row > 0 && row < 9;

        // Devolve o container que vai ser a grid da coordenada da atual iteração
        return Container(
          decoration: BoxDecoration(
            color: color,
            border: pintor.pintaBorda(
                isObstacle, isTopo, isBase, isEsquerda, isDireita),
          ),
        );
      },
    );
  }
}
