sealed class UiState<T> {}

class UiNoneState<T> extends UiState<T> {}

class UiLoadingState<T> extends UiState<T> {}

class UiSuccessState<T> extends UiState<T> {
  final T data;

  UiSuccessState(this.data);
}

class UiErrorState<T> extends UiState<T> {
  final String errorTitle;
  final String errorMessage;

  UiErrorState(this.errorTitle, this.errorMessage);
}

class UiEmptyState<T> extends UiState<T> {
  final String title;
  final String message;

  UiEmptyState(this.title, this.message);
}
