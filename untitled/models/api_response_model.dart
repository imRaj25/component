class ApiResponseModel {
  final int statusCode;
  final String message;
  final dynamic response;

  ApiResponseModel(
      {required this.statusCode, required this.message, this.response});
}
