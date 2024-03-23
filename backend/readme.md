# HTTP vs gRPC web benchmark
This repository contains a simple benchmark to compare the performance of gRPC-web and HTTP in a web application. This benchmark was done because I was curious about the performance of gRPC-web and how it compares to HTTP. Before I knew tonic support for gRPC-web, I used to run gRPC service behind an Envoy proxy to make it work with the web. Now that tonic supports gRPC-web, I wanted to see how it compares to HTTP.


## How to run the HTTP benchmark
1. Run the server
```bash
cargo run --release --bin http
```

2. Run the benchmark
```bash
./benchmark.sh
```

## How to run the gRPC-web benchmark
1. Run the server
```bash
cargo run --release --bin grpc-server
```

2. Run the benchmark
```bash
./benchmark.sh
```

## Results
The benchmark was performed in Mac Mini M1 with 16GB of RAM and the following results were obtained:

### HTTP
```
Running 10s test @ http://127.0.0.1:3000/
500 connections with 10 pipelining factor
10 workers

┌─────────┬──────┬──────┬────────┬────────┬──────────┬──────────┬────────┐
│ Stat    │ 2.5% │ 50%  │ 97.5%  │ 99%    │ Avg      │ Stdev    │ Max    │
├─────────┼──────┼──────┼────────┼────────┼──────────┼──────────┼────────┤
│ Latency │ 0 ms │ 5 ms │ 105 ms │ 137 ms │ 17.04 ms │ 28.78 ms │ 384 ms │
└─────────┴──────┴──────┴────────┴────────┴──────────┴──────────┴────────┘
┌───────────┬─────────┬─────────┬─────────┬─────────┬───────────┬───────────┬─────────┐
│ Stat      │ 1%      │ 2.5%    │ 50%     │ 97.5%   │ Avg       │ Stdev     │ Min     │
├───────────┼─────────┼─────────┼─────────┼─────────┼───────────┼───────────┼─────────┤
│ Req/Sec   │ 158,207 │ 158,207 │ 303,359 │ 337,663 │ 290,924.8 │ 46,535.25 │ 158,138 │
├───────────┼─────────┼─────────┼─────────┼─────────┼───────────┼───────────┼─────────┤
│ Bytes/Sec │ 33.7 MB │ 33.7 MB │ 64.6 MB │ 71.9 MB │ 62 MB     │ 9.91 MB   │ 33.7 MB │
└───────────┴─────────┴─────────┴─────────┴─────────┴───────────┴───────────┴─────────┘

Req/Bytes counts sampled once per second.
# of samples: 100

2914k requests in 10.16s, 620 MB read
```

### gRPC-web
```
Running 10s test @ http://127.0.0.1:3000/
500 connections with 10 pipelining factor
10 workers

┌─────────┬──────┬──────┬────────┬────────┬──────────┬──────────┬────────┐
│ Stat    │ 2.5% │ 50%  │ 97.5%  │ 99%    │ Avg      │ Stdev    │ Max    │
├─────────┼──────┼──────┼────────┼────────┼──────────┼──────────┼────────┤
│ Latency │ 1 ms │ 9 ms │ 114 ms │ 145 ms │ 20.66 ms │ 29.75 ms │ 333 ms │
└─────────┴──────┴──────┴────────┴────────┴──────────┴──────────┴────────┘
┌───────────┬─────────┬─────────┬─────────┬─────────┬─────────┬───────────┬─────────┐
│ Stat      │ 1%      │ 2.5%    │ 50%     │ 97.5%   │ Avg     │ Stdev     │ Min     │
├───────────┼─────────┼─────────┼─────────┼─────────┼─────────┼───────────┼─────────┤
│ Req/Sec   │ 154,879 │ 154,879 │ 242,303 │ 292,863 │ 239,328 │ 31,957.39 │ 154,835 │
├───────────┼─────────┼─────────┼─────────┼─────────┼─────────┼───────────┼─────────┤
│ Bytes/Sec │ 19.2 MB │ 19.2 MB │ 30 MB   │ 36.3 MB │ 29.7 MB │ 3.97 MB   │ 19.2 MB │
└───────────┴─────────┴─────────┴─────────┴─────────┴─────────┴───────────┴─────────┘

Req/Bytes counts sampled once per second.
# of samples: 100

2398k requests in 10.04s, 297 MB read
```

## Conclusion
gRPC-web is slower than HTTP. The latency is higher, the throughput is lower, and the memory footprint is two fold lower. To be honest I expect it runs faster than HTTP, but it is not the case. I suspect that the performance of gRPC-web is affected by the translation of the gRPC protocol to HTTP/1.1. However, the difference is not that big. gRPC-web is a good option if you want to use gRPC in the web. It is not as fast as HTTP, but it is not that slow either. The difference is not that big and it is worth it if you want to use gRPC in the web.
```