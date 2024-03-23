
use book::library_client::LibraryClient;
use book::BookRequest;

pub mod book {
    tonic::include_proto!("book");
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let mut client = LibraryClient::connect("http://[::1]:50051").await?;
 
    let request = tonic::Request::new(BookRequest {
        id: 42,
        title: "Tonic".into(),
        author: "Tonic".into(),
        description: "Tonic".into(),
        published_at: 2021,
    });

    let response = client.ping_pong(request).await?;

    println!("RESPONSE={:?}", response);

    Ok(())
}