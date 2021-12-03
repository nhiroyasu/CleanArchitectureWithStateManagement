import Foundation

typealias QiitaResponse = [QiitaResponseItem]

struct QiitaResponseItem: Decodable {
    let id: String
    let title: String
    let likesCount: Int
    let createdAt: String
}

protocol QiitaRepository {
    
    func fetch(query: String, callback: (Result<QiitaResponse, Error>) -> Void)
}

class QiitaRepositoryImpl: QiitaRepository {
    
    func fetch(query: String, callback: (Result<QiitaResponse, Error>) -> Void) {
        callback(.success([
            .init(
                id: "0",
                title: "Swiftがすごい",
                likesCount: 10,
                createdAt: "2021/12/03"
            ),
            .init(
                id: "1",
                title: "Pythonがすごい",
                likesCount: 5,
                createdAt: "2021/12/02"
            ),
            .init(
                id: "2",
                title: "Kotlinがすごい",
                likesCount: 3,
                createdAt: "2021/12/01"
            )
        ]))
    }
}
