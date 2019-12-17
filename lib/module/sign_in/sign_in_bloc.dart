
import 'dart:async';


import 'package:flutter/widgets.dart';
import 'package:flutter_app/base/base_bloc.dart';
import 'package:flutter_app/base/base_event.dart';
import 'package:flutter_app/data/repo/user_repo.dart';
import 'package:flutter_app/event/sign_in/sign_in_event.dart';
import 'package:flutter_app/event/sign_in/sign_in_fail_event.dart';
import 'package:flutter_app/event/sign_in/sign_in_sucess_event.dart';
import 'package:flutter_app/shared/model/rest_error.dart';


import 'package:flutter_app/shared/validation.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloc extends BaseBloc {

  UserRepo _userRepo;
  final _emailSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  Stream<String> get emailStream => _emailSubject.stream.transform(emailValidation);
  Stream<String> get passStream => _passSubject.stream.transform(passValidation);
  Stream<bool> get btnStream => _btnSubject.stream;

  Sink<String> get emailSink => _emailSubject.sink;
  Sink<String> get passSink => _passSubject.sink;
  Sink<bool> get btnSink => _btnSubject.sink;

  SignInBloc({@required UserRepo userRepo}) {
    _userRepo = userRepo;
    validateForm();
  }


  var emailValidation = StreamTransformer<String,String>.fromHandlers(handleData: (email,sink){

    if(Validation.isEmailValid(email)) {

      sink.add(null);
      return;
    }

    sink.add("Email không chính xác");
  });

  var passValidation = StreamTransformer<String,String>.fromHandlers(handleData: (pass,sink){

    if(Validation.isPassValid(pass)) {
      sink.add(null);
      return;
    }
    sink.add("Mật khẩu ít nhất 6 ký tự");
  });


  validateForm() {
    Observable.combineLatest2(
      _emailSubject,
      _passSubject,
          (email, pass) {
        print("SignInBloc - validateForm: " + email + " === " + pass);
        return Validation.isEmailValid(email) && Validation.isPassValid(pass);
      },
    ).listen((enable) {
      print("SignInBloc - validateForm - listen: " + enable.toString() + " === " );
      btnSink.add(enable);
    });
  }

  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
    switch(event.runtimeType) {
      case SignInEvent:
        _handleSignIn(event);
        break;
    }
  }

  void _handleSignIn(BaseEvent event) {
    SignInEvent signInEvent = event as SignInEvent;
    print("Email: ${signInEvent.email}  ====  Pass: ${signInEvent.pass}");

    btnSink.add(false);
    loadingSink.add(true);

    Future.delayed(Duration(seconds: 3), () {
      SignInEvent e = event as SignInEvent;
      _userRepo.signIn(e.email, e.pass).then(
            (userData) {
          processEventSink.add(SignInSuccessEvent(userData));
        },
        onError: (restError) {
          var err = restError as RestError;
          print(err.message);

         processEventSink
             .add(SignInFailEvent(err.message));
        },

      );
      btnSink.add(true);
      loadingSink.add(false);
    });



  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailSubject.close();
    _passSubject.close();
    _btnSubject.close();
  }

}