class eventLog {
  final int? studentID;
  final int? guardID;
  String reason = "";
  DateTime? entryTime;
  DateTime? exitTime;

  eventLog(this.reason, this.guardID, this.studentID) {
    exitTime = DateTime.now();
  }

  eventLog.Noreason(this.guardID, this.studentID) {
    exitTime = DateTime.now();
    this.reason = "NO REASON";
  }
}
