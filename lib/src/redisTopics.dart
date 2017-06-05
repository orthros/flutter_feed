import 'package:redis/redis.dart';
import './message.dart';

class RedisTopics {
  ///The name of the redis channel to subscribe to
  ///this needs to be of format word.* so we can have "topics"
  final String _feedName = "feed.*";

  ///When a message is recieved. Call this function.
  ///Default implmentation is void
  Function _onUpdated = (Message mess) => {};

  ///Creates a Redis listener on 'feed.*' && psubs to
  ///events on it.
  ///onUpdated is the callback to call when
  ///a message is recieved
  RedisTopics(String serverName, int portNum,
      [void onUpdated(Message messes)]) {
    if (onUpdated != null) {
      _onUpdated = onUpdated;
    }

    RedisConnection connection = new RedisConnection();
    connection.connect(serverName, portNum).then((Command c) {
      PubSub ps = new PubSub(c);
      List<String> channels = new List<String>();
      channels.add(_feedName);
      ps.psubscribe(channels);
      ps.getStream().listen((message) {
        //Schema is [eventType, channel, message] for subscribe
        //Schema is [eventType, wildcardChannel, channel, message] for psubscribe
        String event = message[0];
        print("Message: $message");

        if (event == "pmessage") {
          String wildCardChannel = message[1];
          String specificChannel = message[2];
          String mess = message[3];

          String topic = specificChannel.split('.')[1];

          print("Message: $mess on topic $topic on channel: $wildCardChannel ");

          Message msg = new Message(topic, mess);
          _onUpdated(msg);
        }
      });
    });
  }
}
