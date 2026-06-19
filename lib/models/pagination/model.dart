class PaginationModel {
  final int limit;
  int page = 1;
  bool isEndOfPage = false;

  PaginationModel({required this.limit});

  void refresh() {
    page = 1;
    isEndOfPage = false;
  }

  void checkLoadMore(int lenght) {
    if (lenght < limit) {
      isEndOfPage = true;
    } else {
      page++;
    }
  }
}
