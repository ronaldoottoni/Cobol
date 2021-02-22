       identification division.
       program-id.  Browser.
       date-written.  21-May-98

      * Copyright (c) 1996-2010 by Micro Focus. Users of ACUCOBOL-GT
      * may freely modify and redistribute this program.

       remarks.
           This program illustrates the WEB BROWSER control type.

      **************************************************
       data division.
       working-storage section.
       copy "def/acucobol.def".
       copy "def/acugui.def".

       77  key-status
                is special-names  crt status    pic 9(4) value 0.
                88  exit-button-pushed          value 27.

       01  event-status
                is special-names event status.
           03  event-type                       pic x(4) comp-x.
           03  event-window-handle              usage handle.
           03  event-control-handle             usage handle.
           03  event-control-id                 pic x(2) comp-x.
           03  event-data-1                     usage signed-short.
           03  event-data-2                     usage signed-long.
           03  event-action                     pic x comp-x.

       78  event-occurred                       value 96.
       78  go-btn-pressed                       value 707.
       78  back-btn-pressed                     value 708.
       78  forward-btn-pressed                  value 709.
       78  home-btn-pressed                     value 710.
       78  refresh-btn-pressed                  value 711.
       78  search-btn-pressed                   value 712.
       78  stop-btn-pressed                     value 713.
       77  ef-url                               pic x(1000).
       77  wb-1-url                             pic x(1000).
       77  wb-1-title                           pic x(100).
       77  wb-1-status                          pic x(100).
       77  wb-1-progress                        pic 9(7).
       77  wb-1-max-progress                    pic 9(7).
       77  progress-percent                     pic 9(9).

       77  gt-bitmap                            pic s9(9) comp-4.

       01  configuration-data.
         05 current-lines           pic s99999V99 value 25.
         05 current-size            pic s99999v99 value 73.

       01  winversion-data.
         03 win-major-version       pic x comp-x.
         03 win-minor-version       pic x comp-x.
         03 win-platform            pic x comp-x.
           88 platform-win-31       value 1.
           88 platform-win-95       value 2.
           88 platform-win-nt       value 3.
         03 win-wordsize            pic x comp-x.
           88 win-wordsize-16       value 1.
           88 win-wordsize-32       value 2.

       77  window-1                 handle of window.

       01  message-txt             pic x(240)
           value  "This program demonstrates a feature (browser-control)
      -    " that only functions under 32-bit Windows using the 32-bit
      -    "Windows runtime.  It is provided as a code sample, but you
      -    "cannot view the results with this runtime system.".

      **************************************************
       screen section.
       01  screen-1.

           03  entry-field, column 5, line 4, size 55 max-text = 0
               value ef-url.

           03  push-button, "&Voltar",
	       column 5, line 2, size 9
               self-act
               termination-value = back-btn-pressed.

           03  push-button, "&Avancar",
               column + 2, size 9
               self-act
               termination-value = forward-btn-pressed.

           03  push-button, "&Home",
               column + 2, size 9
               self-act
               termination-value = home-btn-pressed.

           03  push-button, "&Atualizar",
               column + 2, size 9
               self-act
               termination-value = refresh-btn-pressed.

      *    03  push-button, "&Find",
      *         column + 2, size 9
      *         self-act
      *         termination-value = search-btn-pressed.

           03  push-button, "&Stop",
               column + 2, size 9
               self-act
               termination-value = stop-btn-pressed.

           03  push-button, "&Ir", default-button
               column 55.2, line 4,
               termination-value = go-btn-pressed.

           03  status-frame-1 frame, line 22, column 5,
               lines 2 size 65 cells lowered.

           03  status-text-1 label, line 22.5, column 5.5,
               size 64 cells
               value wb-1-status.

           03  progress-meter-1 frame line 24 column 5
               lines 1.5 size 24
               fill-color = red, fill-color2 = white,
               fill-percent = 0, lowered.

           03  exit-1 push-button, "Sair",
               cancel-button, line 24, column 32, size 11.

           03  busy-bitmap bitmap bitmap-handle = gt-bitmap,
               size 39, bitmap-start = 1, bitmap-end = 15,
               bitmap-timer = 0,
               line 2, column 65.

           03  wb-1 web-browser
               column 5, line 6,
               lines 16 cells, size 65 cells
               event procedure is browser-event-handler.

       01 message-screen.
           03 label title message-txt center
              line 1 col 2 size 45 cells, lines 6.
           03 push-button, line 7.5, cline 8, col 20
              lines 1.5 "OK", ok-button.

      **************************************************
       procedure division.
       main-logic.
           perform initialization.
      *    Setup a gray screen background
           display standard window,
                title "Web Browser - browser.cbl"
                lines current-lines, size current-size,
                resizable
                background-low.

           call "w$bitmap" using wbitmap-load, "gtanima.bmp",
                giving gt-bitmap.

           display screen-1.

           perform, with test after, until exit-button-pushed
                accept screen-1
                evaluate key-status
                  when go-btn-pressed
                    move ef-url to wb-1-url
                    modify wb-1 value=wb-1-url
                  when back-btn-pressed
                    modify wb-1 go-back=1
                  when forward-btn-pressed
                    modify wb-1 go-forward=1
                  when home-btn-pressed
                    modify wb-1 go-home=1
                  when search-btn-pressed
                    modify wb-1 go-search=1
                  when refresh-btn-pressed
                    modify wb-1 refresh=1
                  when stop-btn-pressed
                    modify wb-1 stop-browser=1
                  when event-occurred
                    if event-type = ntf-resized
                      divide event-data-1 by 100 giving current-lines
                      divide event-data-2 by 100 giving current-size
                      modify wb-1
                        lines current-lines - 9
                        size current-size - 8
                      modify status-frame-1
                        line current-lines - 3
                        size current-size - 8
                      modify status-text-1
                        line current-lines - 2.5
                        size current-size - 9
                      modify progress-meter-1
                        line current-lines - 1
                      modify exit-1
                        line current-lines - 1
                    end-if
                end-evaluate
           end-perform.
           stop run.

       browser-event-handler.
           evaluate event-type
      *        when msg-wb-before-navigate
      *            move event-action-fail to event-action
               when msg-wb-navigate-complete
                   inquire wb-1 value in wb-1-url
                   if wb-1-url is not = ef-url then
                       move wb-1-url to ef-url
                       display screen-1
                   end-if
      *        when msg-wb-download-begin
      *        when msg-wb-download-complete
               when msg-wb-progress-change
                   inquire wb-1 progress in wb-1-progress
                   inquire wb-1 max-progress in wb-1-max-progress
                   move wb-1-progress to progress-percent
                   multiply 100 by progress-percent
                   divide wb-1-max-progress into progress-percent
                   if progress-percent = 100
                       move 0 to progress-percent
                   end-if
                   modify progress-meter-1,
                       fill-percent = progress-percent
                   if progress-percent = 0
                       modify busy-bitmap bitmap-timer = 0
                           bitmap-number = 1
                   else
                       modify busy-bitmap bitmap-timer = 10
                   end-if
               when msg-wb-status-text-change
                   inquire wb-1 status-text in wb-1-status
                   display status-text-1
               when msg-wb-title-change
                   inquire wb-1 title in wb-1-title
                   display wb-1-title upon global window title
           end-evaluate.

       initialization.
           accept terminal-abilities from terminal-info.
           if (has-graphical-interface)
               call "win$version" using winversion-data
               evaluate true
                   when win-wordsize-16
                       perform display-message
                   when win-wordsize-32
                       continue
                   when other
                       perform display-message
               end-evaluate
           else
               perform display-message
           end-if.

       display-message.
               display floating window line 10 col 15
                   size 50 lines 10
                   title-bar
                   title
                   "Browser Control Requires 32-Bit Windows runtime"
                   system menu
                   boxed, erase,
                   background-low
                   handle window-1.
           display message-screen line 2 col 2.
           accept message-screen.
           stop run.
