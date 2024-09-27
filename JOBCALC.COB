       PROGRAM-ID. JOBCALC.
       ENVIRONMENT DIVISION.                         
       CONFIGURATION SECTION.
       SPECIAL-NAMES.                                
           DECIMAL-POINT                IS COMMA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  WS-TABELA.
           05  WS-EXPRESSION            PIC  X(050)        VALUE SPACES.
           05  WS-BLANK-COUNT           PIC  9(004)        COMP.
           05  WS-TAM                   PIC  9(003)        VALUE ZEROS.
           05  WS-SUB-EXPRESS           PIC  X(050)        VALUE SPACES.
           05  WS-SUB-TAM               PIC  9(003)        VALUE ZEROS.
           05  WS-NEW-EXPRESS           PIC  X(050)        VALUE SPACES.
           05  WS-QTDE-ESP              PIC  9(003).
           05  WL-EXPRESSION            PIC  X(050).
           05  WL-OPERATION             PIC  X(001).
           05  WL-RESULT                PIC S9(012)V9(005).
           05  WL-TEXT                  PIC  X(512).
           05  WL-TEXT-RETORNO          PIC  X(512).

           05  WS-POSITION.
                10 WS-POSI-INI          PIC  9(004).
                10 WS-POSI-FIN          PIC  9(004).

           05 WS-CALC.
              10 WS-NUMBER-1            PIC S9(006)V99999.
              10 WS-NUMBER-2            PIC S9(006)V99999.
              10  WS-RESULT          PIC S9(006)V99999.
              10  WX-RESULT          PIC -ZZZZZ9,9999 BLANK ZEROS.

            05 WS-NUMBERS               OCCURS 050.
               10 WS-NUMBER             PIC S9(006)V99999.

            05 WS-OPERADORES            OCCURS 050.
               10 WS-OPERAND            PIC  X(001).

            05 WS-VALORES               OCCURS 050.
               10 WS-VALOR              PIC S9(006)V99999.

            05 WS-NIVEIS.
               10 WS-NIVEL              PIC  X(001)        VALUE SPACE.
               10 WS-NVL-INI            PIC  9(003)        VALUE ZEROS.
               10 WS-NVL-TAM            PIC  9(003)        VALUE ZEROS.

       01  AC-ACUMULADORES.
           05  AC-IDX                   PIC  9(003)        VALUE ZEROS.
           05  AC-IDX-2                 PIC  9(003)        VALUE ZEROS.
           05  AC-IDX-3                 PIC  9(003)        VALUE ZEROS.
           05  AC-IDX-NUM               PIC  9(003)        VALUE ZEROS.
           05  AC-IDX-OPE               PIC  9(003)        VALUE ZEROS.
           05  AC-IDX-AUX               PIC  9(003)        VALUE ZEROS.
           05  AC-IDX-NVL               PIC  9(003)        VALUE ZEROS.
           05  AC-ULT-IDX               PIC  9(003)        VALUE ZEROS.
           05  AC-IDX-RET               PIC  9(003)        VALUE ZEROS.                          

       PROCEDURE DIVISION.

       010-START.
           MOVE "25+10-((2*5)/3)+15+(1*2)+1" 
                                       TO WL-EXPRESSION
           MOVE "1"                     TO WL-OPERATION.

       011-DIRECTION.
           IF WL-OPERATION = "1"
              MOVE WL-EXPRESSION         TO WS-EXPRESSION
              PERFORM 015-EXPRESSION-CALCULATE
           END-IF

           GO 990-EXIT-PROGRAM.

       015-EXPRESSION-CALCULATE.
           MOVE ZEROS TO WS-BLANK-COUNT
           INSPECT FUNCTION REVERSE (WS-EXPRESSION) 
                   TALLYING WS-BLANK-COUNT FOR LEADING SPACES

           COMPUTE WS-TAM = 50 - WS-BLANK-COUNT

           MOVE "N"                TO WS-NIVEL.

           PERFORM 800-LEVEL-VERIFY.

           IF  WS-NIVEL = "S"
               MOVE WS-EXPRESSION(WS-NVL-INI + 1:WS-NVL-TAM - 2)
                                       TO WS-SUB-EXPRESS

               PERFORM 800-EXPRESSION-CALC
               MOVE WS-RESULT                 TO WX-RESULT

               MOVE SPACES      TO WS-NEW-EXPRESS
               MOVE SPACES      TO WS-EXPRESSION(WS-NVL-INI :WS-NVL-TAM)
               STRING  WS-EXPRESSION(1:WS-NVL-INI - 1)
                       WX-RESULT DELIMITED BY SIZE
                       WS-EXPRESSION(WS-NVL-INI + WS-NVL-TAM:)
                       DELIMITED BY " " INTO WS-NEW-EXPRESS
               END-STRING

               MOVE WS-NEW-EXPRESS      TO WL-TEXT
               PERFORM 800-SPACE-REMOVE
               MOVE WL-TEXT-RETORNO  
                                        TO WS-EXPRESSION

               GO 015-EXPRESSION-CALCULATE
           END-IF

           MOVE WS-EXPRESSION            TO WS-SUB-EXPRESS
           PERFORM 800-EXPRESSION-CALC
           MOVE WS-RESULT         TO WL-RESULT
                                        WX-RESULT.

       800-LEVEL-VERIFY.
           INITIALIZE AC-IDX-NVL
           PERFORM VARYING AC-IDX FROM 1 BY 1 UNTIL AC-IDX > WS-TAM
               IF WS-EXPRESSION(AC-IDX:1) = "("
                  MOVE "S"           TO WS-NIVEL
                  MOVE AC-IDX        TO WS-NVL-INI
               END-IF
               IF WS-EXPRESSION(AC-IDX:1) = ")"
                  COMPUTE WS-NVL-TAM = AC-IDX - WS-NVL-INI + 1
                  EXIT PERFORM
               END-IF
           END-PERFORM.

       800-EXPRESSION-CALC.
           MOVE ZEROS              TO WS-BLANK-COUNT
           
           INSPECT FUNCTION REVERSE (WS-SUB-EXPRESS) 
                   TALLYING WS-BLANK-COUNT FOR LEADING SPACES
           
           COMPUTE WS-SUB-TAM = 50 - WS-BLANK-COUNT.
       
      
           MOVE ZEROS           TO WS-POSITION
                                   AC-IDX-NUM
                                   AC-IDX-2
                                   AC-IDX-OPE
                                   WS-POSI-INI
                                   WS-POSI-FIN

           PERFORM VARYING AC-IDX-2 FROM 1 BY 1 
             UNTIL AC-IDX-2 > WS-SUB-TAM
               IF  WS-SUB-EXPRESS(AC-IDX-2:1) IS NUMERIC OR
                   WS-SUB-EXPRESS(AC-IDX-2:1) = "," OR
                   WS-SUB-EXPRESS(AC-IDX-2:1) = "."
                   IF WS-POSI-INI = ZEROS
                     MOVE AC-IDX-2      TO WS-POSI-INI
                   END-IF
                   ADD 1                TO WS-POSI-FIN
               END-IF

               IF  WS-SUB-EXPRESS(AC-IDX-2:1) = "+" OR "-" OR "*" OR "/"
                   ADD 1                TO AC-IDX-NUM
                   MOVE FUNCTION 
                        NUMVAL(WS-SUB-EXPRESS(WS-POSI-INI:WS-POSI-FIN))
                                        TO WS-NUMBER(AC-IDX-NUM)
                   MOVE ZEROS           TO WS-POSITION
                   ADD 1                TO AC-IDX-OPE
                   MOVE WS-SUB-EXPRESS(AC-IDX-2:1)
                                        TO WS-OPERAND(AC-IDX-OPE)
               END-IF
           END-PERFORM.

           IF  WS-SUB-EXPRESS(WS-POSI-INI:1) IS NUMERIC OR
               WS-SUB-EXPRESS(WS-POSI-INI:1) = "," OR
               WS-SUB-EXPRESS(WS-POSI-INI:1) = "."
               ADD 1                    TO AC-IDX-NUM
               MOVE FUNCTION 
                    NUMVAL(WS-SUB-EXPRESS(WS-POSI-INI:WS-POSI-FIN))
                                        TO WS-NUMBER(AC-IDX-NUM)
               MOVE ZEROS               TO WS-POSITION
           END-IF.
           
           IF AC-IDX-OPE NOT > 0
              EXIT PARAGRAPH
           END-IF

           
           MOVE ZEROS TO AC-IDX-AUX
           PERFORM VARYING AC-IDX-2 FROM 1 BY 1 
             UNTIL AC-IDX-2 > AC-IDX-OPE
               IF WS-OPERADORES(AC-IDX-2) = SPACES
                  EXIT PERFORM
               END-IF
               IF WS-OPERADORES(AC-IDX-2) = "*" OR "/"
                  MOVE WS-NUMBERS(AC-IDX-2)     TO WS-NUMBER-1
                  MOVE WS-NUMBERS(AC-IDX-2 + 1) TO WS-NUMBER-2
                  EVALUATE WS-OPERADORES(AC-IDX-2)
                   WHEN "*"
                       ADD 1 TO AC-IDX-AUX
                       
                       MULTIPLY WS-NUMBER-1 BY WS-NUMBER-2 
                         GIVING WS-RESULT
                   WHEN "/"
                       ADD 1 TO AC-IDX-AUX
                       
                       DIVIDE WS-NUMBER-1 BY WS-NUMBER-2 
                       GIVING WS-RESULT
                  END-EVALUATE
                  MOVE WS-RESULT TO WS-VALOR(AC-IDX-AUX)
                                       WS-NUMBERS(AC-IDX-2)
                  MOVE ZEROS        TO WS-NUMBERS(AC-IDX-2 + 1)
                  MOVE SPACES       TO WS-OPERADORES(AC-IDX-2)
                  PERFORM 800-MOVE-ELEMENTS
                  SUBTRACT 1 FROM AC-IDX-2
               END-IF
           END-PERFORM.


           PERFORM VARYING AC-IDX-2 FROM 1 BY 1 
             UNTIL AC-IDX-2 > WS-SUB-TAM
               IF WS-OPERADORES(AC-IDX-2) = "+" OR "-"
                  MOVE WS-NUMBERS(AC-IDX-2)     TO WS-NUMBER-1
                  MOVE WS-NUMBERS(AC-IDX-2 + 1) TO WS-NUMBER-2
                  EVALUATE WS-OPERADORES(AC-IDX-2)
                     WHEN "+"
                          ADD 1 TO AC-IDX-AUX
                          COMPUTE WS-RESULT = WS-NUMBER-1 + 
                                                 WS-NUMBER-2
                     WHEN "-"
                          ADD 1 TO AC-IDX-AUX
                          COMPUTE WS-RESULT = WS-NUMBER-1 - 
                                                 WS-NUMBER-2
                  END-EVALUATE
                  MOVE WS-RESULT TO WS-VALOR(AC-IDX-AUX)
                                       WS-NUMBERS(AC-IDX-2 + 1)
                  MOVE ZEROS        TO WS-NUMBERS(AC-IDX-2)
               END-IF
           END-PERFORM.

       800-MOVE-ELEMENTS.
           PERFORM VARYING AC-IDX-3 FROM 1 BY 1 
             UNTIL AC-IDX-3 > WS-TAM
               IF WS-NUMBER(AC-IDX-3) = ZEROS
                  MOVE WS-NUMBER(AC-IDX-3 + 1 ) 
                                        TO WS-NUMBER(AC-IDX-3)
                  MOVE ZEROS            TO WS-NUMBER(AC-IDX-3 + 1)
               END-IF
           END-PERFORM.
           PERFORM VARYING AC-IDX-3 FROM 1 BY 1 UNTIL AC-IDX-3 > WS-TAM
               IF WS-OPERAND(AC-IDX-3) = SPACES
                  MOVE WS-OPERAND(AC-IDX-3 + 1)  
                                        TO WS-OPERAND(AC-IDX-3)
                  MOVE SPACES           TO WS-OPERAND(AC-IDX-3 + 1)
           END-PERFORM.
           
       800-SPACE-REMOVE.
           MOVE SPACES                  TO WL-TEXT-RETORNO
           PERFORM VARYING AC-IDX FROM 512 BY -1 UNTIL AC-IDX = ZEROS
               IF WL-TEXT(AC-IDX:1) NOT = SPACES 
                  EXIT PERFORM
               END-IF
           END-PERFORM
           MOVE AC-IDX                  TO AC-ULT-IDX
           MOVE ZEROS                   TO WS-QTDE-ESP
                                           AC-IDX-RET.
                                           
            PERFORM VARYING AC-IDX FROM 1 BY 1 UNTIL AC-IDX > AC-ULT-IDX
                IF WL-TEXT(AC-IDX:1) NOT = SPACES
                    ADD 1               TO AC-IDX-RET
                    MOVE WL-TEXT(AC-IDX:1)
                      TO WL-TEXT-RETORNO(AC-IDX-RET:1)
                END-IF
            END-PERFORM.
      
       990-EXIT-PROGRAM.
            DISPLAY WL-RESULT
           EXIT PROGRAM.
