class Meta {
  num? currentPage;
  num? from;
  num? lastPage;

  String? path;
  num? perPage;
  num? to;
  num? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: num.tryParse(json['current_page'].toString()),
        from: num.tryParse(json['from'].toString()),
        lastPage: num.tryParse(json['last_page'].toString()),
        path: json['path']?.toString(),
        perPage: num.tryParse(json['per_page'].toString()),
        to: num.tryParse(json['to'].toString()),
        total: num.tryParse(json['total'].toString()),
      );

  Map<String, dynamic> toJson() => {
        if (currentPage != null) 'current_page': currentPage,
        if (from != null) 'from': from,
        if (lastPage != null) 'last_page': lastPage,
        if (path != null) 'path': path,
        if (perPage != null) 'per_page': perPage,
        if (to != null) 'to': to,
        if (total != null) 'total': total,
      };
}
