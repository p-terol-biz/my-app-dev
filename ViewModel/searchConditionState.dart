import 'package:flutter/material.dart';

class SearchConditionWidget extends StatefulWidget {
  @override
  _SearchConditionWidgetState createState() => _SearchConditionWidgetState();
}

class _SearchConditionWidgetState extends State<SearchConditionWidget> {
  Map<String, bool> IsUsingList_CardAttribute = {};
  Map<String, bool> IsUsingList_CardType = {};
  Map<String, bool> IsUsingList_Cost = {};
  Map<String, bool> IsUsingList_SendToPower = {};
  Map<String, bool> IsUsingList_NightDayCount = {};
  Map<String, bool> IsUsingList_Rarity = {};

  List<double> NumberOfNightPower = [];
  List<double> NumberOfDayPower = [];

  void initState() {
    super.initState();
    IsUsingList_CardAttribute["Dark"] = false;
    IsUsingList_CardAttribute["Fire"] = false;
    IsUsingList_CardAttribute["Thunder"] = false;
    IsUsingList_CardAttribute["Storm"] = false;
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
    IsUsingList_SendToPower["0"] = false;
    IsUsingList_SendToPower["1"] = false;
    IsUsingList_SendToPower["2"] = false;
    IsUsingList_SendToPower["3"] = false;
    IsUsingList_SendToPower["4+"] = false;
    IsUsingList_NightDayCount["0"] = false;
    IsUsingList_NightDayCount["1"] = false;
    IsUsingList_NightDayCount["2"] = false;
    IsUsingList_NightDayCount["3"] = false;
    IsUsingList_NightDayCount["4+"] = false;
    NumberOfNightPower.add(50);
    NumberOfDayPower.add(50);
    IsUsingList_Rarity["UR"] = false;
    IsUsingList_Rarity["SR"] = false;
    IsUsingList_Rarity["R"] = false;
    IsUsingList_Rarity["N"] = false;
  }

  void _incrementCounter() {
    setState(() {});
  }

  Container CheckBoxContainer(String titleName, Map<String, bool> targetList) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: targetList.keys.map((key) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Checkbox(
                          value: targetList[key],
                          onChanged: (value) {
                            setState(() {
                              targetList[key] = value!;
                            });
                          },
                        ),
                        Text(key)
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container InkWellContainer(String titleName, Map<String, bool> targetList) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            child: Center(
              child: Row(
                children: targetList.keys.map((key) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32)),
                        onTap: () {
                          // ここに tap されたときの処理

                          setState(() {
                            if (targetList[key] == true) {
                              targetList[key] = false;
                            } else {
                              targetList[key] = true;
                            }
                          });
                          print(key);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32)),
                            border: Border.all(
                              width: 2,
                              color: Colors.pink,
                            ),
                            color: targetList[key]! ? Colors.pink : null,
                          ),
                          child: Text(
                            key,
                            style: TextStyle(
                              color:
                                  targetList[key]! ? Colors.white : Colors.pink,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ));
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container SliderContainer(String titleName, List<double> targetNumber) {
    double maxSlide = 210;
    double minSlide = 0;
    int devideSlide = ((maxSlide - minSlide) / 10).toInt();
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Center(
            child: Text(
              '${targetNumber[0].toInt()}',
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            child: Center(
              child: Slider(
                value: targetNumber[0], // 値を指定
                divisions: devideSlide,
                min: minSlide,
                max: maxSlide,
                onChanged: (value) {
                  // 変更した値を代入
                  setState(() {
                    targetNumber[0] = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CheckBoxContainer('Card Attrubute', IsUsingList_CardAttribute),
          CheckBoxContainer('Card Type', IsUsingList_CardType),
          InkWellContainer('Cost', IsUsingList_Cost),
          InkWellContainer('Send To Power', IsUsingList_SendToPower),
          InkWellContainer('NightDay Count', IsUsingList_NightDayCount),
          SliderContainer('NightPower', NumberOfNightPower),
          SliderContainer('DayPower', NumberOfDayPower),
          CheckBoxContainer('Rarity', IsUsingList_Rarity),
        ],
      ),
    );

    /*
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Attribute',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: IsUsingList_Attribute.keys.map((key) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Checkbox(
                            value: IsUsingList_Attribute[key],
                            onChanged: (value) {
                              setState(() {
                                IsUsingList_Attribute[key] = value!;
                              });
                            },
                          ),
                          Text(key)
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Card Type',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Container(
              child: Center(
                child: Row(
                  children: IsUsingList_CardType.keys.map((key) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Checkbox(
                            value: IsUsingList_CardType[key],
                            onChanged: (value) {
                              IsUsingList_Attribute[key] = value!;
                            },
                          ),
                          Text(key)
                        ],
                      ),
                    );
                  }).toList(),
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Cost',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Container(
              child: Center(
                child: Row(
                  children: IsUsingList_Cost.keys.map((key) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(32)),
                          onTap: () {
                            // ここに tap されたときの処理
                            if (IsUsingList_Cost[key] == true) {
                              IsUsingList_Cost[key] = false;
                            } else {
                              IsUsingList_Cost[key] = true;
                            }
                            print(key);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(32)),
                              border: Border.all(
                                width: 2,
                                color: Colors.pink,
                              ),
                              color:
                                  IsUsingList_Cost[key]! ? Colors.pink : null,
                            ),
                            child: Text(
                              key,
                              style: TextStyle(
                                color: IsUsingList_Cost[key]!
                                    ? Colors.white
                                    : Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ));
                  }).toList(),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Send To Power',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Center(
              child: Text("Test detail 003"),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Night Day Count',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Center(
              child: Text("Test detail 003"),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Night Power',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Center(
              child: Text("Test detail 003"),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Day Power',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Center(
              child: Text("Test detail 003"),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Rarity',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Center(
              child: Text("Test detail 003"),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Ability',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Center(
              child: Text("Test detail 003"),
            ),
          ),
        ],
      ),
    );
    */

/*
return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Attribute',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: IsUsingList_Attribute.keys.map((key) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Checkbox(
                            value: IsUsingList_Attribute[key],
                            onChanged: (value) {
                              setState(() {
                                IsUsingList_Attribute[key] = value!;
                              });
                            },
                          ),
                          Text(key)
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Card Type',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Container(
              child: Center(
                child: Row(
                  children: IsUsingList_CardType.keys.map((key) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Checkbox(
                            value: IsUsingList_CardType[key],
                            onChanged: (value) {
                              IsUsingList_Attribute[key] = value!;
                            },
                          ),
                          Text(key)
                        ],
                      ),
                    );
                  }).toList(),
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Cost',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Container(
              child: Center(
                child: Row(
                  children: IsUsingList_Cost.keys.map((key) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(32)),
                          onTap: () {
                            // ここに tap されたときの処理
                            if (IsUsingList_Cost[key] == true) {
                              IsUsingList_Cost[key] = false;
                            } else {
                              IsUsingList_Cost[key] = true;
                            }
                            print(key);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(32)),
                              border: Border.all(
                                width: 2,
                                color: Colors.pink,
                              ),
                              color:
                                  IsUsingList_Cost[key]! ? Colors.pink : null,
                            ),
                            child: Text(
                              key,
                              style: TextStyle(
                                color: IsUsingList_Cost[key]!
                                    ? Colors.white
                                    : Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ));
                  }).toList(),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Send To Power',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Center(
              child: Text("Test detail 003"),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Night Day Count',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Center(
              child: Text("Test detail 003"),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Night Power',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Center(
              child: Text("Test detail 003"),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Day Power',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Center(
              child: Text("Test detail 003"),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Rarity',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Center(
              child: Text("Test detail 003"),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Ability',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Center(
              child: Text("Test detail 003"),
            ),
          ),
        ],
      ),
    );

*/
  }
}
