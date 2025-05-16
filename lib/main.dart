import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/local_user/local_user_bloc.dart';

import 'package:kursus_mengemudi_nasional/logic/logout/logout_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/orderProduct/order_product_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/order_data/order_data_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/product/product_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/register/register_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/upload_image/upload_image_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/remote/auth/auth_remote.dart';
import 'package:kursus_mengemudi_nasional/models/remote/siswa/order_product_remote.dart';
import 'package:kursus_mengemudi_nasional/models/remote/siswa/product_remote.dart';
import 'package:kursus_mengemudi_nasional/screens/main_nav.dart';
import 'package:kursus_mengemudi_nasional/screens/login_page.dart';

import 'logic/login/login_bloc.dart';
import 'utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            loginRemoteDatasource: LoginRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(
            logoutRemoteDatasource: LoginRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(
            registerRemoteDatasource: LoginRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            remoteDatasource: ProductRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => OrderProductBloc(
            remote: OrderProductRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => LocalUserBloc(
            authlocalDatasource: AuthlocalDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => OrderDataBloc(
            remoteDatasource: OrderProductRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => UploadImageBloc(
            orderProductRemote: OrderProductRemoteDatasource(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'NASIONAL Kursus Mengemudi',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: FutureBuilder<bool>(
          future: AuthlocalDatasource().isLoginData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!) {
                return const MainNavigation();
              } else {
                return const LoginPage();
              }
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
