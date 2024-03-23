use tonic::{transport::Server, Request, Response, Status};

use book::library_server::{Library, LibraryServer};
use book::{BookRequest, BookResponse};

pub mod book {
    tonic::include_proto!("book");
}

#[derive(Default)]
pub struct MyLibrary {}

#[tonic::async_trait]
impl Library for MyLibrary {
    async fn ping_pong(
        &self,
        request: Request<BookRequest>,
    ) -> Result<Response<BookResponse>, Status> {
        let request_data = request.into_inner(); // Get the request data
        let reply = book::BookResponse {
            id: request_data.id,
            title: request_data.title,
            author: request_data.author,
            description: request_data.description,
            published_at: request_data.published_at,
        };
        Ok(Response::new(reply))
    }
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let addr = "[::1]:50051".parse().unwrap();

    let library = MyLibrary::default();
 
    println!("Library server listening on {}", addr);

    Server::builder()
        .accept_http1(true)
        .add_service(LibraryServer::new(library))
        .serve(addr)
        .await?;

    Ok(())
}
