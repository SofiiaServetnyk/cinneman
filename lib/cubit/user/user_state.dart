import 'package:cinneman/data/models/ticket.dart';

abstract class UserState {
  final bool isAuthenticated;
  final bool isAnonymous;
  final List<Ticket>? tickets;
  final String? accessToken;
  final String? phoneNumber;

  UserState(
      {required this.isAuthenticated,
      required this.isAnonymous,
      this.tickets,
      this.accessToken,
      this.phoneNumber});
}

class Unauthorized extends UserState {
  Unauthorized({String? phoneNumber})
      : super(
            isAnonymous: true,
            isAuthenticated: false,
            phoneNumber: phoneNumber);
}

class Guest extends UserState {
  Guest({required String accessToken, List<Ticket>? tickets})
      : super(
            isAnonymous: true,
            isAuthenticated: true,
            accessToken: accessToken,
            tickets: tickets);
}

class Authenticated extends UserState {
  Authenticated(
      {required String accessToken,
      required String phoneNumber,
      List<Ticket>? tickets})
      : super(
            isAnonymous: false,
            isAuthenticated: true,
            accessToken: accessToken,
            phoneNumber: phoneNumber,
            tickets: tickets);
}
