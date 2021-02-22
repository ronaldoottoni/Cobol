IDENTIFICATION DIVISION.
PROGRAM-ID.  MileageCounter.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 Counters.
   02 CentenasCount          PIC 99 VALUE ZEROS.
   02 DezenasCount           PIC 99 VALUE ZEROS.
   02 UnidadesCount          PIC 99 VALUE ZEROS.

01 DisplayItems.
   02 PrnCentenas            PIC 9.
   02 PrnDezenas             PIC 9.
   02 PrnUnidades            PIC 9.

PROCEDURE DIVISION.
Begin.
   DISPLAY "Utilizando um Perform out-of-line, sem aninhamento".
   DISPLAY "Iniciando a simulação do contador de quilometragem".
   PERFORM CountMilage
      VARYING CentenasCount FROM 0 BY 1 UNTIL CentenasCount > 1
      AFTER   DezenasCount FROM 0 BY 1 UNTIL DezenasCount > 1
      AFTER   UnidadesCount FROM 0 BY 1 UNTIL UnidadesCount > 1
   DISPLAY "Final da simulação do contador de quilometragem."

   DISPLAY "Using Peforms in-line, aninhados"
   DISPLAY "Iniciando a simulação do contador de quilometragem".
   PERFORM VARYING CentenasCount FROM 0 BY 1 UNTIL CentenasCount > 1
     PERFORM VARYING DezenasCount FROM 0 BY 1 UNTIL DezenasCount > 1
        PERFORM VARYING UnidadesCount FROM 0 BY 1 UNTIL UnidadesCount > 1
           MOVE CentenasCount TO PrnCentenas
           MOVE DezenasCount  TO PrnDezenas
           MOVE UnidadesCount TO PrnUnidades
           DISPLAY PrnCentenas "-" PrnDezenas "-" PrnUnidades
        END-PERFORM
     END-PERFORM
   END-PERFORM.
   DISPLAY "Final da simulação do contador de quilometragem."
   STOP RUN.


CountMilage.
   MOVE CentenasCount TO PrnCentenas
   MOVE DezenasCount  TO PrnDezenas
   MOVE UnidadesCount TO PrnUnidades
   DISPLAY PrnCentenas "-" PrnDezenas "-" PrnUnidades.
