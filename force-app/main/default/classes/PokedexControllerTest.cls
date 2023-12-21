/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class PokedexControllerTest {

    @IsTest static void testGetPokemon() {
        String responseBody = '{ "count": 1292, "results": [{"name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon/1/"}] }';
        HttpCalloutTestHelper.MockHttpResponseGenerator mockHttp = 
            new HttpCalloutTestHelper.MockHttpResponseGenerator(HttpCalloutTestHelper.createMockResponse(responseBody, 200));
        Test.setMock(HttpCalloutMock.class, mockHttp);

        Test.startTest();
        PokemonResponse response = PokedexController.getPokemon();
        Test.stopTest();

        System.assertEquals(1292, response.count, 'The count should be 1292.');
        System.assertEquals('bulbasaur', response.results.get(0).name, 'First pokemon result name should match bulbasaur');
    }

    @IsTest static void testGetPokemonThrowException() {
        HttpCalloutTestHelper.MockHttpExceptionGenerator mockHttp = 
            new HttpCalloutTestHelper.MockHttpExceptionGenerator();
        Test.setMock(HttpCalloutMock.class, mockHttp);

        Test.startTest();
        try {
            PokemonResponse response = PokedexController.getPokemon();
        }
        catch (Exception ex) {
            System.assertEquals(true, ex instanceof HttpCalloutTestHelper.MockException);
        }
        Test.stopTest();
    }

    @IsTest static void testGetPokemonDetail() {
        String responseBody = '{ "id": 1, "name": "bulbasaur", "sprites": { "front_default": "https://url.mock/front", "back_default": "https://url.mock/back" }, "moves": [{ "move": { "name": "move1", "url": "https://url.mock/move1" } }] }';
        HttpCalloutTestHelper.MockHttpResponseGenerator mockHttp = 
            new HttpCalloutTestHelper.MockHttpResponseGenerator(HttpCalloutTestHelper.createMockResponse(responseBody, 200));
        Test.setMock(HttpCalloutMock.class, mockHttp);

        Test.startTest();
        PokemonDetailResponse response = PokedexController.getPokemonDetail('https://pokeapi.co/api/v2/pokemon/1');
        Test.stopTest();

        System.assertEquals('bulbasaur', response.name, 'The name should be bulbasaur.');
        System.assert(String.isNotEmpty(response.sprites.front_default), 'Front sprite has value');
        System.assert(String.isNotEmpty(response.sprites.back_default), 'Back sprite has value');
        System.assertEquals(response.moves.size(), 1, '1 move detail should exist');
    }

    @IsTest static void testGetPokemonDetailThrowException() {
        HttpCalloutTestHelper.MockHttpExceptionGenerator mockHttp = 
            new HttpCalloutTestHelper.MockHttpExceptionGenerator();
        Test.setMock(HttpCalloutMock.class, mockHttp);

        Test.startTest();
        try {
            PokemonDetailResponse response = PokedexController.getPokemonDetail('https://pokeapi.co/api/v2/pokemon/1');
        }
        catch (Exception ex) {
            System.assertEquals(true, ex instanceof HttpCalloutTestHelper.MockException);
        }
        Test.stopTest();
    }
}