import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapplication/layout/cubit/cubit.dart';
import 'package:socialapplication/layout/socialscreen.dart';
import 'package:socialapplication/modules/sociallogin/Login.dart';
import 'package:socialapplication/shared/blocobserver/bloc_observer.dart';
import 'package:socialapplication/shared/components/constants.dart';
import 'package:socialapplication/shared/network/local/cash_helper.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print (message.data.toString()) ;
  Fluttertoast.showToast(msg: 'on back ground messaging' ,backgroundColor: Colors.red) ;

}
Widget startWidget ;
void main()async {
  WidgetsFlutterBinding.ensureInitialized() ;
  await Firebase.initializeApp() ;
  var token  = await FirebaseMessaging.instance.getToken() ;
  print (token) ;

  // وانا فاتح الابليكيشن
  FirebaseMessaging.onMessage.listen((event) {
    print (event.data.toString()) ;
    Fluttertoast.showToast(msg: 'Forground message ' ,backgroundColor: Colors.red) ;
  });
  // ام اتك ع ال نوتيفيكيشن
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print (event.data.toString()) ;
    Fluttertoast.showToast(msg: 'when open message ' ,backgroundColor: Colors.red) ;
  });

  // in the back ground messaging

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);



  Bloc.observer = MyBlocObserver();
  await CachHelper.init() ;
  uId = CachHelper.getData(key: 'uId') ;
  if (uId!=null||uId!='')
    {
      startWidget = SocialLayout() ;
    }
  else
    {
      startWidget = SocialLoginScreen() ;
    }
  runApp(MyApp());
}
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLayoutCubit()..getUserData()..getPosts()..getAllUsers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:  ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                  color: Colors.black
              ),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white
              ),
              backgroundColor: Colors.white,
              elevation: 0.0 ,
              titleTextStyle: TextStyle(color: Colors.black ,
                  fontSize: 20.0 , fontWeight: FontWeight.bold)
          ),
          bottomNavigationBarTheme:BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed ,
              backgroundColor: Colors.white ,
              elevation: 20.0 ,
              unselectedItemColor: Colors.grey ,
              selectedItemColor: Colors.blue

          )
          ,textTheme: TextTheme(
            bodyText1: TextStyle(
                fontSize: 18 , fontWeight: FontWeight.bold ,
                color: Colors.black
            )
        ),),
        home: startWidget,
      ),
    );
  }
}
