public with sharing class PokemonResponse {
    @AuraEnabled
    public Integer count;
    
    @AuraEnabled
    public String next;

    @AuraEnabled
    public String previous;

    @AuraEnabled
    public List<PokemonResponseItem> results;
}