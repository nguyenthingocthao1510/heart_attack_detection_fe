class Medicine {
  String? description;
  int? id;
  String? name;
  String? uses;

  Medicine({
    this.description,
    this.id,
    this.name,
    this.uses,
  });

  factory Medicine.fromMap(Map<String, dynamic> e) {
    return Medicine(
      description: e['description'],
      id: e['id'],
      name: e['name'],
      uses: e['uses'],
    );
  }
}
