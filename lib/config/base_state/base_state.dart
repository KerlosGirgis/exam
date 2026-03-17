class BaseState<T> {
  bool? isLoading;
  T? data;
  String? errorMessage;
  BaseState({this.isLoading = true, this.data, this.errorMessage});

  bool get isSuccess =>
      data != null && errorMessage == null && isLoading == false;
  bool get isError => errorMessage != null && isLoading == false;
}
