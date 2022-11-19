import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/feature/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture/feature/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture/feature/posts/data/repositories/post_repository_impl.dart';
import 'package:clean_architecture/feature/posts/domain/repositories/posts_repository.dart';
import 'package:clean_architecture/feature/posts/domain/usecases/add_post.dart';
import 'package:clean_architecture/feature/posts/domain/usecases/delete_posts.dart';
import 'package:clean_architecture/feature/posts/domain/usecases/get_all_posts.dart';
import 'package:clean_architecture/feature/posts/domain/usecases/uapdate_posts.dart';
import 'package:clean_architecture/feature/posts/presentation/bloc/add_update_delete_posts/add_update_delete_posts_bloc.dart';
import 'package:clean_architecture/feature/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl=GetIt.instance;
 Future<void> init () async {
   /// Features - Posts

   // Bloc
   sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
   sl.registerFactory(() => AddUpdateDeletePostsBloc(addPost: sl(), updatePost: sl(), deletePost: sl()));

   // Usecases
   sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
   sl.registerLazySingleton(() => AddPostUseCase(sl()));
   sl.registerLazySingleton(() => DeletePostsUseCase(sl()));
   sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

   // Repositories
   sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
       remoteDataSource: sl(),
       localDataSource: sl(),
       networkInfo: sl()));

   //Datasources
   sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));
   sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(sharedPreferences: sl()));


   /// Core
   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));



   /// External
   final sharedPreferences = await SharedPreferences.getInstance();

   sl.registerLazySingleton(() => sharedPreferences);
   sl.registerLazySingleton(() => http.Client());
   sl.registerLazySingleton(() => InternetConnectionChecker());
 }