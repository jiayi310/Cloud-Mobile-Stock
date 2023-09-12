class Job {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Job({
    this.id,
  });

  Job.fromJson(Map<String, dynamic> json) {}
}
