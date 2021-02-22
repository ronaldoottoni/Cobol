       identification division.
       program-id.  gridctl.
 
       environment division.
       data division.
       working-storage section.

      * Copybooks

       copy "def/acucobol.def".
       copy "def/acugui.def".
       copy "def/crtvars.def".
       copy "def/controls.def".
       copy "def/opensave.def".
       copy resource "littlegt.bmp".

      * Constants

       78  max-rows                          value 18.
       78  max-cols                          value 7.

      * Crt-Status

       77  key-status is special-names crt status pic 9(4) value 0.
         88  exit-pressed                    value 10.
         88  about-pressed                   value 15.
         88  exit-about-screen               value 201.

      * Handles

       77  window-0                          handle of window.
       77  window-1                          handle of window.
       77  about-thread                      handle of thread.
       77  grid-menu                         handle of menu.
       77  gt-bitmap                         pic s9(9) comp-4.

      * Data Items for Screen Handling

       77  ctr                               pic 99    value 0.
       77  grid-y                            pic 99    value 0.
         88 in-column-headings                         value 1.
       77  grid-x                            pic 99    value 0.
         88 in-row-headings                            value 1.
       77  bmp-num                           pic 99    value 0.
       77  scratch                           pic x(90) value spaces.

      * Grid Data

       01 grid-data-table.
         05 filler                           pic x(109)
           value "  CATEGORIA        AUTOR                  TITULO
      -    "                         EDITORA                 ANO".
         05 filler                           pic x(109)
           value "01Adventure       Fleming  Ian            On Her Majes
      -    "ty's Secret Service      New American Library      1963".
         05 filler                           pic x(109)
           value "02Art             CrespelleJean-Paul      Monet
      -    "                         Studio Editions           1993".
         05 filler                           pic x(109)
           value "03Biographical    Adamson  Joy            Born Free
      -    "                         Pantheon                  1960".
         05 filler                           pic x(109)
           value "04Children        Milne    A.A.           Winnie the P
      -    "ooh                      E.P. Dutton & Co., Inc    1956".
         05 filler                           pic x(109)
           value "05Fiction         Miller   Henry          Tropic of Ca
      -    "pricorn                  Grove Press               1961".
         05 filler                           pic x(109)
           value "06History         Durant   Will and Ariel The Age of N
      -    "apoleon                  Simon and Schuster        1975".
         05 filler                           pic x(109)
           value "07History         Stone    Irving         The Agony an
      -    "d the Ecstasy            Doubleday & Company, Inc  1958".
         05 filler                           pic x(109)
           value "08History         Tuchmann Barbara        The March of
      -    " Folly                   Alfred A. Knopf, Inc      1984".
         05 filler                           pic x(109)
           value "09Murder Mystery  Christie Agatha         Sleeping Mur
      -    "der                      The Haddon Craftsman, Inc 1976".
         05 filler                           pic x(109)
           value "10Reference       Matthews Peter          The Guinness
      -    " Book of Records 1996    Bantam Books              1997".
         05 filler                           pic x(109)
           value "11Science         Macauly  David          The Way Thin
      -    "gs Work                  Houghton Mifflin, Co      1988".
         05 filler                           pic x(109)
           value "12Science Fiction Crichton Michael        AirFrame
      -    "                         Alfred A. Knopf, Inc      1996".
         05 filler                           pic x(109)
           value "13Science Fiction Crichton Michael        Jurassic Par
      -    "k                        Signet Fiction            1994".
         05 filler                           pic x(109)
           value "14Science Fiction Niven    Larry          Ringworld
      -    "                         Ballantine Books          1970".
         05 filler                           pic x(109)
           value "15Science Fiction Verne    Jules          A Journey to
      -    " the Center of the Earth Signet Classic            1986".
         05 filler                           pic x(109)
           value "16Science Fiction Verne    Jules          20,000 Leagu
      -    "es Under the Sea         Signet Classic            1986".
         05 filler                           pic x(109)
           value "17Science Fiction Wells    H.G.           The Invisibl
      -    "e Man                    Signet Classic            1986".

       01 grid-data-tbl redefines grid-data-table.
         05 grid-record occurs max-rows times      pic x(109).
      *
       screen section.
       01 main-screen exception procedure exception-handler.
         03 grid-1, grid,
               line 2.5, col 2,
               size 75, lines 13,
               3-d,
               vscroll,
               data-columns       = ( 1, 3, 19, 28, 43, 80, 106)
               display-columns    = ( 1, 4, 20, 32, 50, 90, 119)
               alignment          = ("C","C","C","C","C","C")
               row-dividers       = (1,3)
               column-dividers    = (2,2,2,2,2,2)
               divider-color      = bright-red
               cursor-color       = 80
               heading-color      = 144
               cursor-frame-width = -1
               vpadding           = 50
               virtual-width      = 124
               hscroll
               adjustable-columns
               use-tab
               column-headings
               row-headings
               centered-headings
               tiled-headings
               pop-up menu          grid-menu
               event procedure is   grid-1-handler.

         05 about-pb, push-button,
               line 25, col 25,
               size 14 cells
               title "&About",
               self-act,
               exception-value    = 15.

         05 push-button,
               line 25, col 41,
               size 14 cells
               title "E&xit",
               self-act,
               exception-value    = 10.
      *
       01 about-screen exception exception-handler.
         05 comments-listbox, list-box,
               line + 1.5, column 2
               size 62, lines 14
               3-d,
               unsorted.

         05 push-button,
               line 16, col 26.5,
               title "E&xit",
               self-act,
               exception-value = 201.
      *
       procedure division.
       main-logic.
      *
           perform initialization.
           display standard graphical window,
                   title "Exemplo Grid - Gridctl.cbl",
                   size 80, lines 27, background-low
                   modeless, link to thread,
                   handle window-0.
      *
           call "w$bitmap" using wbitmap-load, "littlegt.bmp",
                giving gt-bitmap.

      *   O menu é um popup menu, ativado pelo clico do botao direito do mouse.
      *   Neste programa, você também pode ativar o meno clicando no logo animado.

           perform build-main-popup.
           move menu-handle to grid-menu.

           display main-screen.
           perform load-grid.
           perform thread animate-bitmap.

           perform, with test after, until exit-pressed
             accept main-screen on exception continue end-accept
           end-perform.

           stop run.

      *  Grids é carregado com o comando MODIFY.....RECORD-TO-ADD.
      *  Após carregar o grid, o cursor é colocado na celula 2,2
      *  porque o grid tem COLUMN-HEADINGS ocupando a linha 1, e
      *  ROW-HEADINGS ocupando coluna 1.

       load-grid.
           perform varying ctr from 1 by 1 until ctr > max-rows
             modify grid-1, record-to-add = grid-record(ctr)
           end-perform.

           modify grid-1, cursor-x = 2, cursor-y = 2.

       animate-bitmap.

           perform until 2 = 1
             perform varying bmp-num from 1 by 1 until bmp-num > 15
               modify grid-1,
                 x = 1, y = 1,
                 bitmap = gt-bitmap
                 bitmap-number = bmp-num
                 bitmap-width = 16,
                 bitmap-trailing = 1

                 call "c$sleep" using 0.2
             end-perform
           end-perform.

      * A janela SOBRE é uma INDEPENDENT WINDOW, e pode ser minimizada
      * indepentenmente da janela principal. Ela é também uma MODELESS WINDOW,
      * e é executada no seu proprio THREAD.

       explain-the-program.
           display independent window line 10 col 10
                   title-bar, system menu,
                   title "Sobre GridCtl",
                   lines 17 size 60
                   auto-minimize
                   modeless bind to thread
                   handle window-1.

           display about-screen.
           perform load-comments.

           perform until exit-about-screen
             accept about-screen on exception continue end-accept
           end-perform.

           modify about-pb, enabled = 1.
           call "w$menu" using wmenu-enable, grid-menu, 15.

      * An unsorted Listbox is an excellent tool for presenting comments

       load-comments.
           modify comments-listbox, reset-list = 1                    .
           move "Utilizando o Controle Grid " to scratch      .
           modify comments-listbox, item-to-add = scratch             .
           move "-" to scratch                                        .
           modify comments-listbox, item-to-add = scratch             .
           move "Arraste o Mouse entre a Coluna de Cabecalho" to scratch.
           modify comments-listbox, item-to-add = scratch             .
           move "Arraste o Mouse abaixo da Linha Cabecalho" to scratch.
           modify comments-listbox, item-to-add = scratch             .
           move "Left-click na celula, e arraste o Mouse" to scratch.
           modify comments-listbox, item-to-add = scratch             .
           move "Clique na Coluna Cabecalho" to scratch                .
           modify comments-listbox, item-to-add = scratch             .
           move "Clicque na Linha Cabecalho" to scratch                   .
           modify comments-listbox, item-to-add = scratch             .
           move "Cliqie no divisor da Coluna Cabecalho, e " to scratch  .
           modify comments-listbox, item-to-add = scratch             .
           move " ajuste o tamanho da coluna com o divisor" to scratch.
           modify comments-listbox, item-to-add = scratch             .
           move "Chamando o Popup Menu Vertical: " to scratch          .
           modify comments-listbox, item-to-add = scratch             .
           move "  Clicando no Bitmap na Celula (1,1) " to scratch      .
           modify comments-listbox, item-to-add = scratch             .
           move "  Right-clicking dentro do Controle Grid" to scratch     .
           modify comments-listbox, item-to-add = scratch             .
           move "Clique na celula, e insira dados" to scratch            .
           modify comments-listbox, item-to-add = scratch             .
           move "Para cancelar, aperte a telcha ESC" to scratch       .
           modify comments-listbox, item-to-add = scratch             .

       exception-handler.
           evaluate true
             when about-pressed
               modify about-pb, enabled = 0
               call "w$menu" using wmenu-disable, grid-menu, 15
               perform thread explain-the-program handle about-thread
           end-evaluate.

       grid-1-handler.
           evaluate event-type

             when msg-goto-cell
             when msg-goto-cell-mouse
                 modify grid-1, region-color = 0

             when msg-bitmap-clicked
                 call "w$menu" using wmenu-popup, grid-menu

             when msg-goto-cell-drag
                 modify grid-1,
                   drag-color = bright-white + bckgrnd-red

              when msg-heading-clicked
              when msg-heading-dragged
                  inquire grid-1, x in grid-x, y in grid-y

                  evaluate true
                    when grid-x = 1 and grid-y = 1
                       modify grid-1, region-color = 0
                    when in-row-headings
                       modify grid-1,
                         start-x = 2, start-y = grid-y
                         x = max-cols, y = grid-y,
                         region-color = bright-white + bckgrnd-black

                    when in-column-headings
                      modify grid-1,
                        start-x = grid-x, start-y = 2,
                        x = grid-x, y = max-rows
                        region-color = bright-white + bckgrnd-black

                  end-evaluate

           end-evaluate.
      *
      *copy "gridctl.cpy".
       BUILD-MAIN-POPUP.
           PERFORM GEN-MAIN-POPUP THRU GEN-MAIN-POPUP-EXIT.

       GEN-MAIN-POPUP.
           CALL "W$MENU" USING WMENU-NEW-POPUP
           IF RETURN-CODE = ZERO
               GO TO GEN-MAIN-POPUP-EXIT
           END-IF
           MOVE RETURN-CODE TO MENU-HANDLE

           CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                               "Sobre", 15
           CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                               "Sair", 10
           .

       GEN-MAIN-POPUP-EXIT.
           MOVE ZERO TO RETURN-CODE.

       initialization.
           accept terminal-abilities from terminal-info.
           if not has-graphical-interface
             display message box
               "Este programa requer um runtime de interface grafica!"
             stop run
           end-if.
