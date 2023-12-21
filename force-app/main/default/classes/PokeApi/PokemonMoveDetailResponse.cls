public with sharing class PokemonMoveDetailResponse {
    @AuraEnabled
    public Integer id;

    @AuraEnabled
    public String name;

    @AuraEnabled
    public Integer accuracy;

    @AuraEnabled
    public Integer priority;

    @AuraEnabled
    public Integer pp;

    @AuraEnabled
    public Integer power;
}
