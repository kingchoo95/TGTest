import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tg_answer/TimeSlot.dart';
import 'dart:async'show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  int _dropDownvalue = 0;

  Future<String> _loadTimeSlot() async {
    return await rootBundle.loadString('assets/timeshift.json');
  }

  List<DropdownMenuItem> dropdownItemList = [];
  List<ShiftInfo> shiftInfo = [];

  @override
  Widget build(BuildContext context) {
    loadTimeSlot();
    createDropDownItem();
    return dropDownButton();
  }

  Widget dropDownButton() {
    return Scaffold(
      body: Center(
        child: Container(
            height: 80.0,
            width: double.infinity,
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: DropdownButtonFormField(
                isDense: false,
                isExpanded: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              itemHeight: 200.0,
                value: _dropDownvalue,
                items: dropdownItemList,
                onChanged: (dynamic? value) {
                  setState(() {
                    _dropDownvalue = value!;
                  });
                })),
      ),
    );
  }

  dropDownWidget(int value, String startTime, String endTime, String status, String shift) {
    return DropdownMenuItem(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$startTime to $endTime"),
            Text("[$status] ($shift)"),
          ],
        ),
      ),
      value: value,
    );
  }

  Future loadTimeSlot() async {
    String jsonString = await _loadTimeSlot();
    final jsonResponse = json.decode(jsonString);
    var timeSlotMap = new BusSchedule.fromJson(jsonResponse);

    shiftInfo.clear();

    timeSlotMap.shift.forEach((key, value) {
      for(var item in value){
        shiftInfo.add(new ShiftInfo(key, item['schedule_trip'], item['start_time'], item['end_time']));
      }
    });
    sortByTime();
  }

  createDropDownItem(){
    int count = 1;
    dropdownItemList.clear();
    dropdownItemList.add(DropdownMenuItem(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Text("Pick a Schedule"),)
      ,value: 0,));
    for(var item in shiftInfo){
      dropdownItemList.add(dropDownWidget(count,item.startTime,item.endTime,item.status,item.schedule));
      count++;
    }
  }

  sortByTime(){
    List<ShiftInfo> sortAMShiftInfo = [];
    List<ShiftInfo> sortPMShiftInfo = [];
    for(var item in shiftInfo){
      if(item.startTime.contains("am")){
        sortAMShiftInfo.add(item);
      }else{
        sortPMShiftInfo.add(item);
      }
    }

    sortAMShiftInfo.sort((a, b) => a.startTime.compareTo(b.startTime));
    sortPMShiftInfo.sort((a, b) => a.startTime.compareTo(b.startTime));
    shiftInfo.clear();
    shiftInfo = sortAMShiftInfo + sortPMShiftInfo;
  }
}

