import 'package:flutter/material.dart';

import 'cardSearchFormState.dart';

class SearchConditionWidget extends StatefulWidget {
  final SearchConditionList searchConditionList;

  SearchConditionWidget({required this.searchConditionList});
  @override
  _SearchConditionWidgetState createState() =>
      _SearchConditionWidgetState(searchConditionList: searchConditionList);
}

class _SearchConditionWidgetState extends State<SearchConditionWidget> {
  final SearchConditionList searchConditionList;

  _SearchConditionWidgetState({required this.searchConditionList});

  void initState() {
    super.initState();
    searchConditionList.IsUsingList_CardAttribute["Dark"] = false;
    searchConditionList.IsUsingList_CardAttribute["Fire"] = false;
    searchConditionList.IsUsingList_CardAttribute["Thunder"] = false;
    searchConditionList.IsUsingList_CardAttribute["Storm"] = false;
    searchConditionList.IsUsingList_CardType["Character"] = false;
    searchConditionList.IsUsingList_CardType["Enchant"] = false;
    searchConditionList.IsUsingList_CardType["Erea Enchant"] = false;
    searchConditionList.IsUsingList_Cost["0"] = false;
    searchConditionList.IsUsingList_Cost["1"] = false;
    searchConditionList.IsUsingList_Cost["2"] = false;
    searchConditionList.IsUsingList_Cost["3"] = false;
    searchConditionList.IsUsingList_Cost["4"] = false;
    searchConditionList.IsUsingList_Cost["5"] = false;
    searchConditionList.IsUsingList_Cost["6"] = false;
    searchConditionList.IsUsingList_Cost["7+"] = false;
    searchConditionList.IsUsingList_SendToPower["0"] = false;
    searchConditionList.IsUsingList_SendToPower["1"] = false;
    searchConditionList.IsUsingList_SendToPower["2"] = false;
    searchConditionList.IsUsingList_SendToPower["3"] = false;
    searchConditionList.IsUsingList_SendToPower["4+"] = false;
    searchConditionList.IsUsingList_NightDayCount["0"] = false;
    searchConditionList.IsUsingList_NightDayCount["1"] = false;
    searchConditionList.IsUsingList_NightDayCount["2"] = false;
    searchConditionList.IsUsingList_NightDayCount["3"] = false;
    searchConditionList.IsUsingList_NightDayCount["4+"] = false;
    searchConditionList.IsUsingList_NightPower.add(false);
    searchConditionList.IsUsingList_DayPower.add(false);
    searchConditionList.NumberOf_NightPower.add(50);
    searchConditionList.NumberOf_DayPower.add(50);
    searchConditionList.IsUsingList_Rarity["UR"] = false;
    searchConditionList.IsUsingList_Rarity["SR"] = false;
    searchConditionList.IsUsingList_Rarity["R"] = false;
    searchConditionList.IsUsingList_Rarity["N"] = false;
  }

  void toggleIconButton(String key) {
    setState(() {
      searchConditionList.IsUsingList_CardAttribute[key] =
          !searchConditionList.IsUsingList_CardAttribute[key]!;
    });
  }

  Container CheckIconButtonContainer(
      String titleName, Map<String, bool> targetList) {
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
                        // Checkbox(
                        //   value: targetList[key],
                        //   onChanged: (value) {
                        //     setState(() {
                        //       targetList[key] = value!;
                        //     });
                        //   },
                        // ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                toggleIconButton(key);
                              },
                              child: searchConditionList
                                      .IsUsingList_CardAttribute[key]!
                                  ? Image.asset(
                                      'assets/images/cardAttribute_' +
                                          key +
                                          '.png',
                                      fit: BoxFit.contain,
                                    )
                                  : Image.asset(
                                      'assets/images/cardAttribute_' +
                                          key +
                                          '_grayout.png',
                                      fit: BoxFit.contain,
                                      // color: Colors.grey, // グレースケールにする色
                                      // colorBlendMode: BlendMode.saturation,
                                    ),
                            ),
                            width: 50.0,
                            height: 50.0,
                          ),
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
              child: Wrap(
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

  Container SliderContainer(
      String titleName, List<bool> targetIsUsing, List<double> targetNumber) {
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
              child: Row(
                children: <Widget>[
                  Container(
                    child: Checkbox(
                      value: targetIsUsing[0],
                      onChanged: (value) {
                        setState(() {
                          targetIsUsing[0] = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: targetNumber[0], // 値を指定
                      divisions: devideSlide,
                      min: minSlide,
                      max: maxSlide,
                      onChanged: targetIsUsing[0]
                          ? (value) {
                              // 変更した値を代入
                              setState(() {
                                targetNumber[0] = value;
                              });
                            }
                          : null,
                    ),
                  ),
                ],
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
          CheckIconButtonContainer(
              'Card Attrubute', searchConditionList.IsUsingList_CardAttribute),
          CheckBoxContainer(
              'Card Type', searchConditionList.IsUsingList_CardType),
          InkWellContainer('Cost', searchConditionList.IsUsingList_Cost),
          InkWellContainer(
              'Send To Power', searchConditionList.IsUsingList_SendToPower),
          InkWellContainer(
              'NightDay Count', searchConditionList.IsUsingList_NightDayCount),
          SliderContainer(
              'NightPower',
              searchConditionList.IsUsingList_NightPower,
              searchConditionList.NumberOf_NightPower),
          SliderContainer('DayPower', searchConditionList.IsUsingList_DayPower,
              searchConditionList.NumberOf_DayPower),
          CheckBoxContainer('Rarity', searchConditionList.IsUsingList_Rarity),
        ],
      ),
    );
  }
}
