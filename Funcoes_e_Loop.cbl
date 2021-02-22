            IDENTIFICATION DIVISION.
            PROGRAM-ID. LOOPS.
            DATA DIVISION.
              WORKING-STORAGE SECTION.
              01 WS-CNT PIC 9(1) VALUE 0.
              01 WS-A PIC 9 VALUE 0.
              01 WS-Z PIC 9 VALUE 2.
            PROCEDURE DIVISION.
              *> RODA A FUNCAO-A 3 VOZES
              PERFORM FUNCAO-A 3 TIMES.
              
              *> RODA FUNCAO-B CONTANDO A VARIAVEL WS-CNT
              *> COM INCREMENTO DENTRO DA FUNCAO 
              *> ATE SER MAIOR QUE 3
              PERFORM FUNCAO-B WITH TEST AFTER UNTIL WS-CNT > 3.
              
              *> RODANDO UM INTERVALO DE FUNCOES
              *> PASSANDO POR TODAS AS FUNCOES ENTRE A INICIAL E A
              *> FINAL (ATENÇÃO TODAS SÃO EXECUTADAS)
              PERFORM FUNCAO-C THRU FUNCAO-E.
              
              *> perform a varying style loop which specified
              *> a value to increment until it reaches some
              *> final
              PERFORM FUNCAO-F VARYING WS-A FROM 1 BY 1 UNTIL WS-A=5.
              DISPLAY 'WS-A APÓS VARIAR 'WS-A' VEZES'.
              
            STOP RUN.
              
            *> define paragraphs/functions that will
            *> be called in our loops above
            FUNCAO-A.
                DISPLAY 'DENTRO DA FUNCAO-A'.
            
            FUNCAO-B.
                DISPLAY 'WS-CNT : 'WS-CNT
                ADD 1 TO WS-CNT.
            
            FUNCAO-C.
                DISPLAY 'DENTRO DA FUNCAO-C'.
            
            FUNCAO-D.
                DISPLAY 'DENTRO DA FUNCAO-D'.
            
            FUNCAO-E.
                DISPLAY 'DENTRO DA FUNCAO-E'.
            
            FUNCAO-F.
                DISPLAY 'DENTRO DA FUNCAO-B ' WS-A.
