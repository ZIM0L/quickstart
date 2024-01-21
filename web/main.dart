import 'dart:html';
import 'dart:async';

void main() {
  querySelector('#output')?.text = 'Gra w życie.';
  var isPaused = false;
  querySelector('#startGame')?.onClick.listen((event) { isPaused = !isPaused; });
  var row = 5;
  var col = 5;
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
          cell == true? cellTest.text = "■" : cellTest.text = "□";
          colsText.add(cellTest);
        }
      rowsText.addAll([colsText]);
      }

  }
  int calcLiveNeighbours(i,j){
    // x x x x x
    // x c c c x i=1 j=1
    // x x x x x
    var maxRows = rows.length;
    var maxCols = rows[0].length;

    return [
      (i > 0 && j > 0)? rows[i - 1][j - 1] : false,
      (i > 0) ? rows[i - 1][j] : false,
      (i > 0 && j <= maxCols - 2)? rows[i - 1][j + 1] : false,
      (j > 0)? rows[i][j-1] : false,
      (j <= maxCols - 2)? rows[i][j+1] : false,
      (i <= maxRows - 2 && j > 0) ? rows[i+1][j-1] : false,
      (i <= maxRows - 2)? rows[i + 1][j] : false,
      (i <= maxRows - 2 && j <= maxCols - 2)? rows[i + 1][j+1]: false
    ].where((element) => element == true).length;
  }

  void cellsLogic(){
    var gamecopy = rows;
    for (var i = 0; i < gamecopy.length; i++) {
      for (var j = 0; j < gamecopy[i].length; j++) {
        var cell = rows[i][j];
        var liveNeighbours = calcLiveNeighbours(i,j);
        print("row " +i.toString());
        print("col " +j.toString());
        print(liveNeighbours);
         if (cell) {
          if (liveNeighbours < 2) {
            cell = false;
          } else if (liveNeighbours == 2 || liveNeighbours == 3) {
            cell = true;
          } else if (liveNeighbours > 3) {
            cell = false;
          }
        } else {
          if (liveNeighbours == 3) {
            cell = true;
          }
        }
  gamecopy[i][j] = cell;
  print(cell);
      }
    }

    for (var i = 0; i < rows.length; i++) {
      for (var j = 0; j < rows[i].length; j++) {
        rows[i][j] = gamecopy[i][j];
      }
    }
  }
  void updateCellText() {
    cellsLogic();
    boolToText();
    addTable();
  }

  void setupGame(int row, int col) {
    for (var i = 0; i < row; i++) {
      List<bool> cellsArray = [];
      for (var f = 0; f < col; f++) {
        var cell = false;
        cellsArray.add(cell);
      }
      rows.add(cellsArray);
    }
    // rows[1][1] = true;
    // rows[1][2] = true;
    // rows[2][1] = true;
    // rows[2][2] = true;

    rows[2][3] = true;
    rows[2][1] = true;
    rows[2][2] = true;
  }

   setupGame(row, col);
   boolToText();
   addTable();

  if (isPaused) {
    Timer.periodic(Duration(seconds:2), (timer) {
      updateCellText();
      // print('Wykonuję co 4 sekundy!');
    });
  }
    
  }
