public with sharing class PokemonDetailResponse {
    @AuraEnabled
    public Integer id;

    @AuraEnabled
    public String name;

    @AuraEnabled
    public List<PokemonDetailMoveResult> moves;

    @AuraEnabled
    public PokemonDetailSpriteResult sprites;
}