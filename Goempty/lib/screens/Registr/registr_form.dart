

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp2/repository/user_repository.dart';
import 'package:flutterapp2/widgets/information_modal.dart';

import 'bloc/registr_bloc.dart';

class RegistrForm extends StatefulWidget {
  final UserRepository _userRepository;

  RegistrForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<RegistrForm> createState() => _RegistrFormState();
}

class _RegistrFormState extends State<RegistrForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
   final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegistrBloc _registrBloc;

  bool passwordVisible = true;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _registrBloc = BlocProvider.of<RegistrBloc>(context);
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;

    return BlocListener<RegistrBloc, RegistrState>(listener: (context, state) {
      if (state is RegistrFailure) {
        showDialog(
            context: context,
            builder: (context) {
              return ModalInformation(
                  title: "Ошибка", textContent: '${state.error}');
            });
      }
      if (state is RegistrSuccess) {
        Navigator.pop(context);
      }
    }, child: BlocBuilder<RegistrBloc,RegistrState>(
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
          child: Text('Регистрация', style: TextStyle(
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
      onPressed: _onRegistrButtonPressed,
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
              child: constrText("Name", _usernameController, false)
          ),
           Padding(
              padding: EdgeInsets.only(top: 40),
              child: constrText("Password", _passwordController, true)
          ), Padding(
              padding: EdgeInsets.only(top: 40),
              child: constrText("ConPassword", _password2Controller, true)
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: buttonAV(label),

            ),
          )
        ],
      ),
    );
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  _onRegistrButtonPressed() {
    FocusScope.of(context).unfocus();
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _usernameController.text.isEmpty || _password2Controller.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return ModalInformation(title: "Ошибка", textContent: "Пустые поля");
          });
    } else { 
      if(_passwordController.text == _password2Controller.text)
      {
        _registrBloc.add(RegistrButtonPressed(
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text));
      } else{
         showDialog(
          context: context,
          builder: (context) {
            return ModalInformation(title: "Ошибка", textContent: "Пароль не совпадает");
          });
      }
    }
  }

/*  @override
  Widget _buttonAV(String text) {
    return  Center(
        child: RaisedButton(
            splashColor: Color.fromRGBO(17, 177, 85, 1),
            highlightColor: Color.fromRGBO(17, 177, 85, 1),
            onPressed: _onLoginButtonPressed(),
            child: Text('Пример кнопки', style: TextStyle(fontSize: 15))
        )

    );
  }*/
}
