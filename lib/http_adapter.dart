import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http2/transport.dart';
import 'package:test_http2/http_client.dart';

class HttpAdapter implements HttpClient {
  @override
  Future<dynamic> request({required String url, required Method method}) async {
    Uri uri = Uri.parse(url);

    ClientTransportConnection transport = ClientTransportConnection.viaSocket(
      await SecureSocket.connect(
        uri.host,
        uri.port,
        supportedProtocols: ['h2'],
      ),
    );

    ClientTransportStream stream = transport.makeRequest(
      [
        Header.ascii(':method', method.name.toUpperCase()),
        Header.ascii(':path', uri.path),
        Header.ascii(':scheme', uri.scheme),
        Header.ascii(':authority', uri.host),
      ],
      endStream: true,
    );

    List<int> messageResponseBytes = [];
    await for (var message in stream.incomingMessages) {
      if (message is HeadersStreamMessage) {
        for (var header in message.headers) {
          var name = utf8.decode(header.name);
          var value = utf8.decode(header.value);
          debugPrint('Header: $name: $value');
        }
      } else if (message is DataStreamMessage) {
        messageResponseBytes.addAll(message.bytes);
      }
    }
    final response = jsonDecode(utf8.decode(messageResponseBytes));

    await transport.finish();
    return response;
  }
}
