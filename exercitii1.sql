--1: Afisati numele, prenumele si numarul de asisturi jucatorilor ce au peste 25 de ani si au marcat mai mult sau egal de 40 numar total de cosuri. 
select j.nume, j.prenume, a.numar_asisturi
from jucator j
join asisturi a on (j.id_jucator = a.id_jucator)
where j.varsta > 25
  and j.id_echipa = (select id_echipa from echipa where denumire_echipa = 'Rapid Bucuresti')
  and j.id_jucator in (select id_jucator from puncte where cosuri_3pct + cosuri_2pct + cosuri_1pct >= 40)
order by a.numar_asisturi desc;


--2: Afisati numele si media numarului de recuperari pentru fiecare echipa care a avut cel putin 2 jucatori cu varsta strict sub 28 de ani.
select e.denumire_echipa, avg(r.numar_recuperari) as medie_recuperari
from echipa e
join jucator j on (e.id_echipa = j.id_echipa)
join recuperari r on (j.id_jucator = r.id_jucator)
where j.varsta < 28
group by e.denumire_echipa
having count(j.id_jucator) >= 2;


--3: Gasiti numele antrenorului si numarul total de puncte realizate de jucatorii dintr-o anumita echipa în toate partidele. De asemenea, includeti si denumirea echipei.
select a.nume_antrenor || ' ' || a.prenume_antrenor as antrenor, sum(p.cosuri_3pct * 3 + p.cosuri_2pct * 2 + p.cosuri_1pct) as total_puncte, e.denumire_echipa
from antrenor a
join echipa e on (a.id_echipa = e.id_echipa)
join jucator j on (e.id_echipa = j.id_echipa)
join puncte p on (j.id_jucator = p.id_jucator)
group by (a.nume_antrenor, a.prenume_antrenor, e.denumire_echipa)
order by total_puncte desc;


--4: Afisati numele jucatorilor si media punctelor lor în toate partidele. Daca un jucator nu are puncte inregistrate, afisati valoarea 0 ca medie. Afisati si un mesaj personalizat pentru jucatorii cu o medie mai mare sau egală cu 100 puncte.
select j.nume, j.prenume, NVL(round(avg(DECODE(p.cosuri_3pct * 3 + p.cosuri_2pct * 2 + p.cosuri_1pct, null, 0, p.cosuri_3pct * 3 + p.cosuri_2pct * 2 + p.cosuri_1pct))), 0) as medie_puncte,
  case
    when NVL(round(avg(DECODE(p.cosuri_3pct * 3 + p.cosuri_2pct * 2 + p.cosuri_1pct, null, 0, p.cosuri_3pct * 3 + p.cosuri_2pct * 2 + p.cosuri_1pct))), 0) >= 100 then 'MVP Contender'
    else 'NOT MVP Contender'
  end as mesaj
from jucator j
left join puncte p on (j.id_jucator = p.id_jucator)
group by j.nume, j.prenume
order by medie_puncte desc;


--5: Afisati numele si prenumele jucatorilor care au aceeasi nationalitate si au acelasi nume sau prenume. Pentru jucatorii care au acelasi nume si prenume, utilizati functia NVL pentru a le atribui un pseudonim pentru a le diferentia.
select 
  NVL(j1.nume || ' ' || j1.prenume, 'Jucator1') as nume_prenume1,
  NVL(j2.nume || ' ' || j2.prenume, 'Jucator2') as nume_prenume2
from jucator j1
join jucator j2 on (j1.nationalitate = j2.nationalitate)
where (j1.nume = j2.nume or j1.prenume = j2.prenume) and j1.id_jucator <> j2.id_jucator;


--13: 1: Stergerea unei echipe si a tuturor inregistrarilor asociate cu acea echipa.
delete from echipa
where id_echipa = (
    select id_echipa
    from echipa
    where denumire_echipa = 'Steaua Bucuresti'
);
delete from echipa_partida
where id_echipa = (
    select id_echipa
    from echipa
    where denumire_echipa = 'Steaua Bucuresti'
);
delete from jucator
where id_echipa = (
    select id_echipa
    from echipa
    where denumire_echipa = 'Steaua Bucuresti'
);


--13: 2: Stergerea partidelor care au avut ca numar de spectatori mai putin de 1500 de spectatori.
delete from partida
where id_partida in (
    select id_partida
    from partida
    where numar_spectatori < 1500
);


--13: 3: Daca o arena nu are capacitate, sa se actualizeze cu valoarea 200.
update arena
set capacitate = 200
where id_arena in (
  select id_arena
  from arena
  where capacitate is null
);



