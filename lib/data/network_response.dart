class NetworkResponse {
  final int? sttusCode;
  final bool isSuccess;
  final Map<String, dynamic>? jsonResponse;
  final String? errorMessage;

  NetworkResponse(
      {this.sttusCode = -1,
        required this.isSuccess,
        this.jsonResponse,
        this.errorMessage = "something went wrong!"});
}