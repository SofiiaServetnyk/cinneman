import 'package:cinneman/cubit/user/user_state.dart';
import 'package:cinneman/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCubit extends Cubit<UserState> {
  final AuthApiService authApi = AuthApiService();
  final UserDataStorage userDataStorage = UserDataStorage();

  UserCubit() : super(Unauthorized());

  loginAsGuest() async {
    final accessToken = await authApi.getGuestAccessToken();

    if (accessToken != null) {
      await userDataStorage.saveUserData(
          isAnonymous: true, accessToken: accessToken);
      final tickets = await authApi.getTickets(accessToken);
      emit(Guest(accessToken: accessToken, tickets: tickets));
    } else {
      emit(Unauthorized());
    }
  }

  enterPhoneNumber(String phoneNumber) async {
    final success = await authApi.sendOtpRequest(phoneNumber);
    if (success) {
      emit(Unauthorized(phoneNumber: phoneNumber));
    } else {
      emit(Unauthorized());
    }
  }

  validateOtp(String otp) async {
    final accessToken =
        await authApi.getAuthorizedAccessToken(state.phoneNumber!, otp);
    if (accessToken != null) {
      await userDataStorage.saveUserData(
          isAnonymous: false, accessToken: accessToken);
      final tickets = await authApi.getTickets(accessToken);
      emit(Authenticated(
          accessToken: accessToken,
          phoneNumber: state.phoneNumber!,
          tickets: tickets));
    } else {
      emit(Unauthorized(phoneNumber: state.phoneNumber));
    }
  }

  logoutUser() async {
    await userDataStorage.clearUserData();
    emit(Unauthorized());
  }

  loadTickets() async {
    if (state is Authenticated) {
      final tickets = await authApi.getTickets(state.accessToken!);
      emit(Authenticated(
          accessToken: state.accessToken!,
          phoneNumber: state.phoneNumber!,
          tickets: tickets));
    } else if (state is Guest) {
      final tickets = await authApi.getTickets(state.accessToken!);
      emit(Guest(accessToken: state.accessToken!, tickets: tickets));
    }
  }

  loadStoredState() async {
    var storedState = await userDataStorage.getUserState();

    if (storedState is! Unauthorized) {
      var user = await authApi.getCurrentUser(storedState.accessToken!);
      if (user == null) {
        userDataStorage.clearUserData();
        return;
      }
    }

    if (storedState is Authenticated) {
      final tickets = await authApi.getTickets(storedState.accessToken!);
      emit(Authenticated(
          accessToken: storedState.accessToken!,
          phoneNumber: storedState.phoneNumber!,
          tickets: tickets));
    } else if (storedState is Guest) {
      final tickets = await authApi.getTickets(storedState.accessToken!);
      emit(Guest(accessToken: storedState.accessToken!, tickets: tickets));
    }
  }

  isTokenValid() async {
    if (state is Authenticated || state is Guest) {
      final user = await authApi.getCurrentUser(state.accessToken!);
      return user != null;
    } else {
      return false;
    }
  }
}

class UserDataStorage {
  static const String _isAnonymousKey = 'anonymous';
  static const String _accessTokenKey = 'access_token';
  static const String _phoneNumberKey = 'phone_number';

  Future<void> saveUserData({
    required bool isAnonymous,
    String? accessToken,
    String? phoneNumber,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_isAnonymousKey, isAnonymous);
    await prefs.setString(_accessTokenKey, accessToken ?? '');
    await prefs.setString(_phoneNumberKey, phoneNumber ?? '');
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_isAnonymousKey);
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_phoneNumberKey);
  }

  Future<UserState> getUserState() async {
    final prefs = await SharedPreferences.getInstance();

    bool? isAnonymous = prefs.getBool(_isAnonymousKey);
    String? accessToken = prefs.getString(_accessTokenKey);
    String? phoneNumber = prefs.getString(_phoneNumberKey);

    if (isAnonymous == null || accessToken == null) {
      return Unauthorized();
    }

    if (isAnonymous || (phoneNumber ?? "").isEmpty) {
      return Guest(accessToken: accessToken);
    } else {
      return Authenticated(accessToken: accessToken, phoneNumber: phoneNumber!);
    }
  }
}
