import { LightningElement, wire, track } from 'lwc';
import getPokemonList from '@salesforce/apex/PokedexController.getPokemon';
import getMoves from '@salesforce/apex/PokedexController.getPokemonDetail';

export default class PokedexContainer extends LightningElement {
    @track pokemon;
    @track selectedPokemon;
    @track fieldInfo = [];
    @track moves;
    @track sprites;
    @track sortBy;
    @track sortDir;

    columns = [
        { label: 'Name', fieldName: 'name' },
        { label: 'PP', fieldName: 'pp', sortable: true },
        { label: 'Accuracy', fieldName: 'accuracy', sortable: true },
        { label: 'Power', fieldName: 'power', sortable: true },
        { label: 'Priority', fieldName: 'priority', sortable: true }
    ];

    @wire(getPokemonList)
    getData({ error, data }) {
        if (data) {
            this.pokemon = data;
            let pokemonResponse = data; 

            console.log(`Results: ${JSON.stringify(pokemonResponse)}`);

            for (let result of pokemonResponse.results) {
                console.log(`Result ${result.name} = ${result.url}`);
                this.fieldInfo.push({
                    label: result.name,
                    value: result.url
                });
            }

            console.log(`FieldInfo: ${JSON.stringify(this.fieldInfo)}`);
        } else if (error) {
            this.error = error;
        }

        console.log(`Pokemon: ${JSON.stringify(this.pokemon)}`);
    }

    @wire(getMoves, {url: '$selectedPokemon'})
    getMoves({ error, data }) {
        if (data) {
            console.log(`Move data: ${JSON.stringify(data)}`);

            this.moves = data.moves.map(x => x.move);
            this.sprites = data.sprites;
        }
        
        if (error) {
            console.log(error);
        }
    }

    onPokemonSelectionChanged(event) {
        console.log(`Event detail: ${JSON.stringify(event.detail.value)}`);
        this.selectedPokemon = event.detail.value;
    }

    onDatatableSort(event) {
        this.sortBy = event.detail.fieldName;
        this.sortDir = event.detail.sortDirection;

        let moveData = JSON.parse(JSON.stringify(this.moves));

        let keyValue = (a) => {
            return a[this.sortBy];
        };

        let isReverse = this.sortDir === 'asc' ? 1: -1;

        moveData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : '';
            y = keyValue(y) ? keyValue(y) : '';
            return isReverse * ((x > y) - (y > x));
        });

        this.moves = moveData;
    }
}