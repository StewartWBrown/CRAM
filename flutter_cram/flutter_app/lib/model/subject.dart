class Subject{
  final int id;
  final String name;
  final int workloads;
  final String startDate;
  final String endDate;
  final String examDate;

  const Subject({this.id, this.name, this.workloads, this.startDate, this.endDate, this.examDate});
}

List<Subject> subjects = [
  const Subject(
    id: 1,
    name: "Algorthms",
    workloads: 10,
    startDate: "10/02/20",
    endDate: "06/03/20",
    examDate: "08/03/20",
),

  const Subject(
    id: 2,
    name: "OOSE",
    workloads: 12,
    startDate: "14/02/20",
    endDate: "20/03/20",
    examDate: "21/03/20",
  ),

    const Subject(
      id: 3,
      name: "Networks",
      workloads: 8,
      startDate: "10/02/20",
      endDate: "01/03/20",
      examDate: "05/03/20",
),

    const Subject(
      id: 4,
      name: "Mobile HCI",
      workloads: 15,
      startDate: "10/02/20",
      endDate: "23/02/20",
      examDate: "28/03/20",
    ),

    const Subject(
      id: 5,
        name: "Data Fundamentals",
      workloads: 10,
      startDate: "10/02/20",
      endDate: "13/03/20",
      examDate: "14/03/20",
    ),
];





