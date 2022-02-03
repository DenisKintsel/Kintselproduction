

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp2/repository/user_repository.dart';
import 'package:flutterapp2/screens/Registr/registr_page.dart';
import 'package:flutterapp2/widgets/information_modal.dart';

import 'bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginBloc _loginBloc;

  bool passwordVisible = true;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;

    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        showDialog(
            context: context,
            builder: (context) {
              return ModalInformation(
                  title: "Ошибка", textContent: '${state.error}');
            });
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          color: Color.fromRGBO(17, 177, 85, 1),
          height: size.height,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: <Widget>[
                  logo(),
                  textAV('Войти'),

                ],
              ),
            ),
          ),
        );
      },
    ));
  }


  Widget logo() {
    return Padding(
      padding: EdgeInsets.only(top: 200),
      child: Container(
        child: Align(
          child: Text('Авторизация', style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }

  Widget constrText(String text, TextEditingController controller, bool pass) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: controller,
        obscureText: pass,
        style: TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
          hintText: text,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54, width: 1),
          ),
          /* prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: IconTheme(
              data: IconThemeData(color: Colors.white),
              child: icon,
            ),
          )*/
        ),
      ),
    );
  }


  Widget buttonAV(String text) {
    return RaisedButton(
        splashColor: Color.fromRGBO(17, 177, 85, 1),
        highlightColor: Color.fromRGBO(17, 177, 85, 1),
        color: Colors.white,
        child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)
        ),
      onPressed: _onLoginButtonPressed,
    );
  }

  Widget textAV(String label) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: constrText("Email", _emailController, false)
          ),
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: constrText("Password", _passwordController, true)
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: buttonAV(label),

            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: _buttonReg(label),

            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _onLoginButtonPressed() {
    FocusScope.of(context).unfocus();
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return ModalInformation(title: "Ошибка", textContent: "Ошибка");
          });
    } else {
      _loginBloc.add(LoginButtonPressed(
          email: _emailController.text,
          password: _passwordController.text));
    }
  }

  @override
  Widget _buttonReg(String text) {
    return  RaisedButton(
            splashColor: Color.fromRGBO(17, 177, 85, 1),
            highlightColor: Color.fromRGBO(17, 177, 85, 1),
            onPressed: (){
              Navigator.push( context,MaterialPageRoute(builder: (context) => RegistrPage(userRepository: _userRepository)));
            },
            child: Text('Регистрация', style: TextStyle(fontSize: 20))
        );
  }
}
