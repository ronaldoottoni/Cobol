* Consulta UNIDdes
 identification division.
 program-id. BROSQL.
 author. RONALDO OTTONI.
 environment division.
 configuration section.
 file-control.
*
 data division.
 file section.
*

 Working-storage section.
*
 copy "..\copy\acucobol.def".
 COPY "..\copy\acugui.def".
 COPY "..\copy\fonts.def".
 COPY "..\copy\crtvars.def".
 COPY "..\copy\Winprint.def".
 Copy "..\Copy\ShowMSG.DEF".

 01  Ws-Procura       Pic x(055) Value spaces.
 01  Salva-Procura    Pic x(055) Value spaces.

 01 Visivel           Pic 9 Value 1.
   88 Visivel-l       Value 1 false 0.

 77  grid-y                      pic 99    value 0.
 77  grid-x                      pic 99    value 0.

 01  Registro.
     03 rUNID-CODI               Pic x(010).
     03 rUNID-NOME               Pic x(020).
     03 rUNID-SENH               Pic x(010).


 77  default-font                handle of font default-font.
 77  janela                      handle of window.

 01 ws-linha                     pic s9(04) comp value zeros.
 01 ws-coluna                    pic s9(04) comp value zeros.
 01 ws-linha-comeco              pic 99.
 01 ws-linha-fim                 pic 99.
 01 ws-pri                       pic x value "S".

 01  key-press is special-names crt status pic 9(4) value 0.
     88  abort-key               value 27.
     88  return-key              value 13.
     88  Up-key                  value 52.
     88  Down-key                value 53.
     88  Ocorreu-Evento          value 96.
     88  pgup                    value 67.
     88  pgdwn                   value 68.
     88  Ctrl-Home               Value 56.
     88  Ctrl-End                Value 57.
     88  F6-KEY                  Value 6.
 01  Registros                   Pic 9(004) Value Zeros.

* Variaveis para Controle da Matriz para Browse
 01 M1-CONT                      PIC  9(002) VALUE  01.
 01 M2-CONT                      PIC  9(002) VALUE  01.
 01 MATRIZ OCCURS 12.
    03 mtUNID-Codi               Pic x(010).
    03 mtUNID-NOME               Pic x(020).
    03 mtUNID-SENH               Pic x(010).

 01 AXMATR OCCURS 12.
    03 mxUNID-Codi              Pic x(010).
    03 mxUNID-NOME              Pic x(020).
    03 mxUNID-SENH              Pic x(010).

 01 OLD-USUARIOS.
    03 OLD-USUA_CODI PIC 9(010).
    03 OLD-USUA_NOME PIC X(020).
    03 OLD-USUA_SENH PIC X(010).

 01  KEYMAP-OPERATIONS.
     03  SAVE-KEYMAP            PIC 9 VALUE 1.
     03  RESTORE-KEYMAP         PIC 9 VALUE ZERO.

           EXEC SQL INCLUDE SQLCA END-EXEC.
           EXEC SQL BEGIN DECLARE SECTION END-EXEC.
           01 WS-USUARIOS.
              03 USUA_CODI PIC 9(010).
              03 USUA_NOME PIC X(020).
              03 USUA_SENH PIC X(010).
           EXEC SQL END DECLARE SECTION END-EXEC.

 Linkage section.

 Screen section.
 01 Janela-grid.
    03 grid-1, grid,
        3-d,
        line 1.5, col 1.5,
        size 51.8 CELLS,
        lines 13,
        color 514,
        display-columns    = ( 1, 11, 25)
        alignment          = ("L","L","L")
        row-dividers       = 1
        cursor-frame-width = -1
        cursor-color = 80
        vpadding = 50
        use-tab
        column-headings
        heading-color = 144
        tiled-headings
        centered-headings
        Id 01
        | virtual-width = 124
        | hscroll
        | paged
        event procedure is grid-1-event.

 01 Janela-Procura.
    05 LABEL "Procure Por: " Line 19.5, Col 2,
       ID = 001.
    05 PROCURA ENTRY-FIELD USING WS-PROCURA
       Line   19.5, Col + 2,
       Lines   1.00, Size   20.00,
       ID = 002
       After Verifica-Tecla,
       Right, Upper
       3-D.
    05 LABEL "F6 Inclui" Line 19.5, Col + 10,
       ID = 003
       Visible = Visivel.

 Procedure Division Using Lk-Linkage, Codigo, Inclui.
 main-logic.
     Move Spaces to Titulo.
     Move "BROSQL"  To WS-PROG
     Move  80       To WS-COL-SCREEN
     Display Titulo UPON GLOBAL WINDOW TITLE.

     Display Floating Window,
             Title "BROWSE COM SQL",
             System Menu, Title-Bar,
             Size 53, Lines 20.5,
             Cell Height 15
             Cell Width   9
             Modeless Bind To Thread,
             Pop-Up Janela.

     Display Janela-grid.

     EXEC SQL WHENEVER SQLERROR GOTO ERROR-EXIT END-EXEC.
     EXEC SQL
          DECLARE CUR1 CURSOR FOR
                  SELECT * FROM Campo.Login
     END-EXEC
     EXEC SQL CONNECT TO "RONALDO" END-EXEC.
     EXEC SQL OPEN CUR1 END-EXEC.
     Perform Carrega-Matriz Thru Carrega-Matriz-Exit.
     Perform Move-Matriz    Thru Move-Matriz-Exit.
     Go Tratamento-Grid.

 Carrega-Matriz.
     EXEC SQL
          FETCH CUR1 INTO :WS-USUARIOS
     END-EXEC.
     Display Message Box "SQLSTATE: "SQLCODE OF SQLCA
     If ws-pri = "S"
        Move WS-USUARIOS To OLD-USUARIOS
        Move "N" To ws-pri
     Else
        If WS-USUARIOS Equal OLD-USUARIOS
           Go Carrega-Matriz-Exit
        Else
           Move WS-USUARIOS To OLD-USUARIOS
        End-If
     End-If
     If USUA_CODI Not = Zeros
        Move USUA_CODI To mtUNID-Codi(M1-CONT)
        Move USUA_NOME To mtUNID-NOME(M1-CONT)
        Move USUA_SENH To mtUNID-SENH(M1-CONT)
        Add 1 To M1-CONT
        IF M1-Cont Greater 12
           Perform Carrega-Matriz-Exit
        End-If
        Go Carrega-Matriz
     Else
        Perform Carrega-Matriz-Exit
     End-If.

 Carrega-Matriz-Exit.
     EXEC SQL CLOSE CUR1 END-EXEC.
     Exit.

 Move-Matriz.
     Modify grid-1 Reset-Grid = 1
     Modify Grid-1 Mass-Update = 1
     Modify Grid-1 x = 1, y = 1 cell-data = "Cod.".
     Modify Grid-1 x = 2, y = 1 cell-data = "Nome".
     Modify Grid-1 x = 2, y = 1 cell-data = "Senha".
     Move spaces to registro.
     Move Zeros To M2-Cont.
     Move 1 TO M1-Cont.
     Move 2 To Registros.

 Loop-Matriz.
     If mtUNID-Codi(m1-cont) = Spaces And M2-Cont Equal Zeros
        Move Registros To M2-CONT
     End-If
     Modify Grid-1 x = 1, y = Registros cell-data = mtUNID-Codi(M1-CONT)
     Modify Grid-1 x = 2, y = Registros cell-data = mtUNID-NOME(M1-CONT)
     Modify Grid-1 x = 3, y = Registros cell-data = mtUNID-SENH(m1-CONT)
     If mtUNID-nome(m1-cont) not equal spaces
        move mtUNID-nome(m1-cont) to salva-procura
     End-if
     Add 1 To M1-Cont Registros
     If M1-Cont > 12
        Go End-Move-Matriz
     End-If
     Go Loop-Matriz.

 End-Move-Matriz.
     If M2-Cont Greater Zeros
        Move M2-Cont To Registros
     Else
        Move 2 To Registros
     End-If
     Perform Selecao-Linha
     Modify Grid-1 Mass-Update = 0.

 Move-Matriz-Exit. Exit.

 Move-Para-Baixo
     Move mtUNID-Codi(M1-CONT) to mxUNID-Codi(M1-CONT).
     Move mtUNID-NOME(M1-CONT) to mxUNID-NOME(M1-CONT).
     Move mtUNID-SENH(M1-CONT) to mxUNID-SENH(M1-CONT).
     Add 1 To M1-Cont.
     If M1-Cont Less 13
        Go Move-Para-Baixo
     End-If.
     Move 2 TO M1-CONT
     Move 1 TO M2-CONT.
 Loop-Move-Baixo.
     Move mxUNID-Codi(M1-CONT) To mtUNID-Codi(M2-CONT).
     Move mxUNID-NOME(M1-CONT) To mtUNID-NOME(M2-CONT).
     Move mxUNID-SENH(M1-CONT) To mtUNID-SENH(M2-CONT).
     Add 1 To m1-Cont m2-Cont
     If M1-Cont Less 13
        Go Loop-Move-Baixo
     End-If
     Move USUA_CODI to mtUNID-Codi(12)
     Move USUA_NOME to mtUNID-NOME(12)
     Move USUA_SENH to mtUNID-SENH(12)
     Perform Move-Matriz Thru Move-Matriz-Exit
     Move 1 to M1-CONT.
 Move-Para-Baixo-Exit. Exit.

 Move-Para-Cima
     Move mtUNID-Codi(M1-CONT) to mxUNID-Codi(M1-CONT).
     Move mtUNID-NOME(M1-CONT) to mxUNID-NOME(M1-CONT).
     Move mtUNID-SENH(M1-CONT) to mxUNID-SENH(M1-CONT).
     Add 1 To M1-Cont.
     If M1-Cont Less 13
        Go Move-Para-Cima
     End-If.
     Move 1 TO M1-CONT
     Move 2 TO M2-CONT.
 Loop-Move-Cima.
     Move mxUNID-Codi(M1-CONT) To mtUNID-Codi(M2-CONT).
     Move mxUNID-NOME(M1-CONT) To mtUNID-NOME(M2-CONT).
     Move mxUNID-SENH(M1-CONT) To mtUNID-SENH(M2-CONT).
     Add 1 To m1-Cont m2-Cont
     If M1-Cont Less 12
        Go Loop-Move-Cima
     End-If
     Move USUA_CODI To mtUNID-Codi(01)
     Move USUA_NOME To mtUNID-NOME(01)
     Move USUA_SENH To mtUNID-SENH(01)
     Perform Move-Matriz Thru Move-Matriz-Exit
     Move 1 To M1-CONT.
 Move-Para-Cima-Exit. Exit.

 Tratamento-Grid.
     Move 2 To Registros
     Perform selecao-linha
     Perform until abort-key
       Display Janela-Grid
       Move Zeros To Key-Press
       Accept Janela-Procura Before Time Tempo-Accept
              Allowing Messages From Thread-Escolha
              On exception Perform verifica-tecla
       End-Accept
       If Key-Press = 99
          Set Abort-Key  To True
       End-if
       If Ocorreu-Evento
          If TU-Cmd-Close
             Exit Perform
          End-If
       End-If
       If Return-Key
          Subtract 1 From Registros
          If Registros < 1 Move 1 To Registros End-If
          Exit Perform
       End-If
     End-perform.
     Commit
     Close Window Janela.
     Destroy Janela.
     CALL "C$KEYMAP" USING RESTORE-KEYMAP.
     Exit Program.

 Verifica-Tecla.
     If pgup
        Move 1 To Accept-Control
        Perform 12 Times
          Perform Teclas-Acima
        End-Perform
     End-If
     If pgdwn
        Move 1 To Accept-Control
        Perform 12 Times
           Perform Teclas-Abaixo
        End-Perform
     End-If
     If Up-Key
        Move 1 To Accept-Control
        Perform Teclas-Acima
     End-If
     If Down-Key
        Move  1 To Accept-Control
        Perform Teclas-Abaixo
     End-If.

 Teclas-Acima.

 Teclas-Abaixo.

 grid-1-Event.
     evaluate event-type
         when msg-paged-next
              move 53 to key-press
              Perform Verifica-Tecla
         when msg-paged-prev
              move 52 to key-press
              Perform Verifica-Tecla
         when msg-paged-nextpage
              move 68 to key-press
              Perform Verifica-Tecla
         when msg-paged-prevpage
              move 67 to key-press
              Perform Verifica-Tecla
         when msg-begin-entry
              set event-action to event-action-fail
         when msg-finish-entry
              continue
         when msg-goto-cell-mouse
              inquire grid-1, x in grid-x, y in grid-y
              Move Grid-y To Registros
              perform selecao-linha
         when msg-goto-cell
              inquire grid-1, x in grid-x, y in grid-y
              Compute registros = Grid-y - 1
              perform selecao-linha
         when other
              Move Zeros To Key-Press
              set event-action to event-action-fail
     end-evaluate.

 selecao-linha.
        move 3 to ws-linha-comeco
        move 1 to ws-linha-fim
        Move registros to ws-linha
        if ws-linha < 2 Move 2 To ws-linha.
        modify grid-1
          start-y ws-linha
          y       ws-linha
          start-x ws-linha-comeco
          x       ws-linha-fim
          region-color bckgrnd-YELLOW.
        Display Janela-Grid.

 Limpa-Matrizes.
     Move Spaces To mtUNID-Codi(M1-CONT).
     Move Spaces To mtUNID-NOME(M1-CONT).
     Move Spaces To mtUNID-SENH(M1-CONT).
     Move Spaces To mxUNID-Codi(M1-CONT).
     Move Spaces To mxUNID-NOME(M1-CONT).
     Move Spaces To mxUNID-SENH(M1-CONT).
     Add 1 To M1-CONT.
     If M1-Cont Less 13 Go Limpa-Matrizes.

 CONFIGURA-TECLADO.
*     set environment "KEYSTROKE" to "Terminate=013 ^M"
*                     "KEYSTROKE" to "Exception=067 kP"
*                     "KEYSTROKE" to "Exception=068 kN"
*                     "KEYSTROKE" to "Exception=030 KC"
*                     "KEYSTROKE" to "Exception=031 kE"
*                     "KEYSTROKE" to "Terminate=056 KT"
*                     "KEYSTROKE" to "Terminate=057 KB".

 ERROR-EXIT.
    EXEC SQL WHENEVER SQLERROR CONTINUE END-EXEC.
    Display Message Box
       "SQL Error !"NEWLINE
       "       SQLCODE: "SQLCODE OF SQLCA NEWLINE
       "       SQLSTATE: "SQLSTATE OF SQLCA NEWLINE
       "       SQLERRMC: "SQLERRMC OF SQLCA NEWLINE
       NEWLINE
       "Program Aborting.".
    EXEC SQL DISCONNECT ALL END-EXEC.
    STOP RUN.
