
class PaginationModel<T> {
  final bool status;
  final String? message;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final List<T> data;

  PaginationModel({
    required this.status,
    this.message,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.data,
  });

  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final dataJson = json['data'] ?? {};
    final listJson = dataJson['data'] ?? [];

    return PaginationModel<T>(
      status: json['status'] ?? false,
      message: json['message'],
      currentPage: dataJson['current_page'] ?? 1,
      lastPage: dataJson['last_page'] ?? 1,
      perPage: dataJson['per_page'] ?? 10,
      total: dataJson['total'] ?? 0,
      data: (listJson as List)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson(
    Map<String, dynamic> Function(T value) toJsonT,
  ) {
    return {
      "status": status,
      "message": message,
      "data": {
        "current_page": currentPage,
        "last_page": lastPage,
        "per_page": perPage,
        "total": total,
        "data": data.map((e) => toJsonT(e)).toList(),
      }
    };
  }

  /// Helper: true if more pages available
  bool get canLoadMore => currentPage < lastPage;
}
