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
        uint _id,
        Skill[] memory _skills,
        PokemonType[] memory _pokemonType
    ) public {
        require(
            ownerPokemonCount[msg.sender] == 0,
            "You already have a pokemon!"
        );
        require(_id > 0, "Id must be greater than 0");
        require(
            bytes(_name).length > 2,
            "Name must be at least 3 characters long"
        );
        require(_skills.length > 0, "Pokemon must have at least 1 skill");
        require(
            _pokemonType.length > 0,
            "Pokemon must have at least 1 pokemon type"
        );

        Pokemon storage newPokemon = pokemons[_id];
        newPokemon.id = _id;
        newPokemon.name = _name;

        for (uint i = 0; i < _skills.length; i++) {
            newPokemon.skills[i] = _skills[i];
        }

        for (uint i = 0; i < _pokemonType.length; i++) {
            newPokemon.pokemonType[i] = _pokemonType[i];
        }

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit pokemonCreated(_id, _name, _skills.length);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }
}
