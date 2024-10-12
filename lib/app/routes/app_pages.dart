
import 'package:catering_mobile/app/pages/modules/alamat/views/alamat_pengiriman.dart';
import 'package:catering_mobile/app/pages/modules/cart/view/cart.dart';
import 'package:catering_mobile/app/pages/modules/chat/views/chat.dart';
import 'package:catering_mobile/app/pages/modules/home_admin/views/home_admin.dart';
import 'package:catering_mobile/app/pages/modules/home_kurir/views/home_kurir.dart';
import 'package:catering_mobile/app/pages/modules/menu_makanan/menu_makanan.dart';
import 'package:catering_mobile/app/pages/modules/paket_makanan/paket_makanan.dart';
import 'package:catering_mobile/app/pages/modules/search/views/search.dart';
import 'package:catering_mobile/app/pages/modules/status/views/status_pesanan.dart';
import 'package:catering_mobile/app/pages/modules/user_menu/alamat/form_alamat.dart';
import 'package:catering_mobile/app/pages/modules/user_menu/alamat/manage_alamat.dart';
import 'package:catering_mobile/app/pages/modules/user_profile/views/user_profile.dart';

import '../pages/modules/admin_menu/views/menu/form_menu.dart';
import '../pages/modules/admin_menu/views/menu/manage_menu.dart';
import '../pages/modules/admin_menu/views/paket/form_paket.dart';
import '../pages/modules/admin_menu/views/paket/manage_paket.dart';
import '../pages/modules/admin_menu/views/riwayat/riwayat_admin.dart';
import '../pages/modules/admin_menu/views/user/form_user.dart';
import '../pages/modules/admin_menu/views/user/manage_user.dart';
import '../pages/modules/admin_menu/views/voucher/form_voucher.dart';
import '../pages/modules/admin_menu/views/voucher/manage_voucher.dart';
import '../pages/modules/favorit/views/favorite.dart';
import '../pages/modules/kurir_menu/views/pesanan/konfirmasi_pengiriman.dart';
import '../pages/modules/kurir_menu/views/pesanan/status_pengiriman.dart';
import '../pages/modules/kurir_menu/views/riwayat/riwayat_kurir.dart';
import '../pages/modules/login/views/kurir_login.dart';
import '../pages/modules/login/views/main_login.dart';
import 'package:get/get.dart';

import '../pages/modules/home/bindings/home_binding.dart';
import '../pages/modules/home/views/home_view.dart';
import '../pages/modules/payment/views/pembayaran.dart';
import '../pages/modules/register/views/register.dart';
import '../pages/modules/tracking/views/lacak_pesanan.dart';
import '../pages/modules/user_menu/keluhan/keluhan.dart';
import '../pages/modules/user_menu/lapor_bug/lapor_bug.dart';
import '../pages/modules/user_menu/metode_pembayaran/metode_pembayaran.dart';
import '../pages/modules/user_menu/password/update_password.dart';
import '../pages/modules/user_menu/riwayat/riwayat_transaksi.dart';
import '../pages/modules/voucher/views/voucher.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAINLOGIN;

  static final routes = [
    GetPage(
      name: _Paths.REGISTER,
      page: () => Register(),
    ),
    GetPage(
        name: _Paths.MAINLOGIN,
        page: () => MainLogin()
    ),
    GetPage(
        name: _Paths.KURIRLOGIN,
        page: () => KurirLogin()
    ),
    GetPage(
      name: _Paths.HOMEADMIN,
      page: () => HomeAdmin(),
    ),
    GetPage(
      name: _Paths.HOMEKURIR,
      page: () => HomeKurir(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => UserProfile(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => MenuMakanan(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchViews(),
    ),
    GetPage(
      name: _Paths.PAKET,
      page: () => PaketMakanan(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => Favorite(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
    ),
    GetPage(
      name: _Paths.VOUCHER,
      page: () => Voucher(),
    ),
    GetPage(
      name: _Paths.MANAGEUSER,
      page: () => ManageUser(),
    ),
    GetPage(
      name: _Paths.FORMUSER,
      page: () => FormUser(),
    ),
    GetPage(
      name: _Paths.MANAGEMENU,
      page: () => ManageMenu(),
    ),
    GetPage(
      name: _Paths.FORMMENU,
      page: () => FormMenu(),
    ),
    GetPage(
      name: _Paths.MANAGEPAKET,
      page: () => ManagePaket(),
    ),
    GetPage(
      name: _Paths.FORMPAKET,
      page: () => FormPaket(),
    ),
    GetPage(
      name: _Paths.MANAGEVOUCHER,
      page: () => ManageVoucher(),
    ),
    GetPage(
      name: _Paths.FORMVOUCHER,
      page: () => FormVoucher(),
    ),
    GetPage(
      name: _Paths.RIWAYATADMIN,
      page: () => RiwayatAdmin(),
    ),
    GetPage(
      name: _Paths.RIWAYATKURIR,
      page: () => RiwayatKurir(),
    ),
    GetPage(
      name: _Paths.STATUSPENGIRIMAN,
      page: () => StatusPengiriman(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatScreen(),
    ),
    GetPage(
      name: _Paths.UPDATEPASSWORD,
      page: () => UpdatePassword(),
    ),
    GetPage(
      name: _Paths.RIWAYATUSER,
      page: () => RiwayatUser(),
    ),
    GetPage(
      name: _Paths.METODEPEMBAYARAN,
      page: () => MetodePembayaran(),
    ),
    GetPage(
      name: _Paths.MANAGEALAMAT,
      page: () => ManageAlamat(),
    ),
    GetPage(
      name: _Paths.KELUHAN,
      page: () => Keluhan(),
    ),
    GetPage(
      name: _Paths.LAPORBUG,
      page: () => LaporBug(),
    ),
    GetPage(
      name: _Paths.PEMBAYARAN,
      page: () => Pembayaran(),
    ),
    GetPage(
      name: _Paths.LACAKPESANAN,
      page: () => LacakPesanan(),
    ),
    GetPage(
      name: _Paths.STATUSPESANAN,
      page: () => StatusPesanan(),
    ),
    GetPage(
      name: _Paths.ALAMATPENGIRIMAN,
      page: () => AlamatPengiriman(),
    ),
    GetPage(
      name: _Paths.FORMALAMAT,
      page: () => FormAlamat(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
