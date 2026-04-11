sealed class BaseResponse<T> {}

class SuccessResponse<T> extends BaseResponse<T> {
  T data;
  SuccessResponse({required this.data});
}

class ErrorResponse<T> extends BaseResponse<T> {
  String errorMessage;
  ErrorResponse({required this.errorMessage});
}
