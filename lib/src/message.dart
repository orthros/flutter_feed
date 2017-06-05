class Message {
  ///The Body of the message
  final String body;

  ///The Topic of the message
  final String topic;

  ///The time the message was created
  final DateTime timeStamp;

  const Message(this.topic, this.body, this.timeStamp);
}
