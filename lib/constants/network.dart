class Network {
  Network._();

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
  static const homeStatistics = '$_apiPath/user/statistics';
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
  static const consultationAppointmentRequests =
      '$_apiPath/user/consultation-appointment-requests';
  static const favoriteConsultations =
      '$_apiPath/user/consultations/list-favorites';
  static const favoriteConsultants =
      '$_apiPath/user/consultants/list-favorites';
  static const favoriteCategories = '$_apiPath/user/favourite-categories';
  static const appointments =
      '$_apiPath/user/consultation-appointment-requests';

  static String getConsultantimes(int id) =>
      '$_apiPath/consultants/$id/available-times';

  static String getChatMessages(int id) =>
      '$_apiPath/user/chats-messages/$id/messages';

  static String favoriteConsultant(int id) =>
      '$_apiPath/user/consultants/$id/favorite';

  static String favoriteConsultation(int id) =>
      '$_apiPath/user/consultations/$id/favorite';
}
