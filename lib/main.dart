import 'package:flutter/material.dart';
import 'package:test_http2/http_adapter.dart';
import 'package:test_http2/post_model.dart';

import 'http_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP2 Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final httpClient = HttpAdapter();
                final response = await httpClient.request(
                  url: 'https://jsonplaceholder.typicode.com/posts/1',
                  method: Method.get,
                );
                PostModel post = PostModel.fromMap(response);
                debugPrint('Post title: ${post.title}');
              },
              child: const Text('Test'),
            ),
          ],
        ),
      ),
    );
  }
}
