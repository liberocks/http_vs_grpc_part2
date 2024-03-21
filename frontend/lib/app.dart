import 'package:fixnum/fixnum.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/model.dart';
import 'package:frontend/sql/base.dart';
import 'package:frontend/sql/insert.dart';
import 'package:frontend/sql/reset.dart';
import 'package:frontend/sql/sql.dart';
import 'package:frontend/sql/stat.dart';
import 'package:frontend/widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:grpc/grpc.dart';
import 'package:frontend/grpc/book.pbgrpc.dart';

import 'utils/utils.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _percentage = 0;
  int _step = 0;
  int _concurrencies = 1;
  final int _targetDuration = 10000;
  Result _httpResult = Result.zero();
  Result _grpcResult = Result.zero();

  void _setPercentage(int percentage) {
    setState(() {
      _percentage = percentage;
    });
  }

  void _setStep(int step) {
    setState(() {
      _step = step;
    });
  }

  void _reset() {
    setState(() {
      _percentage = 0;
      _step = 0;
      _httpResult = Result.zero();
      _grpcResult = Result.zero();
    });
  }

  Future<(Result, Result)> _computeBenchmarkResult() async {
    final httpResult = await stat('http');
    final grpcResult = await stat('grpc');

    return (httpResult, grpcResult);
  }

  Future<void> _runGrpcBenchmark() async {
    // variables
    bool keepLooping = false;
    final channel = ClientChannel(
      'localhost',
      port: 50051,
      options: ChannelOptions(
        credentials: const ChannelCredentials.insecure(),
        codecRegistry:
            CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
      ),
    );
    final stub = LibraryClient(channel);

    DateTime start = DateTime.now();
    keepLooping = true;
    while (keepLooping) {
      bool isError = false;
      DateTime tic = DateTime.now();

      try {
        final id = Int64(1);
        final response = await stub.pingPong(
          BookRequest(
            id: id,
            title: "Example Book",
            author: "John Doe",
            description: "A wonderful book",
            publishedAt: 2022,
          ),
        );
      } catch (e) {
        logDebug('onError: $e', level: Level.error);
        isError = true;
      }

      DateTime toc = DateTime.now();
      final latency = toc.difference(tic).inMilliseconds;

      insert(category: 'grpc', latency: latency, isError: isError);

      final duration = DateTime.now().difference(start).inMilliseconds;

      final percentage = 50 + (duration / _targetDuration * 100) ~/ 2;
      _setPercentage(percentage);

      if (duration >= _targetDuration) {
        keepLooping = false;
      }
    }
  }

  Future<void> _runHttpBenchmark() async {
    // variables
    bool keepLooping = false;
    final dio = Dio();

    DateTime start = DateTime.now();
    keepLooping = true;
    while (keepLooping) {
      bool isError = false;
      DateTime tic = DateTime.now();

      try {
        await dio.post('http://localhost:3000', data: {
          "id": 1,
          "title": "Example Book",
          "author": "John Doe",
          "description": "A wonderful book",
          "published_at": 2022
        });
      } catch (e) {
        logDebug('onError: $e', level: Level.error);
        isError = true;
      }

      DateTime toc = DateTime.now();
      final latency = toc.difference(tic).inMilliseconds;

      insert(category: 'http', latency: latency, isError: isError);

      final duration = DateTime.now().difference(start).inMilliseconds;

      final percentage = (duration / _targetDuration * 100) ~/ 2;
      _setPercentage(percentage);

      if (duration >= _targetDuration) {
        keepLooping = false;
      }
    }
  }

  void _startBenchmark() async {
    final db = await BaseSqlite.open();

    setState(() {
      _httpResult = Result.zero();
      _grpcResult = Result.zero();
    });

    _setStep(1); // data initialization
    await create(db);
    await reset(db);

    _setStep(2); // http benchmark
    await Future.wait(
      List.generate(_concurrencies, (index) => _runHttpBenchmark()),
    );

    _setStep(3); // grpc benchmark
    await Future.wait(
      List.generate(_concurrencies, (index) => _runGrpcBenchmark()),
    );

    _setStep(4); // computing result
    final (httpResult, grpcResult) = await _computeBenchmarkResult();
    setState(() {
      _httpResult = httpResult;
      _grpcResult = grpcResult;
    });

    _setStep(5); // finish
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Benchmark').text.xl3.bold.make(),
      ),
      floatingActionButton: Visibility(
        visible: _step == 0,
        child: HStack([
          IconButton(
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(backgroundColor: Vx.amber400),
            onPressed: () {
              setState(() {
                _concurrencies++;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            style: IconButton.styleFrom(backgroundColor: Vx.amber400),
            onPressed: () {
              setState(() {
                _concurrencies--;
                if (_concurrencies < 1) {
                  _concurrencies = 1;
                }
              });
            },
          )
        ]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: _step == 0,
              child: Button(
                onPressed: _startBenchmark,
                text: 'Start benchmark',
                subText:
                    "with $_concurrencies ${_concurrencies > 1 ? 'concurrencies' : 'concurrency'}",
              ),
            ),
            Visibility(
              visible: _step == 1,
              child: Button(
                onPressed: () {},
                text: 'In Progress',
                subText: 'Initializing data and starting benchmark...',
              ),
            ),
            Visibility(
              visible: _step == 2,
              child: Button(
                onPressed: () {},
                text: 'Processing $_percentage%',
                subText: 'Benchmarking HTTP...',
              ),
            ),
            Visibility(
              visible: _step == 3,
              child: Button(
                onPressed: () {},
                text: 'Processing $_percentage%',
                subText: 'Benchmarking gRPC...',
              ),
            ),
            Visibility(
              visible: _step == 4,
              child: Button(
                onPressed: () {},
                text: 'Finishing',
                subText: 'Doing some magic and computing benchmark result...',
              ),
            ),
            Visibility(
                visible: _step == 5,
                child: ResultCard(
                  httpData: _httpResult,
                  grpcData: _grpcResult,
                )),
            Visibility(
              visible: _step == 5,
              child: Button(
                onPressed: _reset,
                text: 'Reset ',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
