part of 'get_favorits_cubit.dart';

sealed class GetFavoritsState extends Equatable {
  const GetFavoritsState();

  @override
  List<Object> get props => [];
}

final class GetFavoritsInitial extends GetFavoritsState {}

class GetFavoirtIsloading extends GetFavoritsState {}

class GetFavoirtSuccess extends GetFavoritsState {
  List<UnitEntity> favorts;
  GetFavoirtSuccess({required this.favorts});
}

class GetFavoirtError extends GetFavoritsState {
  final String favorts;
  GetFavoirtError({required this.favorts});
}
class RemoveFavoritIsLoading extends GetFavoritsState{}
class RemoveFavoirtError extends GetFavoritsState {
  final String error;
  RemoveFavoirtError({required this.error});
}

class RemovefavoirtSucces extends GetFavoritsState {
  final String success;
  RemovefavoirtSucces({required this.success});
}
