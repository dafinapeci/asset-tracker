class Asset {
  final int id;
  final String name;
  final String tagNumber;
  final String status;

  Asset({
    required this.id,
    required this.name,
    required this.tagNumber,
    required this.status,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'] ?? 'Unknown Asset',
      tagNumber: json['tagNumber'] ?? json['tag_number'] ?? 'Unknown Tag',
      status: json['status'] ?? 'Unknown Status',
    );
  }
}