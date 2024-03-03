class Major {
  num? id;
  String? uuid;
  num? parentId;
  num? type;
  String? name;
  String? description;
  bool? isActive;
  bool? isVisible;
  DateTime? createdAt;
  String? verificationFees;
  String? image;

  Major({
    this.id,
    this.uuid,
    this.parentId,
    this.type,
    this.name,
    this.description,
    this.isActive,
    this.isVisible,
    this.createdAt,
    this.verificationFees,
    this.image,
  });

  factory Major.fromJson(Map<String, dynamic> json) => Major(
        id: num.tryParse(json['id'].toString()),
        uuid: json['uuid']?.toString(),
        parentId: num.tryParse(json['parent_id'].toString()),
        type: num.tryParse(json['type'].toString()),
        name: json['name']?.toString(),
        description: json['description']?.toString(),
        isActive: json['is_active']?.toString().contains("true"),
        isVisible: json['is_visible']?.toString().contains("true"),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at'].toString()),
        verificationFees: json['verification_fees']?.toString(),
        image: json['image']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (uuid != null) 'uuid': uuid,
        if (parentId != null) 'parent_id': parentId,
        if (type != null) 'type': type,
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (isActive != null) 'is_active': isActive,
        if (isVisible != null) 'is_visible': isVisible,
        if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
        if (verificationFees != null) 'verification_fees': verificationFees,
        if (image != null) 'image': image,
      };
}
