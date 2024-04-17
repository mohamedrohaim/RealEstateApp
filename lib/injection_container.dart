import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:realestate/Features/Explore/data/data_sources/remote_data_source.dart';
import 'package:realestate/Features/Explore/data/repositories_impl/get_unit_repo.impl.dart';
import 'package:realestate/Features/Explore/domain/repositories/get_unit_repo.dart';
import 'package:realestate/Features/Explore/domain/use_cases/add_to_favoirt_usecase.dart';
import 'package:realestate/Features/Explore/domain/use_cases/get_unit_by_id_usecase.dart';
import 'package:realestate/Features/Explore/domain/use_cases/get_unit_usecase.dart';
import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
import 'package:realestate/Features/Favorites/data/data_sources/get_favoirt_remote_data.dart';
import 'package:realestate/Features/Favorites/data/repositories_impl/get_favoirt_rep_impl.dart';
import 'package:realestate/Features/Favorites/domain/repositories/get_favoirt_repo.dart';
import 'package:realestate/Features/Favorites/domain/use_cases/get_favorit_list_usecase.dart';
import 'package:realestate/Features/Favorites/domain/use_cases/remove_from_favorit_usecas.dart';
import 'package:realestate/Features/Favorites/presentation/cubit/get_favorits_cubit.dart';
import 'package:realestate/core/network/api_helper.dart';
import 'package:realestate/core/network/dio_helper.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //!Explore
  //cubit
  sl.registerFactory<GetUnitCubit>(() => GetUnitCubit(
      getUnitUseCase: sl(),
      getUnitByIdUseCase: sl(),
      addToFavoritUsecase: sl()));
  //usecase
  sl.registerLazySingleton<GetUnitUseCase>(
      () => GetUnitUseCase(getUnitRepo: sl()));
  sl.registerLazySingleton<GetUnitByIdUseCase>(
      () => GetUnitByIdUseCase(getUnitRepo: sl()));
  sl.registerLazySingleton(() => AddToFavoritUsecase(getUnitRepo: sl()));
  //repository
  sl.registerLazySingleton<GetUnitRepo>(
      () => GetUnitRepoImpl(remoteDataSource: sl()));
//data Source
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(apiHelper: sl()));
  //!Favoirt
  //cubit
  sl.registerFactory<GetFavoritsCubit>(() => GetFavoritsCubit(
      getFavoritUsecse: sl(), removeFromFavoritListUsecase: sl()));
  //usecase
  sl.registerLazySingleton<GetFavoritUsecse>(
      () => GetFavoritUsecse(getFavoirtRepo: sl()));
  sl.registerLazySingleton<RemoveFromFavoritListUsecase>(
      () => RemoveFromFavoritListUsecase(getFavoirtRepo: sl()));
  //repo
  sl.registerLazySingleton<GetFavoirtRepo>(
      () => GetFavoirtsImpl(remoteData: sl()));
  //remote data
  sl.registerLazySingleton<GetFavoritRemoteData>(
      () => GetFavoritRemoteDataimpl(apiHelper: sl()));
  //core
  sl.registerLazySingleton(() => APIHelper());
  sl.registerLazySingleton(() => DioHelper());
  sl.registerLazySingleton(() => Dio());
}
