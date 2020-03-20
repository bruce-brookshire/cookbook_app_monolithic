part of 'api.dart';

class Invite {
  final int id;
  final int cookbookId;
  final int userId;
  final bool isAccepted;

  Invite(this.id, this.cookbookId, this.userId, this.isAccepted);

  static Invite _fromJson(Map content) => Invite(
        content['id'],
        content['shared_cookbook_id'],
        content['user_id'],
        content['is_accepted'],
      );

  static Future<Invite> create(int cookbookId, int userId) {
    return HTTPInterface.post('/shared_cookbooks/$cookbookId/invitations',
        {"user_id": userId}, _fromJson);
  }
}
