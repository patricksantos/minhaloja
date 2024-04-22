import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int limit;

  final int offset;

  final bool canLoadMore;

  const Pagination({
    this.limit = 50,
    this.offset = 1,
    this.canLoadMore = false,
  });

  Pagination copyWith({
    int? limit,
    int? offset,
    bool? canLoadMore,
  }) =>
      Pagination(
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        canLoadMore: canLoadMore ?? this.canLoadMore,
      );

  Pagination paginate({
    required bool loadMore,
  }) =>
      copyWith(
        offset: loadMore ? offset + 1 : 1,
      );

  Pagination refreshCanLoadMore({
    required int loadedCount,
  }) =>
      copyWith(
        canLoadMore: loadedCount >= limit,
      );

  bool get firstPage => offset == 1;

  @override
  List<Object?> get props => [
        limit,
        offset,
        canLoadMore,
      ];
}
