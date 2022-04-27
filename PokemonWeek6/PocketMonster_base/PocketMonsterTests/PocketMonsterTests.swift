//
//  PocketMonsterTests.swift
//  PocketMonsterTests
//
//  Created by Bryan Andres  Almeida Flores on 26/04/2022.
//

import XCTest
@testable import  PocketMonster
import Combine

class PocketMonsterTests: XCTestCase {
    private var subscribers = Set <AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
      
    }

    func loadPokemons_GetSucess() throws {
        //GIVEN
        let  fakeNetworkManager = FakeNetworkManager()
        let remote = NetworkManager (networkmanager : fakeNetworkManager)
        let repository = PokemonResponse (from: FakeNetworkManager)
        let data = try getDataFrom(jsonFile: "pokemon_response_success")
        var viewModel = PokemonListViewModel ()
        fakeNetworkManager.data = data
        var pokemons: [PokemonData] = []
       
        //WHEN
        viewModel.pokemons
        viewModel
            .$pokemons
            .dropFirst()
            .sink { result in
                pokemons = result
            }
            .store(in: &subscribers)
        
        //THEN
        
        XCTAssertEqual(pokemons.count, 1126)
        XCTAssertTrue(pokemons.first?.name == "squirtle")
    }

    
    
    private func getDataFrom(jsonFile: String) throws -> Data {
        let bundle = Bundle(for: PocketMonsterTests.self)
        guard let url = bundle.url(forResource: jsonFile, withExtension: "json")
        else { return Data() }
        return try Data(contentsOf: url)
    }
    

}
