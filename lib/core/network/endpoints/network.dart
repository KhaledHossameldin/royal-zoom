import '../../../data/enums/user_type.dart';

class Network {
  Network._();
  // receiveTimeout in seconds
  static const int receiveTimeout = 30;

  // connectTimeout in seconds
  static const int connectionTimeout = 30;

  static const _apiPath = 'api';
  static const domain = 'api.royake.wide-techno.com';
  static const login = '$_apiPath/login';
  static const logout = '$_apiPath/logout';
  static const forget = '$_apiPath/forget';
  static const checkOTP = '$_apiPath/check-reset-code';
  static const reset = '$_apiPath/reset';
  static const resend = '$_apiPath/resend';
  static const register = '$_apiPath/register';
  static const activate = '$_apiPath/activate';
  static const consultants = '$_apiPath/consultants';
  static const majors = '$_apiPath/majors';
  static const countries = '$_apiPath/countries';
  static const cities = '$_apiPath/cities';
  static const invoices = '$_apiPath/user/invoices';
  static const statistics = '$_apiPath/user/invoices/statistics';
  static const upload = '$_apiPath/upload';
  static const consultations = '$_apiPath/user/consultations';
  static const guestConsultations = '$_apiPath/user/consultations';
  static const homeStatistics = '$_apiPath/user/home/statistics';
  static const lastConsultations = '$_apiPath/user/home/last-consultations';
  static const chats = '$_apiPath/user/chats';
  static const chatsMessages = '$_apiPath/user/chats-messages';
  static const notifications = '$_apiPath/user/notifications';
  static const updateProfile = '$_apiPath/user/update-profile';
  static const updateSettings = '$_apiPath/user/update-settings';
  static const updateNotifications =
      '$_apiPath/user/update-notifications-settings';
  static const timezones = '$_apiPath/timezones';
  static const currencies = '$_apiPath/currencies';
  static const languages = '$_apiPath/languages';
  static const fastConsultation =
      '$_apiPath/user/consultations/fast-consultation';
  static const refundRequests = '$_apiPath/consultant/refund-requests';
  static const withdrawRequests = '$_apiPath/consultant/withdraw-requests';
  static const consultationAppointmentRequests =
      '$_apiPath/user/consultation-appointment-requests';
  static const favoriteConsultations =
      '$_apiPath/user/consultations/list-favorites';
  static const favoriteConsultants =
      '$_apiPath/user/consultants/list-favorites';
  static const favoriteCategories = '$_apiPath/user/favourite-categories';
  static const appointments =
      '$_apiPath/user/consultation-appointment-requests';
  static const rateConsultation = '$_apiPath/user/ratings';
  static const newMajorRequests = '$_apiPath/consultant/consultant-majors';
  static const showProfile = '$_apiPath/user/show-profile';
  static const showConsultantProfile = '$_apiPath/consultant/show-profile';
  static const majorVerificationRequests =
      '$_apiPath/consultant/major-verification-requests';
  static const newMajorRequestOrders =
      '$_apiPath/consultant/new-major-requests';
  static const majorVerificationRequestOrders =
      '$_apiPath/consultant/major-verification-requests';

  static const walletChargeRequest =
      '$_apiPath/user/invoices/wallet-charge-request';
  static String getConsultantimes(int id) =>
      '$_apiPath/consultants/$id/available-times';
  static String getChatMessages(int id) =>
      '$_apiPath/conslutant/chats-messages/$id/messages';
  static String favoriteConsultant(int id) =>
      '$_apiPath/user/consultants/$id/favorite';

  static String favoriteConsultation(int id) =>
      '$_apiPath/user/consultations/$id/favorite';

  static String cancelConsultation(int id) =>
      '$_apiPath/user/consultations/$id/cancel';

  static String acceptChangeTimeRequest(int id) =>
      '$_apiPath/user/consultation-appointment-requests/$id/accept';

  static String rejectChangeTimeRequest(int id) =>
      '$_apiPath/user/consultation-appointment-requests/$id/reject';

  static String consultationComments(int id) =>
      '$_apiPath/user/consultations/$id/consultation-comments';

  static String changeConsultantMajorStatus(int id) =>
      '$_apiPath/consultant/consultant-majors/$id/change-status';

  static String chatss(UserType type) {
    return (type == UserType.consultant)
        ? '$_apiPath/consultant/chats'
        : '$_apiPath/user/chats';
  }

  static String chat(UserType type, int id) {
    return (type == UserType.consultant)
        ? '$_apiPath/consultant/chats/$id'
        : '$_apiPath/user/chats/$id';
  }

  static String getMessages(UserType type, int id) {
    return (type == UserType.consultant)
        ? '$_apiPath/consultant/chats-messages/$id/messages'
        : '$_apiPath/user/chats-messages/$id/messages';
  }

  static String sendMessage(UserType type) {
    return (type == UserType.consultant)
        ? '$_apiPath/consultant/chats-messages'
        : '$_apiPath/user/chats-messages';
  }

  static String getUserInvoice(int id) => '$_apiPath/user/invoices/$id';
  static String getInvoiceStatus(int id) =>
      '$_apiPath/user/invoices/$id/check-status';
}
