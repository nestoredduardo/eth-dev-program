// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    enum PokemonType {
        Fire,
        Water,
        Grass,
        Electric,
        Psychic,
        Normal,
        Fighting,
        Poison,
        Ground,
        Flying,
        Rock,
        Bug,
        Ghost,
        Dragon,
        Dark,
        Steel,
        Fairy
    }

    struct Skill {
        string name;
        string description;
    }

    struct Pokemon {
        uint id;
        string name;
        Skill[] skills;
        PokemonType[] pokemonType;
    }

    Pokemon[] private pokemons;

    mapping(uint => address) public pokemonToOwner;
    mapping(address => uint) ownerPokemonCount;

    event pokemonCreated(uint id, string name, uint skillCount);

    function createPokemon(
        string memory _name,
        Skill[] memory _skills,
        PokemonType[] memory _pokemonType
    ) public {
        require(
            ownerPokemonCount[msg.sender] == 0,
            "You already have a pokemon!"
        );
        require(
            bytes(_name).length > 2,
            "Name must be at least 3 characters long"
        );
        require(_skills.length > 0, "Pokemon must have at least 1 skill");
        require(
            _pokemonType.length > 0,
            "Pokemon must have at least 1 pokemon type"
        );

        Pokemon storage newPokemon = pokemons.push();

        newPokemon.id = pokemons.length - 1;
        newPokemon.name = _name;
        newPokemon.skills = _skills;
        newPokemon.pokemonType = _pokemonType;

        uint _id = pokemons.length - 1;

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit pokemonCreated(_id, _name, _skills.length);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }
}
