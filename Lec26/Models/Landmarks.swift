//
//  Landmarks.swift
//  Lec26
//
//  Created by Netanel Mantsoor on 29/01/2022.
//

import Foundation
import Combine
struct Landmarks{
    static func load() -> AnyPublisher<[Landmark],Error>{
        guard let url = Bundle.main.url(
            forResource: "camp_il",
            withExtension: "json") else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
        return URLSession.shared.dataTaskPublisher(for: url).tryMap { data, res  in
           try JSONDecoder().decode([Landmark].self, from: data)
        }.eraseToAnyPublisher()
    }
}
