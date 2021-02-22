       identification division.
       program-id.  Radio_Button.
       date-written.  29-June-95

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       copy "def/acucobol.def".
       copy "def/acugui.def".

       77  large-font                           handle of font.

       77  key-status
           is special-names crt status          pic 9(4).
           88  exit-button-pushed               value 13.
       77  radio-button-data                    pic 9 value 0.
       77  radio-choice-field                   pic x(10).

       01  sabores.
           03  pic x(11) value "Chocolate".
           03  pic x(11) value "Baunilha".
           03  pic x(11) value "Morangoo".

       01  sabor redefines sabores
           occurs 3 times                       pic x(11).

       01  screen-control
           is special-names screen control.
           03  accept-control                   pic 9.
               88  continue-accept              value 1.
           03  control-value                    pic 999.

      *************************************************
       screen section.
       01  screen-1.
           03  FRAME,
               line 2, col 10,
               size 15, csize 17,
               lines 8, clines 9,
               alternate heavy rimmed.

           03  push-button, "Sair",
               ok-button, line 13, column 17, size 11.

           03  FRAME, line 5, col 28, size 15, lines 3.

           03  current-choice, LABEL, radio-choice-field,
               no-key-letter,
               line 6, col 29, size 12, CENTER.

           03  radio-button, title sabor(1)
               value radio-button-data,
               group-value=1,
               line 4 column 12
               no-group-tab
               notify
               exception disp-choice.

           03  radio-button, title sabor(2)
               value radio-button-data,
               column 12, line 6,
               group-value=2
               no-group-tab
               notify
               exception disp-choice.

           03  radio-button, title sabor(3)
               value radio-button-data,
               column 12, line 8,
               group-value=3
               no-group-tab
               notify
               exception disp-choice.

      *************************************************
       procedure division.
       main-logic.
      *    Grab the large fonts
           accept large-font from standard object "large-font".

      *    Setup a gray screen background
           display standard window,
               title "Exemplo Radio Button - radiobtn.cbl"
               lines 15, size 45, control font large-font
               background-low.

           display screen-1.
           perform until exit-button-pushed
               accept screen-1
           end-perform.
           stop run.

       disp-choice.
           if radio-button-data >= 1 and <= 3
               move sabor( radio-button-data ) to radio-choice-field
           end-if
           display current-choice
           set continue-accept to true.
