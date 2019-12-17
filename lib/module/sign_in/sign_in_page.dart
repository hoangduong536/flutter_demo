
import 'package:flutter/material.dart';
import 'package:flutter_app/base/base_event.dart';
import 'package:flutter_app/base/base_widget.dart';
import 'package:flutter_app/data/remote/user_service.dart';
import 'package:flutter_app/data/repo/user_repo.dart';
import 'package:flutter_app/event/sign_in/sign_in_event.dart';
import 'package:flutter_app/event/sign_in/sign_in_fail_event.dart';
import 'package:flutter_app/event/sign_in/sign_in_sucess_event.dart';
import 'package:flutter_app/module/sign_in/sign_in_bloc.dart';
import 'package:flutter_app/shared/app_color.dart';
import 'package:flutter_app/shared/widget/bloc_listener.dart';
import 'package:flutter_app/shared/widget/loading_task.dart';
import 'package:flutter_app/shared/widget/normal_button.dart';
import 'package:provider/provider.dart';


class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Sign In',
      di: [
        Provider.value(value: UserService()),
        ProxyProvider<UserService,UserRepo>(
          builder: (context,userService,previous)=> UserRepo(userService: userService),
        ),
        ProxyProvider<UserService,UserRepo>(
          builder: (context,userService,previous)=> UserRepo(userService: userService),
        ),
      ],

      child: _SignInFormWidget(),
    );
  }
}

class _SignInFormWidget extends StatefulWidget {

  @override
  __SignInFormWidgetState createState() {
    return __SignInFormWidgetState();
  }
}

class __SignInFormWidgetState extends State<_SignInFormWidget> {

  final TextEditingController _txtEmailController = TextEditingController();
  final TextEditingController _txtPassController = TextEditingController();


  SnackBar _snackBar(String msg,Color color){
    return SnackBar(
      content: Text(msg),
      backgroundColor: color,
    );
  }


  handleEvent(BaseEvent event)
  {
    if (event is SignInSuccessEvent) {
      print("SignInPage - handleEvent - SignUpSuccessEvent ================");
      var msg = "Bạn đã đăng nhập thành công:\n" + event.userData.email + " == " + event.userData.displayName;
      final snackBar = _snackBar(msg, Colors.green);
      Scaffold.of(context).showSnackBar(snackBar);
      return;
    }

    if (event is SignInFailEvent) {
      print("SignInPage - handleEvent - SignUpFailEvent ================");
      final snackBar = _snackBar(event.errMessage, Colors.red);
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Provider<SignInBloc>.value(
      value: SignInBloc(userRepo: Provider.of(context)),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, child) {
          return BlocListener<SignInBloc>(
            listener: handleEvent,
            child: LoadingTask(
              bloc: bloc,
              child: Container(
                padding: EdgeInsets.all(25),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildEmailField(bloc),
                        _buildPassField(bloc),
                        _buildSignInButton(bloc),

                      ],
                    ),
                  ),
                ),
              ),
            ),//end LoadingTask

          );
        },
      ),
    );
  }


  Widget _buildEmailField(SignInBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.emailStream,
      child: Consumer<String>(
        builder: (context,msg,child) =>
        Container(

          margin: EdgeInsets.only(bottom: 15),
          child: TextField(
            controller: _txtEmailController,
            onChanged: (text){
              print("_buildEmailField: " + text + " ====================") ;
              bloc.emailSink.add(text);

            } ,
            cursorColor: Colors.black,

            decoration: InputDecoration(
              icon: Icon(
                Icons.email,
                color: AppColor.blue,
              ),
              hintText: 'demo@gmail.com',
              errorText: msg,
              labelText: 'Email',
              labelStyle: TextStyle(color: AppColor.blue),
            ),
          ),

        ),
      ),
    );
  }

  Widget _buildPassField(SignInBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.passStream,
      child: Consumer<String>(
        builder: (context,msg,child) =>
        Container(

          margin: EdgeInsets.only(bottom: 25),
          child: TextField(
            controller: _txtPassController,
            onChanged: (text){
              print("_buildPassField: " + text + " ====================" + msg.toString()) ;
              bloc.passSink.add(text);
            },
            cursorColor: Colors.black,

            decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: AppColor.blue,
              ),
              hintText: 'Password',
              errorText: msg,
              labelText: 'Password',
              labelStyle: TextStyle(color: AppColor.blue),
            ),
          ),

        ),
      ),
    );
  }

  Widget _buildSignInButton(SignInBloc bloc) {
    return StreamProvider<bool>.value(
      initialData: false,
      value: bloc.btnStream,
      child: Consumer<bool>(
        builder: (context,enable,child)=>
         Container(
          child: NormalButton(
            title: "Sign In",
            onPressed: enable ? () {
              print("_buildSignInButton onPressed: ==============="  );
              bloc.event.add( SignInEvent(email: _txtEmailController.text,pass: _txtPassController.text));

            }
            : null,
          ),

        ),
      ),
    );
  }


}

