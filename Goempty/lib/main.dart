
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp2/screens/Home/home.dart';
import 'package:flutterapp2/screens/Login/login_page.dart';
import 'package:flutterapp2/storage/simple_bloc_observer.dart';

import 'bloc/auth_bloc.dart';
import 'repository/user_repository.dart';
import 'screens/SplashScreen/splash_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  final userRepository = UserRepository();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white.withOpacity(0),
  ));

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(
        userRepository: userRepository,
      )..add(AppStarted());
    },
    child: App(userRepository: userRepository),
  ));

}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor:Color.fromRGBO(17, 177, 85,1),
          brightness: Brightness.light,
          fontFamily: 'DRONE'),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return HomeLayout(user:state.user);
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }
          return SplashPage();
        },
      ),
    );
  }
}
