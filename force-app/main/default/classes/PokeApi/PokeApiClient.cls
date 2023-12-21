public with sharing class PokeApiClient {
    private static final String POKE_API_BASE_URL = 'https://pokeapi.co/api/v2/';
    
    private Http http;

    public PokeApiClient() {
        this.http = new Http();
    }

    public PokemonResponse getPokemonCollection() {
        return this.getPokemonCollection(0, 1292);
    }
    
    public PokemonResponse getPokemonCollection(Integer offset, Integer count) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(POKE_API_BASE_URL + 'pokemon?offset=' + offset + '&limit=' + count);
        req.setMethod('GET');

        HttpResponse res = this.http.send(req);
        String jsonResponse = res.getBody();
        PokemonResponse response = (PokemonResponse) JSON.deserialize(jsonResponse, PokemonResponse.class);

        System.debug(response.count);

        return response;
    }

    public PokemonDetailResponse getPokemonDetail(String url) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');

        HttpResponse res = this.http.send(req);
        String jsonResponse = res.getBody();
        PokemonDetailResponse response = (PokemonDetailResponse) JSON.deserialize(jsonResponse, PokemonDetailResponse.class);
        
        return response;
    }

    public PokemonMoveDetailResponse getMove(String url) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');

        HttpResponse res = this.http.send(req);
        String jsonResponse = res.getBody();
        PokemonMoveDetailResponse response = (PokemonMoveDetailResponse) JSON.deserialize(jsonResponse, PokemonMoveDetailResponse.class);
        
        return response;
    }
}