class BaseState<T> {
  bool isLoading = false;
  String? errorMessage;
  T? data;

  BaseState({
    this.isLoading = false,
    this.errorMessage,
    this.data,
  });

  BaseState<T> copyWith({
    bool? isLoadingParam,
    String? errorMessageParam,
    T? dataParam,
  }) {
    return BaseState<T>(
      isLoading: isLoadingParam ?? isLoading,
      errorMessage: errorMessageParam ?? errorMessage,
      data: dataParam ?? data,
    );
  }

}
