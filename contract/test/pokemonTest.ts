import { expect } from 'chai';
import { ethers } from 'hardhat';
import {} from '@nomicfoundation/hardhat-toolbox';

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
  Fairy,
}

describe('Pokemon Factory', () => {
  const deployContract = async () => {
    const PokemonFactory = await ethers.getContractFactory('PokemonFactory');
    const pokemonFactory = await PokemonFactory.deploy();
    await pokemonFactory.deployed();
    return {
      pokemonFactory,
    };
  };

  it('Should deploy the contract', async () => {
    const { pokemonFactory } = await deployContract();
    expect(pokemonFactory.address).to.properAddress;
  });

  /* (
        string memory _name,
        uint _id,
        Skill[] memory _skills,
        PokemonType[] memory _pokemonType
    ) */

  it('Should create 2 new pokemons', async () => {
    const { pokemonFactory } = await deployContract();

    await pokemonFactory.createPokemon(
      'Pikachu',
      [
        {
          name: 'Thunder Shock',
          description:
            'A jolt of electricity crashes down on the target to inflict damage.',
        },
        {
          name: 'Thunderbolt',
          description: 'The target is struck by a strong electric blast.',
        },
      ],
      [PokemonType.Electric]
    );

    await pokemonFactory.createPokemon(
      'Bulbasaur',
      [
        {
          name: 'Tackle',
          description:
            'A physical attack in which the user charges and slams into the target with its whole body.',
        },
        {
          name: 'Vine Whip',
          description:
            'The target is struck with slender, whiplike vines to inflict damage.',
        },
      ],
      [PokemonType.Grass, PokemonType.Poison]
    );

    const pokemons = await pokemonFactory.getAllPokemons();

    expect(pokemons.length).to.equal(2);
  });
});
