import 'package:dio/dio.dart';
import 'package:e_commerce_project/core/helper/db_helpers.dart';
import 'package:e_commerce_project/features/auth/provider/auth_provider.dart';
import 'package:e_commerce_project/features/category/Provider/products_provider.dart';
import 'package:e_commerce_project/features/category/data/datasources/products_remote_data_source.dart';
import 'package:e_commerce_project/features/category/data/repositories/products_repository.dart';
import 'package:e_commerce_project/features/product/data/datasource/product_detail_remote_data_source.dart';
import 'package:e_commerce_project/features/product/data/repositories/product_detail_repository.dart';
import 'package:e_commerce_project/features/product/provider/product_detail_provider.dart';
import 'package:e_commerce_project/features/relatedproducts/data/datasource/related_product_remote_data_source.dart';
import 'package:e_commerce_project/features/relatedproducts/data/repositories/related_product_repository.dart';
import 'package:e_commerce_project/features/relatedproducts/provider/related_product_provider.dart';
import 'package:e_commerce_project/features/screens/home/provider/home_provider.dart';
import 'package:e_commerce_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:e_commerce_project/features/auth/data/repositories/auth_repository.dart';
import 'package:e_commerce_project/features/screens/home/data/datasource/home_remote_data_source.dart';
import 'package:e_commerce_project/features/screens/home/data/repositories/home_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';
import '../network/app_interceptors.dart';
import '../services/app_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());

  // Services
  sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

  // Network — AppInterceptors MUST be registered BEFORE ApiClient
  // because ApiClient uses AppInterceptors inside its constructor
  sl.registerLazySingleton<AppInterceptors>(
    () => AppInterceptors(appPreferences: sl()),
  );
  sl.registerLazySingleton<ApiConsumer>(
    () => ApiClient(client: sl(), appInterceptors: sl()),
  );

  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), appPreferences: sl()),
  );
  sl.registerFactory(() => AuthProvider(authRepository: sl()));

  // Home
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => HomeProvider(homeRepository: sl()));

  // Products
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => ProductsProvider(productsRepository: sl()));

  // Product Detail
  sl.registerLazySingleton<ProductDetailRemoteDataSource>(
    () => ProductDetailRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<ProductDetailRepository>(
    () => ProductDetailRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => ProductDetailProvider(repository: sl()));

  // Related Products
  sl.registerLazySingleton<RelatedProductsRemoteDataSource>(
    () => RelatedProductsRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<RelatedProductsRepository>(
    () => RelatedProductsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => RelatedProductsProvider(repository: sl()));
  sl.registerLazySingleton(() => DbHelper());
}
