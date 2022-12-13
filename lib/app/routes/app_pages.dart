import 'package:get/get.dart';

import 'package:seminar/app/modules/add_peserta/bindings/add_peserta_binding.dart';
import 'package:seminar/app/modules/add_peserta/views/add_peserta_view.dart';
import 'package:seminar/app/modules/add_seminar/bindings/add_seminar_binding.dart';
import 'package:seminar/app/modules/add_seminar/views/add_seminar_view.dart';
import 'package:seminar/app/modules/daftar_kehadiran/bindings/daftar_kehadiran_binding.dart';
import 'package:seminar/app/modules/daftar_kehadiran/views/daftar_kehadiran_view.dart';
import 'package:seminar/app/modules/daftar_peserta/bindings/daftar_peserta_binding.dart';
import 'package:seminar/app/modules/daftar_peserta/views/daftar_peserta_view.dart';
import 'package:seminar/app/modules/detail_seminar/bindings/detail_seminar_binding.dart';
import 'package:seminar/app/modules/detail_seminar/views/detail_seminar_view.dart';
import 'package:seminar/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:seminar/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:seminar/app/modules/home/bindings/home_binding.dart';
import 'package:seminar/app/modules/home/views/home_view.dart';
import 'package:seminar/app/modules/login/bindings/login_binding.dart';
import 'package:seminar/app/modules/login/views/login_view.dart';
import 'package:seminar/app/modules/new_password/bindings/new_password_binding.dart';
import 'package:seminar/app/modules/new_password/views/new_password_view.dart';
import 'package:seminar/app/modules/profile/bindings/profile_binding.dart';
import 'package:seminar/app/modules/profile/views/profile_view.dart';
import 'package:seminar/app/modules/seminar/bindings/seminar_binding.dart';
import 'package:seminar/app/modules/seminar/views/seminar_view.dart';
import 'package:seminar/app/modules/update_password/bindings/update_password_binding.dart';
import 'package:seminar/app/modules/update_password/views/update_password_view.dart';
import 'package:seminar/app/modules/update_profile/bindings/update_profile_binding.dart';
import 'package:seminar/app/modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADD_PESERTA,
      page: () => AddPesertaView(),
      binding: AddPesertaBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.SEMINAR,
      page: () => SeminarView(),
      binding: SeminarBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SEMINAR,
      page: () => DetailSeminarView(),
      binding: DetailSeminarBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SEMINAR,
      page: () => AddSeminarView(),
      binding: AddSeminarBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_PESERTA,
      page: () => DaftarPesertaView(),
      binding: DaftarPesertaBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_KEHADIRAN,
      page: () => DaftarKehadiranView(),
      binding: DaftarKehadiranBinding(),
    ),
  ];
}
