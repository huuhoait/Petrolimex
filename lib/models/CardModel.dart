class The{
  String tenChuThe;
  String soThe;

  The({this.tenChuThe, this.soThe});

  Map toJson() => {
    'name': tenChuThe,
    'cardNumber': soThe,
  };
}