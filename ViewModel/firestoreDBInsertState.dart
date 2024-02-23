import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Repository/insertFirestoreCardInformation.dart';
import 'package:path_provider/path_provider.dart';

class FirestoreInsertDB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Button Screen'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // ボタンが押された時の処理をここに追加
              print('Button Pressed');
              //csv読み込み
              //csvをFirestore用に加工
              //csvをFirestoreにInsert
              // Directory appDocumentsDirectory =
              //     await getApplicationDocumentsDirectory();
              // print(appDocumentsDirectory.path);
              List<CsvData> csvList =
                  await getCsvData('assets/Firestore_InsertDBData.csv');

              InsertFirestoreCardInformation insertFirestoreCardInformation =
                  InsertFirestoreCardInformation();

              insertFirestoreCardInformation.insertCardInformation(csvList);
            },
            child: Text('Press Me'),
          ),
        ),
      ),
    );
  }
}

Future<List<CsvData>> getCsvData(String path) async {
  List<CsvData> list = [];
  String csv = await rootBundle.loadString(path);
  print("csv>>");
  print(csv);
  int i = 0;
  for (String line in csv.split('\n')) {
    if (i == 0) {
      i += 1;
      continue;
    }
    print(line);
    List rows = line.split(','); // split by comma
    List<String> CardAttributeList = [];
    List<String> MusicTitleList = [];
    List<String> CardAbilityList = [];

    CardAttributeList.add(rows[5]);
    MusicTitleList.add(rows[12]);
    CardAbilityList.add("");
    CsvData rowData = CsvData(
        int.parse(rows[0]),
        // int.parse(rows[1]),
        int.parse(rows[1]),
        rows[2],
        rows[3],
        rows[4],
        CardAttributeList,
        rows[6],
        rows[7],
        rows[8],
        rows[9],
        rows[10],
        rows[11],
        // int.parse(rows[7]),
        // int.parse(rows[8]),
        // int.parse(rows[9]),
        // int.parse(rows[10]),
        // int.parse(rows[11]),
        MusicTitleList,
        CardAbilityList,
        rows[13]);
    list.add(rowData);
  }

  return list;
}

// class CsvData {
//   final String Season;
//   final String CharacterCardNumber;
//   final String Rarity;
//   final String CardHistoryProperty;
//   final String HistoryId;
//   final String CardName;
//   final String CardAttributeList;
//   final String CardType;
//   final String CardPowerProperty;
//   final String PowerCost;
//   final String SendToPower;
//   final String NightPower;
//   final String DayPower;
//   final String NightAndDayCount;
//   final String MusicTitleList;
//   final String CardAbility;
//   final String Supplement;

//   CsvData(
//       this.Season,
//       this.CharacterCardNumber,
//       this.Rarity,
//       this.CardHistoryProperty,
//       this.HistoryId,
//       this.CardName,
//       this.CardAttributeList,
//       this.CardType,
//       this.CardPowerProperty,
//       this.PowerCost,
//       this.SendToPower,
//       this.NightPower,
//       this.DayPower,
//       this.NightAndDayCount,
//       this.MusicTitleList,
//       this.CardAbility,
//       this.Supplement);
// }

// // Import a csv flie
// Future<List<List>> csvImport() async {
//   final String importPath = 'assets/csv/Firestore_InsertDBData.csv';
//   final File importFile = File(importPath);
//   print(importFile);
//   List<List> importList = [];

//   Stream fread = importFile.openRead();

//   // Read lines one by one, and split each ','
//   await fread.transform(utf8.decoder).transform(LineSplitter()).listen(
//     (String line) {
//       importList.add(line.split(','));
//     },
//   ).asFuture();

//   return Future<List<List>>.value(importList);
// }

// void main() async {
//   final csv = await csvImport();
//   print(csv);
// }
