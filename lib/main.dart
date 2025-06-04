// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/add_jadwal/add_jadwal_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/add_paket/add_paket_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/add_user/add_user_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/all_jadwal/all_jadwal_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/all_paket/all_paket_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/all_pesanan/all_pesanan_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/all_user/all_user_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/deleted_paket/deleted_paket_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/deleted_user/deleted_user_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/local_user/local_user_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/logout/logout_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/order_product/order_product_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/order_data/order_data_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/paket_detail/paket_detail_dart_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/pesanan_detail/pesanan_detail_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/product/product_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/register/register_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/update_pesanan_status/update_pesanan_status_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/update_status_instruktur/update_status_instruktut_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/upload_image/upload_image_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/user_status/user_status_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/remote/auth/auth_remote.dart';
import 'package:kursus_mengemudi_nasional/models/remote/instruktur/instruktur_remote.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_jadwal_remote.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_paket_remote.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_pesanan_remote.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_users_remote.dart';
import 'package:kursus_mengemudi_nasional/models/remote/siswa/order_product_remote.dart';
import 'package:kursus_mengemudi_nasional/models/remote/siswa/product_remote.dart';
import 'package:kursus_mengemudi_nasional/models/response/login_response.dart';
import 'package:kursus_mengemudi_nasional/screens/instruktur/instruktur.dart';
import 'package:kursus_mengemudi_nasional/screens/kasir/dashboard_kasir.dart';
import 'package:kursus_mengemudi_nasional/screens/siswa/main_nav.dart';
import 'package:kursus_mengemudi_nasional/screens/siswa/login_page.dart';

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
        BlocProvider(
          create: (context) => AddJadwalBloc(
            orderProductRemoteDatasource: OrderProductRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => UserStatusBloc(
            remoteDatasource: InstrukturRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateStatusInstruktutBloc(
            instrukturRemote: InstrukturRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => AllPesananBloc(
            remoteAllproduct: AllPesananRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => AllJadwalBloc(
            remoteAllproduct: AllJadwalRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => PesananDetailBloc(
            allPesananRemote: AllPesananRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => UpdatePesananStatusBloc(
            allPesananRemote: AllPesananRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => AllPaketBloc(
            remoteDatasource: AllPaketRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => PaketDetailDartBloc(
            remoteDatasource: AllPaketRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => DeletedPaketBloc(
            allPaketRemoteDatasource: AllPaketRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => AddPaketBloc(
            paketRemoteDatasource: AllPaketRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => AllUserBloc(
            allUsersRemoteDatasource: AllUsersRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => DeletedUserBloc(
            allUsersRemoteDatasource: AllUsersRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => AddUserBloc(
            allUsersRemoteDatasource: AllUsersRemoteDatasource(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'NASIONAL Kursus Mengemudi',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: FutureBuilder<LoginResponseModel>(
          future: AuthlocalDatasource().getLoginData(),
          builder: (context, loginSnapshot) {
            if (loginSnapshot.connectionState == ConnectionState.done) {
              if (loginSnapshot.hasData) {
                final user = loginSnapshot.data!.user;
                final role = user.role;
                if (role == 'Siswa' || role == 'siswa') {
                  return const MainNavigation();
                } else if (role == 'Instruktur' || role == 'instruktur') {
                  return const JadwalPage();
                } else if (role == 'Kasir' || role == 'kasir') {
                  return const DashboardKasir();
                } else {
                  return const LoginPage();
                }
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
