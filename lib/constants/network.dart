class Network {
  Network._();

  static const _apiPath = 'api';
  static const domain = 'api.royake.wide-techno.com';
  static const login = '$_apiPath/login';
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
  static const fastConsultation =
      '$_apiPath/user/consultations/fast-consultation';
  static const consultationAppointmentRequests =
      '$_apiPath/user/consultation-appointment-requests';

  static String getConsultantimes(int id) =>
      '$_apiPath/consultants/$id/available-times';
}
