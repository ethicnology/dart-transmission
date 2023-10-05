class TransmissionRequest {
  final String method;
  final Map<String, dynamic>? arguments;
  final String? tag;

  TransmissionRequest(this.method, {this.arguments, this.tag});

  Map<String, dynamic> toJSON() {
    return {
      'method': method,
      if (arguments != null) 'arguments': arguments,
      if (tag != null) 'tag': tag,
    };
  }

  @override
  String toString() {
    return 'TransmissionRequest{method: $method, arguments: $arguments, tag: $tag}';
  }
}
