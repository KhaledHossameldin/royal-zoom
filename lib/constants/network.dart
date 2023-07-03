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
  static const fastConsultation =
      '$_apiPath/user/consultations/fast-consultation';
  static const upload = '$_apiPath/upload';
}
