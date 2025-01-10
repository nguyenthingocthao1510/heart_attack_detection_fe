class MedicineChart {
  String? name;
  int? total_amount;

  MedicineChart({
    this.name,
    this.total_amount,
  });

  factory MedicineChart.fromMap(Map<String, dynamic> e) {
    return MedicineChart(
      name: e['name'],
      total_amount: e['total_amount'],
    );
  }
}

class AccountChart {
  String? name;
  int? total_amount;

  AccountChart({
    this.name,
    this.total_amount,
  });

  factory AccountChart.fromMap(Map<String, dynamic> e) {
    return AccountChart(
      name: e['name'],
      total_amount: e['total_amount'],
    );
  }
}

class DeviceChart {
  String? name;
  int? total_amount;

  DeviceChart({
    this.name,
    this.total_amount,
  });

  factory DeviceChart.fromMap(Map<String, dynamic> e) {
    return DeviceChart(
      name: e['name'],
      total_amount: e['total_amount'],
    );
  }
}
