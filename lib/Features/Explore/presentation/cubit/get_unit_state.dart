part of 'get_unit_cubit.dart';

sealed class GetUnitState extends Equatable {
  const GetUnitState();

  @override
  List<Object> get props => [];
}

final class GetUnitInitial extends GetUnitState {}

class GetUnitIsloadingState extends GetUnitState {}

class GetUnitSuccessState extends GetUnitState {
  List<UnitEntity> units;
  GetUnitSuccessState({required this.units});
}

class GetUnitErrorState extends GetUnitState {
  final String error;
  GetUnitErrorState({required this.error});
}

class GetUnitByIdIsLoading extends GetUnitState {}

class GetUnitByIdSuccess extends GetUnitState {
  final UnitById unitByIDEntity;
  GetUnitByIdSuccess({required this.unitByIDEntity});
}

class GetUnitByIdErrorState extends GetUnitState {
  final String error;
  const GetUnitByIdErrorState({required this.error});
}
class AddToFavortiIsloading extends GetUnitState{}
class AddtoFavoriteSuccesState extends GetUnitState {
  final String success;
  AddtoFavoriteSuccesState({required this.success});
}

class AddtoFavoriteErrorState extends GetUnitState {
  final String error;
  AddtoFavoriteErrorState({required this.error});
}
