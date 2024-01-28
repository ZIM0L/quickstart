import 'dart:html';
import 'dart:async';
import 'Canvas.dart';

void main() {
  var isPaused = false;
  void gameStateText() {
    querySelector('#output')?.text = isPaused ? "Game on" : "Game is Paused";
    querySelector('#output')?.style.color = isPaused ? "green" : "red";
  }

  querySelector('#startGame')?.onClick.listen((event) {
    isPaused = true;
    gameStateText();
  });
  querySelector('#endGame')?.onClick.listen((event) {
    isPaused = false;
    gameStateText();
  });
  int initRow = 20;
  int initCol = 40;
  List<List<bool>> rows = [];
  List<List<TableCellElement>> rowsText = [];

  void addTable() {
    querySelector('#gameDiv')?.innerHtml = ""; //clear prev table
    var table = TableElement();
    for (var i = 0; i < rows.length; i++) {
      var tableRow = TableRowElement();
      for (var f = 0; f < rows[i].length; f++) {
        tableRow.append(rowsText[i][f]);
      }
      table.append(tableRow);
    }
    querySelector('#gameDiv')?.append(table);
  }

  void boolToText() {
    rowsText = [];
    for (var i = 0; i < rows.length; i++) {
      List<TableCellElement> colsText = [];
      for (var f = 0; f < rows[i].length; f++) {
        var cell = rows[i][f];
        var cellTest = TableCellElement();
        cellTest.text = cell ? "■" : "□";
        cellTest.onClick.listen((event) {
          rows[i][f] = !rows[i][f];
          boolToText();
          addTable();
        });
        colsText.add(cellTest);
      }
      rowsText.addAll([colsText]);
    }
  }

  int calcLiveNeighbours(i, j) {
    // x x x x x
    // x c x x x i=1 j=1
    // x x x x x
    var maxRows = rows.length;
    var maxCols = rows[0].length;

    return [
      (i > 0 && j > 0) ? rows[i - 1][j - 1] : false,
      (i > 0) ? rows[i - 1][j] : false,
      (i > 0 && j <= maxCols - 2) ? rows[i - 1][j + 1] : false,
      (j > 0) ? rows[i][j - 1] : false, // left
      (j <= maxCols - 2) ? rows[i][j + 1] : false, // right
      (i <= maxRows - 2 && j > 0) ? rows[i + 1][j - 1] : false,
      (i <= maxRows - 2) ? rows[i + 1][j] : false,
      (i <= maxRows - 2 && j <= maxCols - 2) ? rows[i + 1][j + 1] : false
    ].where((element) => element == true).length;
  }

  void cellsLogic() {
    var gamecopy =
        List.generate(initRow, (i) => List.generate(initCol, (j) => false));

    for (var i = 0; i < initRow; i++) {
      for (var j = 0; j < initCol; j++) {
        var cell = rows[i][j];
        var liveNeighbours = calcLiveNeighbours(i, j);

        if (cell) {
          if (liveNeighbours < 2 || liveNeighbours > 3) {
            gamecopy[i][j] = false;
          } else {
            gamecopy[i][j] = true;
          }
        } else {
          if (liveNeighbours == 3) {
            gamecopy[i][j] = true;
          }
        }
      }
    }

    // Copy values back to rows
    for (var i = 0; i < initRow; i++) {
      for (var j = 0; j < initCol; j++) {
        rows[i][j] = gamecopy[i][j];
      }
    }
  }

  void setupGame(int row, int initCol) {
    for (var i = 0; i < row; i++) {
      List<bool> cellsArray = [];
      for (var f = 0; f < initCol; f++) {
        var cell = false;
        cellsArray.add(cell);
      }
      rows.add(cellsArray);
    }
  }

  void updateCellText() {
    cellsLogic();
    boolToText();
    addTable();
  }

  void resizeTable() {
    var newRow = int.tryParse(
            (querySelector('#newRow') as InputElement).value ?? '30') ??
        initRow;
    var newCol = int.tryParse(
            (querySelector('#newCol') as InputElement).value ?? '30') ??
        initCol;
    initRow = newRow;
    initCol = newCol;
    rows = [];
    rowsText = [];
    setupGame(initRow, initCol);
    updateCellText();
  }

  querySelector('#resizeBtn')?.onClick.listen((event) => resizeTable());

  void resetTable() {
    for (var i = 0; i < initRow; i++) {
      for (var j = 0; j < initCol; j++) {
        rows[i][j] = false;
      }
    }
    rowsText = [];
    updateCellText();
  }

  querySelector('#resetBtn')?.onClick.listen((event) => resetTable());

  setupGame(initRow, initCol);
  boolToText();
  addTable();

  Timer.periodic(Duration(milliseconds: 200), (timer) {
    if (isPaused) {
      updateCellText();
      // print('Wykonuję co 4 sekundy!');
    }
  });
  drawChart();
}
