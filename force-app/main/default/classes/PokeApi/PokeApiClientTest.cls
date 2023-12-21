@IsTest
private class PokeApiClientTest {
    
    @IsTest static void testGetPokemonCollectionDefault() {
        String responseBody = '{ "count": 1292, "results": [{"name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon/1/"}] }';
        HttpCalloutTestHelper.MockHttpResponseGenerator mockHttp = 
            new HttpCalloutTestHelper.MockHttpResponseGenerator(HttpCalloutTestHelper.createMockResponse(responseBody, 200));
        Test.setMock(HttpCalloutMock.class, mockHttp);

        Test.startTest();
        PokeApiClient client = new PokeApiClient();
        PokemonResponse response = client.getPokemonCollection();
        Test.stopTest();

        System.assertEquals(1292, response.count, 'The count should be 1292.');
        System.assertEquals('bulbasaur', response.results.get(0).name, 'First pokemon result name should match bulbasaur');
    }

    @IsTest static void testGetPokemonCollectionWithParams() {
        String responseBody = '{ "count": 1292, "results": [{"name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon/1/"}] }';
        HttpCalloutTestHelper.MockHttpResponseGenerator mockHttp = 
            new HttpCalloutTestHelper.MockHttpResponseGenerator(HttpCalloutTestHelper.createMockResponse(responseBody, 200));
        Test.setMock(HttpCalloutMock.class, mockHttp);

        Test.startTest();
        PokeApiClient client = new PokeApiClient();
        PokemonResponse response = client.getPokemonCollection(0, 1);
        Test.stopTest();

        System.assertEquals(1292, response.count, 'The count should be 1292.');
        System.assertEquals('bulbasaur', response.results.get(0).name, 'First pokemon result name should match bulbasaur');
    }

    @IsTest static void testGetPokemonDetail() {
        String responseBody = '{ "id": 1, "name": "bulbasaur", "sprites": { "front_default": "https://url.mock/front", "back_default": "https://url.mock/back" }, "moves": [{ "move": { "name": "move1", "url": "https://url.mock/move1" } }] }';
        HttpCalloutTestHelper.MockHttpResponseGenerator mockHttp = 
            new HttpCalloutTestHelper.MockHttpResponseGenerator(HttpCalloutTestHelper.createMockResponse(responseBody, 200));
        Test.setMock(HttpCalloutMock.class, mockHttp);

        Test.startTest();
        PokeApiClient client = new PokeApiClient();
        PokemonDetailResponse response = client.getPokemonDetail('https://pokeapi.co/api/v2/pokemon/1');
        Test.stopTest();

        System.assertEquals('bulbasaur', response.name, 'The name should be bulbasaur.');
    }

    // Test the getMove method
    @IsTest static void testGetMove() {
        // Set up the mock HTTP response
        String responseBody = '{ "id": 1, "name": "pound", "power": 40, "accuracy": 100, "pp": 50, "priority": 0 }';
        HttpCalloutTestHelper.MockHttpResponseGenerator mockHttp = 
            new HttpCalloutTestHelper.MockHttpResponseGenerator(HttpCalloutTestHelper.createMockResponse(responseBody, 200));
        Test.setMock(HttpCalloutMock.class, mockHttp);

        Test.startTest();
        PokeApiClient client = new PokeApiClient();
        PokemonMoveDetailResponse response = client.getMove('https://pokeapi.co/api/v2/move/1');
        Test.stopTest();

        System.assertEquals('pound', response.name, 'The name should be pound.');
    }

    
}