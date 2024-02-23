import 'package:flutter/material.dart';

class SearchConditionStatefulWidget extends StatefulWidget {
  @override
  _SearchConditionStatefulWidget createState() =>
      _SearchConditionStatefulWidget();
}

class _SearchConditionStatefulWidget
    extends State<SearchConditionStatefulWidget> {
  Map<String, bool> IsUsingList_Attribute = {};
  Map<String, bool> IsUsingList_CardType = {};
  Map<String, bool> IsUsingList_Cost = {};

  CustomSearchDelegate() {
    // ここに初期化処理を書く
    IsUsingList_Attribute["Dark"] = false;
    IsUsingList_Attribute["Fire"] = false;
    IsUsingList_Attribute["Thunder"] = false;
    IsUsingList_Attribute["Storm"] = false;
    IsUsingList_CardType["Character"] = false;
    IsUsingList_CardType["Enchant"] = false;
    IsUsingList_CardType["Erea Enchant"] = false;
    IsUsingList_Cost["0"] = false;
    IsUsingList_Cost["1"] = false;
    IsUsingList_Cost["2"] = false;
    IsUsingList_Cost["3"] = false;
    IsUsingList_Cost["4"] = false;
    IsUsingList_Cost["5"] = false;
    IsUsingList_Cost["6"] = false;
    IsUsingList_Cost["7+"] = false;
  }

  void _toggleCheckbox(bool value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello, Stateful Widget!'),
      ),
    );
  }
}
