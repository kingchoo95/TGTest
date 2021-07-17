class BusSchedule {
  String title;
  Map<String,  dynamic> shift;

  BusSchedule({required this.title, required this.shift});

  factory BusSchedule.fromJson(Map<String,  dynamic> data ){
    return BusSchedule(
        title: data.keys.first,
        shift: data[data.keys.first]
    );
  }
}

class ShiftInfo{
  String schedule;
  String status;
  String startTime;
  String endTime;

  ShiftInfo(this.schedule, this.status, this.startTime, this.endTime);
}