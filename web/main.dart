import 'dart:html';
import 'dart:async';

void main() {
  querySelector('#output')?.text = 'Gra w życie.';

  //function to create table
  void printGameBlueprint(row, col) {
    List<List<TableCellElement>> rows = [];

    for (var i = 0; i < row; i++) {
      List<TableCellElement> cells = [];
      for (var f = 0; f < col; f++) {
        var cell = TableCellElement()..text = '□ ';
        cells.add(cell);
      }
      rows.add(cells);
    }

    var table = TableElement();
    for (var i = 0; i < row; i++) {
      var tableRow = TableRowElement();
      for (var f = 0; f < col; f++) {
        tableRow.append(rows[i][f]);
      }
      table.append(tableRow);
    }
    querySelector('#gameDiv')?.append(table); // dodanie
  }


  Timer.periodic(Duration(seconds: 2), (timer) {
    print('Wykonuję co 2 sekundy!');
    print(timer);
  });

  printGameBlueprint(20, 60);
}
