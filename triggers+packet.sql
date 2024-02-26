CREATE OR REPLACE TRIGGER before_update_varsta_trigger
BEFORE UPDATE
ON JUCATOR
FOR EACH ROW
DECLARE
BEGIN
   IF :NEW.varsta <> :OLD.varsta THEN
      RAISE_APPLICATION_ERROR(-20001, 'Varsta jucatorului nu poate fi modificata.');
   END IF;
END;
/

UPDATE JUCATOR
SET varsta = varsta + 1
WHERE id_jucator = 1;


*EXERCITIUL 12

CREATE OR REPLACE TRIGGER NUMEUSER1.ddl_procedure_trigger
AFTER CREATE OR ALTER OR DROP ON SCHEMA
DECLARE
  v_event_type     VARCHAR2(30);
  v_object_type    VARCHAR2(30);
  v_object_name    VARCHAR2(30);
BEGIN
  v_event_type := ora_sysevent;
  v_object_type := ora_dict_obj_type;
  v_object_name := ora_dict_obj_name;

  IF v_event_type = 'CREATE' AND v_object_type = 'FUNCTION' THEN
    DBMS_OUTPUT.PUT_LINE('Functia ' || v_object_name || ' a fost creata.');
  ELSIF v_event_type = 'CREATE' AND v_object_type = 'PROCEDURE' THEN
    DBMS_OUTPUT.PUT_LINE('Functia ' || v_object_name || ' a fost creata.');
  ELSIF v_event_type = 'ALTER' AND v_object_type = 'FUNCTION' THEN
    DBMS_OUTPUT.PUT_LINE('FUNCTION ' || v_object_name || ' a fost modificata.');
  ELSIF v_event_type = 'ALTER' AND v_object_type = 'PROCEDURE' THEN
    DBMS_OUTPUT.PUT_LINE('Procedura ' || v_object_name || ' a fost modificata.');
  ELSIF v_event_type = 'DROP' AND v_object_type = 'FUNCTION' THEN
    DBMS_OUTPUT.PUT_LINE('Functia ' || v_object_name || ' a fost stearsa.');
  ELSIF v_event_type = 'DROP' AND v_object_type = 'PROCEDURE' THEN
    DBMS_OUTPUT.PUT_LINE('Procedura ' || v_object_name || ' a fost stearsa.');
  END IF;
END;
/


*EXERCITIUL 13

CREATE OR REPLACE PACKAGE PACHET_BASCHET AS
  PROCEDURE afisare_statistici_echipa (id_echipa IN NUMBER);
  PROCEDURE raport_jucatori (id_echipa IN NUMBER);
  FUNCTION performanta_jucator (id_jucator_param IN NUMBER) RETURN VARCHAR2;
  PROCEDURE detalii_echipa (id_echipa_param IN NUMBER);
END PACHET_BASCHET;
/



CREATE OR REPLACE PACKAGE BODY PACHET_BASCHET AS 

--6
PROCEDURE afisare_statistici_echipa (
  id_echipa IN NUMBER
)
AS
  v_nume_echipa VARCHAR2(50);
  v_oras_echipa VARCHAR2(50);
  v_presedinte_echipa VARCHAR2(50);
  
  TYPE PuncteList IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  TYPE PaseTable IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  TYPE RecuperariTable IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  TYPE ScoruriVarray IS VARRAY(13) OF NUMBER;
  
  v_puncte PuncteList;
  v_asisturi PaseTable;
  v_recuperari RecuperariTable;
  v_scoruri ScoruriVarray;

BEGIN

  v_nume_echipa := NVL(v_nume_echipa, 'N/A');
  v_oras_echipa := NVL(v_oras_echipa, 'N/A');
  v_presedinte_echipa := NVL(v_presedinte_echipa, 'N/A');

  SELECT cosuri_3pct
  BULK COLLECT INTO v_puncte
  FROM PUNCTE
  WHERE id_echipa = id_echipa;

  SELECT numar_asisturi
  BULK COLLECT INTO v_asisturi
  FROM ASISTURI
  WHERE id_echipa = id_echipa;

  SELECT numar_recuperari
  BULK COLLECT INTO v_recuperari
  FROM RECUPERARI
  WHERE id_echipa = id_echipa;

  v_scoruri := ScoruriVarray(9.8, 9.3, 7.1, 8.3, 9.2, 7.8, 9.3, 7.2, 8.4, 8.8, 9.0, 7.4, 8.3);

  -- Afișarea punctelor
  FOR i IN v_puncte.FIRST..v_puncte.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('Cosuri 3 puncte jucator ' || i || ': ' || v_puncte(i));
  END LOOP;

  FOR i IN v_asisturi.FIRST..v_asisturi.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('Asisturi jucator ' || i || ': ' || v_asisturi(i));
  END LOOP;

  FOR i IN v_recuperari.FIRST..v_recuperari.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('Recuperari jucator ' || i || ': ' || v_recuperari(i));
  END LOOP;

  FOR i IN v_scoruri.FIRST..v_scoruri.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('Scor jucator ' || i || ': ' || v_scoruri(i));
  END LOOP;
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Echipa cu ID ' || id_echipa || ' nu există.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('O eroare necunoscută a apărut: ' || SQLERRM);
END;


--7
PROCEDURE raport_jucatori (
  id_echipa IN NUMBER
)
AS
  CURSOR cur_echipa IS
    SELECT denumire_echipa, oras
    FROM ECHIPA
    WHERE id_echipa = id_echipa;

  CURSOR cur_jucatori (id_echipa_param NUMBER) IS
    SELECT id_jucator, nume, prenume, varsta, nationalitate
    FROM JUCATOR
    WHERE JUCATOR.id_echipa = id_echipa_param;

  v_nume_echipa ECHIPA.denumire_echipa%TYPE;
  v_oras_echipa ECHIPA.oras%TYPE;
  v_id_jucator JUCATOR.id_jucator%TYPE;
  v_nume_jucator JUCATOR.nume%TYPE;
  v_prenume_jucator JUCATOR.prenume%TYPE;
  v_varsta JUCATOR.varsta%TYPE;
  v_nationalitate JUCATOR.nationalitate%TYPE;

BEGIN

  OPEN cur_echipa;
  FETCH cur_echipa INTO v_nume_echipa, v_oras_echipa;
  CLOSE cur_echipa;

  DBMS_OUTPUT.PUT_LINE('Raport pentru echipa ' || v_nume_echipa || ' din orasul ' || v_oras_echipa);
  DBMS_OUTPUT.PUT_LINE('----------------------------------------');

  OPEN cur_jucatori(id_echipa);
  LOOP
    FETCH cur_jucatori INTO v_id_jucator, v_nume_jucator, v_prenume_jucator, v_varsta, v_nationalitate;
    EXIT WHEN cur_jucatori%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('Jucator ' || v_nume_jucator || ' ' || v_prenume_jucator || ' (ID: ' || v_id_jucator || '):');
    DBMS_OUTPUT.PUT_LINE('  - Varsta: ' || v_varsta);
    DBMS_OUTPUT.PUT_LINE('  - Nationalitate: ' || v_nationalitate);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
  END LOOP;

  CLOSE cur_jucatori;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Echipa cu ID ' || id_echipa || ' nu exista.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('O eroare necunoscuta a aparut: ' || SQLERRM);
END;

--8

FUNCTION performanta_jucator (
  id_jucator_param IN NUMBER
) RETURN VARCHAR2
IS
  v_cursor SYS_REFCURSOR;
  v_id_jucator JUCATOR.id_jucator%TYPE;
  v_varsta_jucator JUCATOR.varsta%TYPE;
  v_oras ECHIPA.oras%TYPE;
  v_presedinte ECHIPA.nume_presedinte%TYPE;
  v_nume_jucator JUCATOR.nume%TYPE;
  v_nume_echipa ECHIPA.denumire_echipa%TYPE;
  v_prenume_jucator JUCATOR.prenume%TYPE;
  v_nationalitate_jucator JUCATOR.nationalitate%TYPE;
  v_cetatenie_jucator JUCATOR.cetatenie%TYPE;
  v_numar_asisturi ASISTURI.numar_asisturi%TYPE;
  v_asisturi_exception EXCEPTION;
  v_nationalitate_exception EXCEPTION;
  v_result VARCHAR2(4000); 

BEGIN


  OPEN v_cursor FOR
    SELECT JUCATOR.id_jucator, JUCATOR.varsta, JUCATOR.nume, JUCATOR.prenume, JUCATOR.nationalitate, JUCATOR.cetatenie, ASISTURI.numar_asisturi
    FROM JUCATOR
    LEFT JOIN ASISTURI ON JUCATOR.id_jucator = ASISTURI.id_jucator
    WHERE JUCATOR.id_jucator = id_jucator_param;

  FETCH v_cursor INTO v_id_jucator, v_varsta_jucator, v_nume_jucator, v_prenume_jucator, v_nationalitate_jucator, v_cetatenie_jucator, v_numar_asisturi;

  IF v_nationalitate_jucator = 'Argentinian' THEN
    RAISE v_nationalitate_exception;
  END IF;
  
  IF v_numar_asisturi > 130 THEN
    RAISE v_asisturi_exception;
  END IF;
  
  v_result := 'Jucator ID ' || v_id_jucator || ': ' || v_nume_jucator || ' ' || v_prenume_jucator ||
              ' - Nationalitate: ' || v_nationalitate_jucator || '; Cetatenie: ' || v_cetatenie_jucator ||
              '; Numar Asisturi: ' || v_numar_asisturi;

  CLOSE v_cursor;

  RETURN v_result;


  EXCEPTION
  WHEN v_asisturi_exception THEN
    v_result := 'Asisturile intrec suma de 2900.';
    RETURN v_result;
  WHEN v_nationalitate_exception THEN
    v_result := 'Nationalitatea jucatorului este Argentina.';
    RETURN v_result;
  WHEN OTHERS THEN
    v_result := 'O eroare necunoscută a aparut: ' || SQLERRM;
    RETURN v_result;
END performanta_jucator;


--9

PROCEDURE detalii_echipa (
  id_echipa_param IN NUMBER
)
IS
  v_rec_count NUMBER;
  v_excep_20001 EXCEPTION;
  v_excep_20002 EXCEPTION;
  v_excep_20003 EXCEPTION;
  v_excep_20004 EXCEPTION;
  v_excep_20005 EXCEPTION;

BEGIN
  SELECT COUNT(*)
  INTO v_rec_count
  FROM (
    SELECT
      ECHIPA.id_echipa
    FROM ECHIPA
    WHERE ECHIPA.id_echipa = id_echipa_param
    AND ROWNUM <= 1
  );

  IF v_rec_count = 0 THEN
    RAISE NO_DATA_FOUND;
  END IF;

  IF v_rec_count > 1 THEN
    RAISE TOO_MANY_ROWS;
  END IF;

  FOR rec IN (
    SELECT
      ECHIPA.id_echipa,
      ECHIPA.denumire_echipa,
      ANTRENOR.nume_antrenor,
      ANTRENOR.prenume_antrenor,
      PARTIDA.id_partida,
      PARTIDA.data_partida,
      ARENA.denumire_arena,
      ARENA.capacitate,
      JUCATOR.nume AS nume_jucator,
      JUCATOR.prenume AS prenume_jucator
    FROM ECHIPA
    LEFT JOIN ANTRENOR ON ECHIPA.id_echipa = ANTRENOR.id_echipa
    LEFT JOIN ECHIPA_PARTIDA ON ECHIPA.id_echipa = ECHIPA_PARTIDA.id_echipa
    LEFT JOIN PARTIDA ON ECHIPA_PARTIDA.id_partida = PARTIDA.id_partida
    LEFT JOIN ARENA ON ECHIPA.id_arena = ARENA.id_arena
    LEFT JOIN JUCATOR ON ECHIPA.id_echipa = JUCATOR.id_echipa
    WHERE ECHIPA.id_echipa = id_echipa_param
    AND ROWNUM <= 1
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Detalii despre echipa cu ID ' || rec.id_echipa || ':');

    IF rec.denumire_echipa IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE('Denumire echipa: ' || rec.denumire_echipa);
    ELSE
      RAISE v_excep_20001;
    END IF;

    IF rec.nume_antrenor IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE('Antrenor: ' || rec.nume_antrenor || ' ' || rec.prenume_antrenor);
    ELSE
      RAISE v_excep_20002;
    END IF;

    IF rec.data_partida IS NOT NULL AND rec.data_partida < DATE '2024-01-01' THEN
      DBMS_OUTPUT.PUT_LINE('Partida ID ' || NVL(TO_CHAR(rec.id_partida), 'N/A') || ': Data partida: ' || TO_CHAR(NVL(rec.data_partida, SYSDATE), 'YYYY-MM-DD'));
    ELSE
      RAISE v_excep_20003;
    END IF;


    IF rec.denumire_arena IS NOT NULL AND rec.capacitate IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE('Arena: ' || rec.denumire_arena || ', Capacitate: ' || rec.capacitate);
    ELSE
      RAISE v_excep_20004;
    END IF;


    IF rec.nume_jucator IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE('Jucator: ' || NVL(rec.nume_jucator, 'N/A') || ' ' || NVL(rec.prenume_jucator, 'N/A'));
    ELSE
      RAISE v_excep_20005;
    END IF;

  END LOOP;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Echipa cu ID-ul specificat nu se afla in baza de date.');
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Prea multe inregistrari gasite pentru echipa cu ID-ul specificat.');
  WHEN v_excep_20001 THEN
    DBMS_OUTPUT.PUT_LINE('Numele echipei nu poate fi NULL.');
  WHEN v_excep_20002 THEN
    DBMS_OUTPUT.PUT_LINE('Numele antrenorului nu poate fi NULL.');
  WHEN v_excep_20003 THEN
    DBMS_OUTPUT.PUT_LINE('Data partidei nu poate fi NULL sau trebuie sa fie dupa 2024-01-01.');
  WHEN v_excep_20004 THEN
    DBMS_OUTPUT.PUT_LINE('Numele sau capacitatea arenei nu pot fi NULL.');
  WHEN v_excep_20005 THEN
    DBMS_OUTPUT.PUT_LINE('Numele jucatorului nu poate fi NULL.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('O eroare necunoscuta a apărut: ' || SQLERRM);
END detalii_echipa;

END PACHET_BASCHET;
/

