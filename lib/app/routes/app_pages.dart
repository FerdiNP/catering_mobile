import 'package:catering_mobile/app/components/menu_detail.dart';
import 'package:catering_mobile/app/components/paket_detail.dart';
import 'package:catering_mobile/app/pages/modules/admin/admin_menu/views/menu/form_menu.dart';
import 'package:catering_mobile/app/pages/modules/admin/admin_menu/views/menu/manage_menu.dart';
import 'package:catering_mobile/app/pages/modules/admin/admin_menu/views/paket/form_paket.dart';
import 'package:catering_mobile/app/pages/modules/admin/admin_menu/views/paket/manage_paket.dart';
import 'package:catering_mobile/app/pages/modules/admin/admin_menu/views/riwayat/riwayat_admin.dart';
import 'package:catering_mobile/app/pages/modules/admin/admin_menu/views/user/form_user.dart';
import 'package:catering_mobile/app/pages/modules/admin/admin_menu/views/user/manage_user.dart';
import 'package:catering_mobile/app/pages/modules/admin/admin_menu/views/voucher/form_voucher.dart';
import 'package:catering_mobile/app/pages/modules/admin/admin_menu/views/voucher/manage_voucher.dart';
import 'package:catering_mobile/app/pages/modules/admin/home_admin/views/home_admin.dart';
import 'package:catering_mobile/app/pages/modules/chat/views/chat.dart';
import 'package:catering_mobile/app/pages/modules/kurir/home_kurir/views/home_kurir.dart';
import 'package:catering_mobile/app/pages/modules/kurir/kurir_menu/views/pesanan/status_pengiriman.dart';
import 'package:catering_mobile/app/pages/modules/kurir/kurir_menu/views/riwayat/riwayat_kurir.dart';
import 'package:catering_mobile/app/pages/modules/login/views/kurir_login.dart';
import 'package:catering_mobile/app/pages/modules/login/views/main_login.dart';
import 'package:catering_mobile/app/pages/modules/register/views/register.dart';
import 'package:catering_mobile/app/pages/modules/tracking/views/lacak_pesanan.dart';
import 'package:catering_mobile/app/pages/modules/user/alamat/views/alamat_pengiriman.dart';
import 'package:catering_mobile/app/pages/modules/user/cart/view/cart.dart';
import 'package:catering_mobile/app/pages/modules/user/favorit/views/favorite.dart';
import 'package:catering_mobile/app/pages/modules/user/home/bindings/home_binding.dart';
import 'package:catering_mobile/app/pages/modules/user/home/views/home_view.dart';
import 'package:catering_mobile/app/pages/modules/user/menu_makanan/bindings/menu_makanan_bindings.dart';
import 'package:catering_mobile/app/pages/modules/user/menu_makanan/views/menu_makanan.dart';
import 'package:catering_mobile/app/pages/modules/user/paket_makanan/bindings/paket_makanan_binding.dart';
import 'package:catering_mobile/app/pages/modules/user/paket_makanan/views/paket_makanan.dart';
import 'package:catering_mobile/app/pages/modules/user/payment/views/pembayaran.dart';
import 'package:catering_mobile/app/pages/modules/user/search/views/search.dart';
import 'package:catering_mobile/app/pages/modules/user/status/views/status_pesanan.dart';
import 'package:catering_mobile/app/pages/modules/user/user_menu/alamat/form_alamat.dart';
import 'package:catering_mobile/app/pages/modules/user/user_menu/alamat/manage_alamat.dart';
import 'package:catering_mobile/app/pages/modules/user/user_menu/keluhan/keluhan.dart';
import 'package:catering_mobile/app/pages/modules/user/user_menu/lapor_bug/lapor_bug.dart';
import 'package:catering_mobile/app/pages/modules/user/user_menu/metode_pembayaran/metode_pembayaran.dart';
import 'package:catering_mobile/app/pages/modules/user/user_menu/password/update_password.dart';
import 'package:catering_mobile/app/pages/modules/user/user_menu/riwayat/riwayat_transaksi.dart';
import 'package:catering_mobile/app/pages/modules/user/user_profile/views/user_profile.dart';
import 'package:catering_mobile/app/pages/modules/user/voucher/views/voucher.dart';
import 'package:get/get.dart';



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
      binding: MenuMakananBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MENU,
      page: () => DetailMenuPage(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchViews(),
    ),
    GetPage(
      name: _Paths.PAKET,
      page: () => PaketMakanan(),
      binding: PaketMakananBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_PAKET,
      page: () => DetailPaketPage(),
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
