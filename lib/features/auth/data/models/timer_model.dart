class TimerModel {
  final int? days, hours, minutes, seconds;

  TimerModel({this.days, this.hours, this.minutes, this.seconds});

  TimerModel copyWith(int? days, int? hours, int? minutes, int? seconds) {
    return TimerModel(
        days: days ?? this.days,
        hours: hours ?? this.hours,
        minutes: minutes ?? this.minutes,
        seconds: seconds ?? this.seconds);
  }
}
