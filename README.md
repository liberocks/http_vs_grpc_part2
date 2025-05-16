# HTTP vs gRPC web benchmark
This repository contains a simple benchmark to compare the performance of gRPC and HTTP in a mobile application. This benchmark was done because I was curious about the performance of gRPC and how it compares to HTTP.

## How to run the benchmark
1. Run the http server
```bash
cargo run --release --bin http
```

2. Run the grpc server
```bash
cargo run --release --bin grpc-server
```

3. Run the flutter application
```bash
flutter pub get
flutter run
```

4. Allow the application to access the network
```bash
adb reverse tcp:3000 tcp:3000
adb reverse tcp:50051 tcp:50051
```

## Results
The benchmark was performed in Mac Mini M1 with 16GB of RAM and the following results were obtained:

Running 1 connection
![Benchmark with 1 concurrency](images/1.png?raw=true)

Running 2 concurrencies
![Benchmark with 2 concurrencies](images/2.png?raw=true)

Running 3 concurrencies
![Benchmark with 3 concurrencies](images/3.png?raw=true)


## Conclusion
gRPC is much faster than HTTP. The latency is lower and the throughput is higher. This is because gRPC uses HTTP/2 and binary serialization, which makes it faster than HTTP. However, gRPC is not a silver bullet and it has its own trade-offs. For example, gRPC is not as easy to debug as HTTP and it is not as widely used as HTTP. Therefore, it is important to consider the trade-offs before choosing gRPC over HTTP.
