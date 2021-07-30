class PhuongTien {
  String tenLaiXe;
  String bienSo;
  int maLoaiPhuongTien;
  String tenLoaiPhuongTien;

  PhuongTien(
      {this.tenLaiXe,
      this.bienSo,
      this.maLoaiPhuongTien,
      this.tenLoaiPhuongTien});

  Map toJson() => {
        'name': tenLaiXe,
        'licensePlate': bienSo,
        'vehicleTypeId': maLoaiPhuongTien,
      };
}
