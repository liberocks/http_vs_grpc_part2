use actix_web::{post, web, App, HttpResponse, HttpServer};
use chrono;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize, PartialEq)]
struct Book {
    id: u64,
    title: String,
    author: String,
    description: String,
    published_at: u16,
}

#[post("/")]
async fn ping_pong_book_service(book: web::Json<Book>) -> HttpResponse {
    println!(
        "[{:?}] RECEIVING DATA={:?}",
        chrono::offset::Utc::now(),
        book
    );

    let received_book = book.into_inner();
    HttpResponse::Ok().json(received_book)
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().service(ping_pong_book_service))
        .bind(("127.0.0.1", 3000))?
        .run()
        .await
}

#[cfg(test)]
mod tests {
    use super::*;
    use actix_web::{body::to_bytes, http, test};
    use serde_json::json;

    #[actix_web::test]
    async fn test_post_book() {
        let app = test::init_service(App::new().service(ping_pong_book_service)).await;

        let req = test::TestRequest::post()
            .uri("/")
            .set_json(&json!({
                "id": 1,
                "title": "Example Book",
                "author": "John Doe",
                "description": "A wonderful book",
                "published_at": 2022
            }))
            .to_request();

        let resp = test::call_service(&app, req).await;
        assert_eq!(resp.status(), http::StatusCode::OK);

        // Await the body result
        let body = to_bytes(resp.into_body()).await.unwrap();

        // let body = test::read_body(resp.take_body().await.into_bytes().await);
        let received_book: Book = serde_json::from_slice(&body).unwrap();

        let expected_book = Book {
            id: 1,
            title: String::from("Example Book"),
            author: String::from("John Doe"),
            description: String::from("A wonderful book"),
            published_at: 2022,
        };

        assert_eq!(received_book, expected_book);
    }
}
