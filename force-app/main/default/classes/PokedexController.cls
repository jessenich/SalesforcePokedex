public with sharing class PokedexController {
    @AuraEnabled(cacheable=true)
    public static PokemonResponse getPokemon() {
        try {
            return new PokeApiClient().getPokemonCollection();
        }
        catch (Exception ex) {
            logExceptionToCase(ex);
            throw ex;
        }
    }

    @AuraEnabled(cacheable=true)
    public static PokemonDetailResponse getPokemonDetail(String url) {
        try {
            PokeApiClient client = new PokeApiClient();
            PokemonDetailResponse pokemon = client.getPokemonDetail(url);

            Integer maxMoves = 4;
            if (pokemon.moves.size() > maxMoves) {
                while (pokemon.moves.size() > maxMoves) {
                    pokemon.moves.remove(pokemon.moves.size() - 1);
                }
            }

            for (Integer i = 0; i < pokemon.moves.size(); i++) {
                PokemonDetailMoveDetail move = pokemon.moves.get(i).move;
                PokemonMoveDetailResponse moveDetail = client.getMove(move.url);

                move.id = moveDetail.id;
                move.name = moveDetail.name;
                move.accuracy = moveDetail.accuracy;
                move.power = moveDetail.power;
                move.pp = moveDetail.pp;
                move.priority = moveDetail.priority;
            }

            return pokemon;
        }
        catch (Exception ex) {
            logExceptionToCase(ex);
            throw ex;
        }
    }

    private static void logExceptionToCase(Exception ex) {
        Case exCase = new Case();
        exCase.Subject = 'Exception Occurred';
        exCase.Description = 'Exception details: ' + ex.getMessage();

        try {
            insert exCase;
        } 
        catch (DmlException dmlEx) {
            System.debug('Error creating exception case: ' + dmlEx.getMessage());
        }
    }
}