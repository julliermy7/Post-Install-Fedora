#!/bin/bash

# Gera um Pokémon aleatório e salva num arquivo temporário
pokeget random --hide-name > /tmp/poke.txt

# Mostra o fastfetch com o Pokémon como logo
fastfetch -l /tmp/poke.txt
