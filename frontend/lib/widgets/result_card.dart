import 'package:flutter/material.dart';
import 'package:frontend/model/model.dart';
import 'package:velocity_x/velocity_x.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({super.key, required this.httpData, required this.grpcData,required this.concurrencies,});

  final Result httpData;
  final Result grpcData;
  final int concurrencies; 

  @override
  Widget build(BuildContext context) {
    return VStack([
      const SizedBox(height: 8),
      HStack(
        [
          const Text('HTTP').text.semiBold.xl.make(),
          const Text('vs').text.semiBold.xl.make(),
          const Text('gRPC').text.semiBold.xl.make(),
        ],
        alignment: MainAxisAlignment.spaceBetween,
      ).wFull(context).py8().px16(),
      const Divider().px16(),
      HStack(
        [
          Text('${httpData.duration / 1000.0} s').text.base.make(),
          const Text('Duration').text.lg.make(),
          Text('${grpcData.duration / 1000.0} s').text.base.make(),
        ],
        alignment: MainAxisAlignment.spaceBetween,
      ).wFull(context).py8().px16(),
      const Divider().px16(),
      HStack(
        [
          Text('${httpData.latency} ms').text.base.make(),
          const Text('Latency (avg)').text.lg.make(),
          Text('${grpcData.latency} ms').text.base.make(),
        ],
        alignment: MainAxisAlignment.spaceBetween,
      ).wFull(context).py8().px16(),
      const Divider().px16(),
      HStack(
        [
          Text(httpData.reqPerSec.toString()).text.base.make(),
          const Text('Req/sec (avg)').text.lg.make(),
          Text(grpcData.reqPerSec.toString()).text.base.make(),
        ],
        alignment: MainAxisAlignment.spaceBetween,
      ).wFull(context).py8().px16(),
      const Divider().px16(),
      HStack(
        [
          Text(concurrencies.toString()).text.base.make(),
          const Text('Concurrencies').text.lg.make(),
          Text(concurrencies.toString()).text.base.make(),
        ],
        alignment: MainAxisAlignment.spaceBetween,
      ).wFull(context).py8().px16(),
      const Divider().px16(),      HStack(
        [
          Text(httpData.requests.toString()).text.base.make(),
          const Text('Samples').text.lg.make(),
          Text(grpcData.requests.toString()).text.base.make(),
        ],
        alignment: MainAxisAlignment.spaceBetween,
      ).wFull(context).py8().px16(),
      const Divider().px16(),
      HStack(
        [
          Text(httpData.errors.toString()).text.base.make(),
          const Text('Errors').text.lg.make(),
          Text(grpcData.errors.toString()).text.base.make(),
        ],
        alignment: MainAxisAlignment.spaceBetween,
      ).wFull(context).py8().px16(),
      const SizedBox(height: 8),
    ])
        .box
        .withDecoration(
          BoxDecoration(
            border: Border.all(
              color: Vx.gray400,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        )
        .make()
        .p16()
        .wFull(context);
  }
}
