       identification division.
       program-id.  Check_Box.
       date-written.  8-July-95

      * Copyright (c) 1996-2010 by Micro Focus. Users of ACUCOBOL-GT
      * may freely modify and redistribute this program.

       remarks.
           This program illustrates the CHECK BOX control type.
      *************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       copy "def/acucobol.def".
       copy "def/acugui.def".

       77  large-font          handle of font.
       77  option-1            pic 9 value zeros.
       77  option-2            pic 9 value zeros.
       77  option-3            pic 9 value zeros.
       77  option-4            pic 9 value zeros.
       77  draw-line           pic x(45) value
           "__________________________________________".

      * Working storage items added for calculations.
       77 total                pic s9(9)v9(2) value 12500.
       77 formatted-total      pic $ZZZ,ZZZ.9(2).

       77  key-status
                is SPECIAL-NAMES  CRT STATUS    pic 9(4).
                88  exit-button-pushed          value 13.
      *************************************************
       screen section.
       01  screen-1.
           03  PUSH-BUTTON, "Sair",   ok-button,
                      line 20, column 23,
                                      font large-font,  size 11.

      *                        Utilize SIZE 12 para definir o tamanho de cada
      *                        um dos labels numericos. Cada Label numerico vai 
      *                        assim um tamanho diferente com base no
      *                        tamanhjjo do titulo, se SIZE nao for especificado.
           03  LABEL, "Preco Base",   line 3,  column 5.
           03  LABEL, " $ 12,500.00", RIGHT,
                                      size 12,
                      line 3,  column 31.

           03  LABEL, draw-line,      line + 1, column 5.

           03  LABEL, "Opcoes:",     line + 1, column 5.
           03  CHECK-BOX, "Teto Solar",  line + 2, column 8,
                                      NOTIFY,
                                      using option-1.
           03  LABEL, "+400.00",  RIGHT,
                                      size 12,
                      column 31.
           03  CHECK-BOX, "Ar Condicionado",
                                      line + 2, column 8,
                                      NOTIFY,
                                      using option-2.
           03  LABEL, "+1,100.00",  RIGHT,
                                      size 12,
                      column 31.
           03  CHECK-BOX, "Freio ABS",
                                      line + 2, column 8,
                                      NOTIFY,
                                      using option-3.
           03  LABEL, "+650.00",  RIGHT,
                                      size 12,
                      column 31.
           03  CHECK-BOX, "Transmicao Manual",
                                      line + 2,  column 8,
                                      NOTIFY,
                                      using option-4.
           03  LABEL, "-300.00",  RIGHT,
                                      size 12,
                      column 31.

           03  LABEL, draw-line,      line + 1, column 5.

           03  LABEL, "TOTAL",        line + 2, column 5.
           03  LABEL,                 FROM formatted-total,
                                      RIGHT
                                      size 12,
                      column 31.
      *************************************************
       procedure division.
       main-logic.

      *    Modifica a fonte para LARGE
           accept large-font from standard object "large-font".

      *    Configura o background da tela na cor cinza
           display standard window,
               title "Exemplo de Check Box - checkbox.cbl",
               lines 23, size 50,
               background-low.

           perform until exit-button-pushed
                move 12500 to total
                if option-1 = 1
                   compute total = total + 400
                end-if
                if option-2 = 1
                   compute total = total + 1100
                end-if
                if option-3 = 1
                   compute total = total + 650
                end-if
                if option-4 = 1
                   compute total = total - 300
                end-if
                move total to formatted-total
                display screen-1
                accept screen-1
           end-perform.
           stop run.
