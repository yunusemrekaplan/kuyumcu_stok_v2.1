class Log {
  late DateTime dateTime;
  late String state;
  late String errorMessage;

  Log({
    required this.dateTime,
    required this.state,
    required this.errorMessage,
  });

  Log.fromJson(Map<String, dynamic> json) {
    dateTime = DateTime.parse(json['dateTime']);
    state = json['state'];
    errorMessage = json['errorMessage'];
  }

  Map toMap() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'state': state,
      'errorMessage': errorMessage,
    };
  }
}
