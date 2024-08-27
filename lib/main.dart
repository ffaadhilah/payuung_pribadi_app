import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/home_bloc/home_bloc.dart';
import 'blocs/category_bloc/category_bloc.dart';
import 'blocs/wellness_bloc/wellness_bloc.dart';
import 'blocs/profile_bloc/profile_bloc.dart';
import 'repos/product_repository.dart';
import 'repos/category_repository.dart';
import 'repos/wellness_repository.dart';
import 'repos/user_repository.dart';
import 'screens/home_page.dart';
import 'package:payuung_pribadi_app/screens/home_page.dart' as otherHome;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            productRepository: ProductRepository(),
            categoryRepository: CategoryRepository(),
            wellnessRepository: WellnessRepository(),
          )..add(LoadHomePage()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(LoadCategories()),
        ),
        BlocProvider(
          create: (context) => WellnessBloc(
            wellnessRepository: WellnessRepository(),
          )..add(LoadWellnessItems()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            userRepository: UserRepository(),
          )..add(LoadUserProfile()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Payuung Pribadi Test App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: otherHome.HomePage(),
      ),
    );
  }
}
