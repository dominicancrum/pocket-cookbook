import Foundation
import Testing
@testable import NetworkKit

struct NetworkRequestTests {
  @Test func getRequestMethodName() {
    let request = NetworkRequest<Data>(url: URL(string: "https://example.com")!, method: .get([]))
    #expect(request.urlRequest.httpMethod == "GET")
  }
  
  @Test func getRequestQueryParams() {
    let queryItems: [URLQueryItem] = [
      URLQueryItem(name: "key", value: "value"),
      URLQueryItem(name: "count", value: String(10)),
    ]
    let request = NetworkRequest<Data>(url: URL(string: "https://example.com")!, method: .get(queryItems))
    let urlRequest = request.urlRequest
    
    #expect(urlRequest.url?.absoluteString == "https://example.com?key=value&count=10")
  }
  
  @Test func postRequestMethodName() {
    let request = NetworkRequest<Data>(url: URL(string: "https://example.com")!, method: .post(Data()))
    #expect(request.urlRequest.httpMethod == "POST")
  }

  @Test func postRequestBody() {
    let request = NetworkRequest<Data>(url: URL(string: "https://example.com")!, method: .post(Data()))
    
    let urlRequest = request.urlRequest
    #expect(urlRequest.httpBody != nil)
    #expect(urlRequest.httpBody == Data())
  }
  
  @Test func putRequestMethodName() {
    let request = NetworkRequest<Data>(url: URL(string: "https://example.com")!, method: .put(Data()))
    #expect(request.urlRequest.httpMethod == "PUT")
  }
  
  @Test func putRequestBody() {
    let request = NetworkRequest<Data>(url: URL(string: "https://example.com")!, method: .put(Data()))
    
    let urlRequest = request.urlRequest
    #expect(urlRequest.httpBody != nil)
    #expect(urlRequest.httpBody == Data())
  }
  
  @Test func deleteRequestMethodName() {
    let request = NetworkRequest<Data>(url: URL(string: "https://example.com")!, method: .delete)
    #expect(request.urlRequest.httpMethod == "DELETE")
  }
  
  @Test func headRequestMethodName() {
    let request = NetworkRequest<Data>(url: URL(string: "https://example.com")!, method: .head)
    #expect(request.urlRequest.httpMethod == "HEAD")
  }
}
