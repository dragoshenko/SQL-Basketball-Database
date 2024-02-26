# Basketball Database SQL Scripts

This repository contains SQL scripts for creating tables, sequences, indexes, and inserting data into a basketball database.

## Sequences

- **SEQ_ASISTURI**: Sequence for generating IDs for the *ASISTURI* table.
- **SEQ_RECUPERARI**: Sequence for generating IDs for the *RECUPERARI* table.
- **SEQ_PARTIDA**: Sequence for generating IDs for the *PARTIDA* table.
- **SEQ_ECHIPA**: Sequence for generating IDs for the *ECHIPA* table.
- **SEQ_ECHIPA_PARTIDA**: Sequence for generating IDs for the *ECHIPA_PARTIDA* table.
- **SEQ_JUCATOR**: Sequence for generating IDs for the *JUCATOR* table.
- **SEQ_ARENA**: Sequence for generating IDs for the *ARENA* table.
- **SEQ_PUNCTE**: Sequence for generating IDs for the *PUNCTE* table.
- **SEQ_ANTRENOR**: Sequence for generating IDs for the *ANTRENOR* table.

## Tables

### ASISTURI

- **id_asisturi**: Numeric identifier for assists.
- **id_jucator**: Numeric identifier for players.
- **id_echipa**: Numeric identifier for teams.
- **numar_asisturi**: Number of assists.
- **Primary Key**: id_asisturi
- **Index**: numar_asisturi

### RECUPERARI

- **id_recuperari**: Numeric identifier for recoveries.
- **id_jucator**: Numeric identifier for players.
- **id_echipa**: Numeric identifier for teams.
- **numar_recuperari**: Number of recoveries.
- **Primary Key**: id_recuperari
- **Index**: numar_recuperari

### PARTIDA

- **id_partida**: Numeric identifier for games.
- **data_partida**: Date of the game.
- **numar_spectatori**: Number of spectators.
- **Primary Key**: id_partida
- **Index**: data_partida, numar_spectatori

### ECHIPA

- **id_echipa**: Numeric identifier for teams.
- **id_arena**: Numeric identifier for arenas.
- **denumire_echipa**: Name of the team.
- **oras**: City of the team.
- **nume_presedinte**: Name of the president.
- **Primary Key**: id_echipa
- **Index**: denumire_echipa, oras, nume_presedinte

### ECHIPA_PARTIDA

- **id_echipa_partida**: Numeric identifier for team-game associations.
- **id_echipa**: Numeric identifier for teams.
- **id_partida**: Numeric identifier for games.
- **Primary Key**: id_echipa_partida
- **Foreign Keys**: id_partida (references PARTIDA(id_partida)), id_echipa (references ECHIPA(id_echipa))

### JUCATOR

- **id_jucator**: Numeric identifier for players.
- **id_echipa**: Numeric identifier for teams.
- **nume**: Last name of the player.
- **prenume**: First name of the player.
- **nationalitate**: Nationality of the player.
- **cetatenie**: Citizenship of the player.
- **varsta**: Age of the player.
- **Primary Key**: id_jucator
- **Index**: nume, prenume, nationalitate, cetatenie, varsta

### ARENA

- **id_arena**: Numeric identifier for arenas.
- **denumire_arena**: Name of the arena.
- **capacitate**: Capacity of the arena.
- **Primary Key**: id_arena
- **Index**: denumire_arena, capacitate

### PUNCTE

- **id_puncte**: Numeric identifier for points.
- **id_jucator**: Numeric identifier for players.
- **id_echipa**: Numeric identifier for teams.
- **cosuri_3pct**: Number of 3-point baskets.
- **cosuri_2pct**: Number of 2-point baskets.
- **cosuri_1pct**: Number of 1-point baskets.
- **Primary Key**: id_puncte
- **Index**: cosuri_3pct, cosuri_2pct, cosuri_1pct

### ANTRENOR

- **id_antrenor**: Numeric identifier for coaches.
- **id_echipa**: Numeric identifier for teams.
- **nume_antrenor**: Last name of the coach.
- **prenume_antrenor**: First name of the coach.
- **Primary Key**: id_antrenor
- **Index**: nume_antrenor, prenume_antrenor


