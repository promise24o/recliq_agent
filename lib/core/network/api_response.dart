class ApiResponse<T> {
  final String? message;
  final T? data;
  final bool success;

  const ApiResponse({
    this.message,
    this.data,
    this.success = true,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJsonT,
  ) {
    return ApiResponse(
      message: json['message'] as String?,
      data: fromJsonT != null && json['data'] != null
          ? fromJsonT(json['data'] as Map<String, dynamic>)
          : null,
      success: json['success'] as bool? ?? true,
    );
  }
}
