*BACK-UP DO ARQUIVO ORDE.DAT (MYSQL)
 Identification Division.
 Program-Id. PROG944SQL.
 Author. RONALDO OTTONI.
 Environment Division.
 Configuration Section.
 Special-Names. Decimal-Point is comma.
 Input-Output Section.
 File-Control.
*
   Copy "..\COPY\ORDE.SL".
   Copy "..\COPY\RELATO.SL".
*
*
 Data Division.
 File Section.
$XFD FILE=ORDE
   Copy "..\COPY\ORDE.FD".
$XFD FILE=RELATO
   Copy "..\COPY\RELATO.FD".
*
 Working-Storage Section.
*
 Copy "..\COPY\Fonts.Def".
 Copy "..\COPY\acugui.Def".
 Copy "..\COPY\crtvars.Def".
 Copy "..\COPY\WinHelp.Def".
 Copy "..\COPY\Winprint.Def".
 Copy "..\COPY\acucobol.Def".
*
 01  Stat-ORDE           PIC X(002).
     88 Valido-ORDE      Value "00" THRU "09".
 01  PATHORDE            PIC X(060).
*
 01  Stat-RELATO         PIC X(002).
     88 Valido-RELATO    Value "00" THRU "09".
 01  PRINTER             PIC X(060).
*
 01 WS-PRI         PIC X(01) VALUE "S".
 01 OLD_ORDE.
    03 OO-NUME     PIC S9(006)     COMP-5.
    03 OO-EMIS     PIC  X(010)     .
    03 OO-CLIE     PIC S9(004)     COMP-5.
    03 OO-PROD-1   PIC S9(006)     COMP-5.
    03 OO-PROD-2   PIC S9(006)     COMP-5.
    03 OO-PROD-3   PIC S9(006)     COMP-5.
    03 OO-PROD-4   PIC S9(006)     COMP-5.
    03 OO-PROD-5   PIC S9(006)     COMP-5.
    03 OO-PROD-6   PIC S9(006)     COMP-5.
    03 OO-PROD-7   PIC S9(006)     COMP-5.
    03 OO-PROD-8   PIC S9(006)     COMP-5.
    03 OO-PROD-9   PIC S9(006)     COMP-5.
    03 OO-PROD-10  PIC S9(006)     COMP-5.
    03 OO-AREA-1   PIC S9(004)     COMP-5.
    03 OO-AREA-2   PIC S9(004)     COMP-5.
    03 OO-AREA-3   PIC S9(004)     COMP-5.
    03 OO-AREA-4   PIC S9(004)     COMP-5.
    03 OO-AREA-5   PIC S9(004)     COMP-5.
    03 OO-AREA-6   PIC S9(004)     COMP-5.
    03 OO-AREA-7   PIC S9(004)     COMP-5.
    03 OO-AREA-8   PIC S9(004)     COMP-5.
    03 OO-AREA-9   PIC S9(004)     COMP-5.
    03 OO-AREA-10  PIC S9(004)     COMP-5.
    03 OO-QUAN-1   PIC S9(012)V999 COMP-3.
    03 OO-QUAN-2   PIC S9(012)V999 COMP-3.
    03 OO-QUAN-3   PIC S9(012)V999 COMP-3.
    03 OO-QUAN-4   PIC S9(012)V999 COMP-3.
    03 OO-QUAN-5   PIC S9(012)V999 COMP-3.
    03 OO-QUAN-6   PIC S9(012)V999 COMP-3.
    03 OO-QUAN-7   PIC S9(012)V999 COMP-3.
    03 OO-QUAN-8   PIC S9(012)V999 COMP-3.
    03 OO-QUAN-9   PIC S9(012)V999 COMP-3.
    03 OO-QUAN-10  PIC S9(012)V999 COMP-3.
    03 OO-VOLU-1   PIC S9(004)     COMP-5.
    03 OO-VOLU-2   PIC S9(004)     COMP-5.
    03 OO-VOLU-3   PIC S9(004)     COMP-5.
    03 OO-VOLU-4   PIC S9(004)     COMP-5.
    03 OO-VOLU-5   PIC S9(004)     COMP-5.
    03 OO-VOLU-6   PIC S9(004)     COMP-5.
    03 OO-VOLU-7   PIC S9(004)     COMP-5.
    03 OO-VOLU-8   PIC S9(004)     COMP-5.
    03 OO-VOLU-9   PIC S9(004)     COMP-5.
    03 OO-VOLU-10  PIC S9(004)     COMP-5.
    03 OO-QVOL-1   PIC S9(009)V999 COMP-3.
    03 OO-QVOL-2   PIC S9(009)V999 COMP-3.
    03 OO-QVOL-3   PIC S9(009)V999 COMP-3.
    03 OO-QVOL-4   PIC S9(009)V999 COMP-3.
    03 OO-QVOL-5   PIC S9(009)V999 COMP-3.
    03 OO-QVOL-6   PIC S9(009)V999 COMP-3.
    03 OO-QVOL-7   PIC S9(009)V999 COMP-3.
    03 OO-QVOL-8   PIC S9(009)V999 COMP-3.
    03 OO-QVOL-9   PIC S9(009)V999 COMP-3.
    03 OO-QVOL-10  PIC S9(009)V999 COMP-3.
    03 OO-QAVL-1   PIC S9(009)V999 COMP-3.
    03 OO-QAVL-2   PIC S9(009)V999 COMP-3.
    03 OO-QAVL-3   PIC S9(009)V999 COMP-3.
    03 OO-QAVL-4   PIC S9(009)V999 COMP-3.
    03 OO-QAVL-5   PIC S9(009)V999 COMP-3.
    03 OO-QAVL-6   PIC S9(009)V999 COMP-3.
    03 OO-QAVL-7   PIC S9(009)V999 COMP-3.
    03 OO-QAVL-8   PIC S9(009)V999 COMP-3.
    03 OO-QAVL-9   PIC S9(009)V999 COMP-3.
    03 OO-QAVL-10  PIC S9(009)V999 COMP-3.
    03 OO-OBPR-1   PIC  X(030)     .
    03 OO-OBPR-2   PIC  X(030)     .
    03 OO-OBPR-3   PIC  X(030)     .
    03 OO-OBPR-4   PIC  X(030)     .
    03 OO-OBPR-5   PIC  X(030)     .
    03 OO-OBPR-6   PIC  X(030)     .
    03 OO-OBPR-7   PIC  X(030)     .
    03 OO-OBPR-8   PIC  X(030)     .
    03 OO-OBPR-9   PIC  X(030)     .
    03 OO-OBPR-10  PIC  X(030)     .
    03 OO-LOCA     PIC  X(020)     .
    03 OO-TRAN     PIC S9(004)     COMP-5.
    03 OO-TICK     PIC S9(006)     COMP-5.
    03 OO-TARA     PIC S9(012)V999 COMP-3.
    03 OO-BRUT     PIC S9(012)V999 COMP-3.
    03 OO-LIQU     PIC S9(012)V999 COMP-3.
    03 OO-ORVE     PIC S9(006)     COMP-5.
    03 OO-OVEM     PIC S9(002)     COMP-5.
    03 OO-OBSE     PIC  X(200)     .
    03 OO-VLUN-1   PIC S9(005)V9999 COMP-3.
    03 OO-VLUN-2   PIC S9(005)V9999 COMP-3.
    03 OO-VLUN-3   PIC S9(005)V9999 COMP-3.
    03 OO-VLUN-4   PIC S9(005)V9999 COMP-3.
    03 OO-VLUN-5   PIC S9(005)V9999 COMP-3.
    03 OO-VLUN-6   PIC S9(005)V9999 COMP-3.
    03 OO-VLUN-7   PIC S9(005)V9999 COMP-3.
    03 OO-VLUN-8   PIC S9(005)V9999 COMP-3.
    03 OO-VLUN-9   PIC S9(005)V9999 COMP-3.
    03 OO-VLUN-10  PIC S9(005)V9999 COMP-3.
    03 OO-VENC-1   PIC  X(010)     .
    03 OO-VENC-2   PIC  X(010)     .
    03 OO-VENC-3   PIC  X(010)     .
    03 OO-VENC-4   PIC  X(010)     .
    03 OO-VENC-5   PIC  X(010)     .
    03 OO-VALO-1   PIC S9(012)V99  COMP-3.
    03 OO-VALO-2   PIC S9(012)V99  COMP-3.
    03 OO-VALO-3   PIC S9(012)V99  COMP-3.
    03 OO-VALO-4   PIC S9(012)V99  COMP-3.
    03 OO-VALO-5   PIC S9(012)V99  COMP-3.
    03 OO-VEND     PIC S9(004)     COMP-5.
    03 OO-LIBE     PIC  X(020)     .
    03 OO-DTLB     PIC  X(010)     .
    03 OO-HRLB     PIC  X(008)     .
    03 OO-SITU     PIC S9(001)     COMP-5.
    03 OO-PEDV     PIC S9(006)     COMP-5.
    03 OO-QDFA-1   PIC S9(009)V999 COMP-3.
    03 OO-QDFA-2   PIC S9(009)V999 COMP-3.
    03 OO-QDFA-3   PIC S9(009)V999 COMP-3.
    03 OO-QDFA-4   PIC S9(009)V999 COMP-3.
    03 OO-QDFA-5   PIC S9(009)V999 COMP-3.
    03 OO-QDFA-6   PIC S9(009)V999 COMP-3.
    03 OO-QDFA-7   PIC S9(009)V999 COMP-3.
    03 OO-QDFA-8   PIC S9(009)V999 COMP-3.
    03 OO-QDFA-9   PIC S9(009)V999 COMP-3.
    03 OO-QDFA-10  PIC S9(009)V999 COMP-3.
    03 OO-SELE-1   PIC  X(001)     .
    03 OO-SELE-2   PIC  X(001)     .
    03 OO-SELE-3   PIC  X(001)     .
    03 OO-SELE-4   PIC  X(001)     .
    03 OO-SELE-5   PIC  X(001)     .
    03 OO-SELE-6   PIC  X(001)     .
    03 OO-SELE-7   PIC  X(001)     .
    03 OO-SELE-8   PIC  X(001)     .
    03 OO-SELE-9   PIC  X(001)     .
    03 OO-SELE-10  PIC  X(001)     .
    03 OO-FRET     PIC S9(011)V99  COMP-3.
    03 OO-ICFR     PIC S9(011)V99  COMP-3.
    03 OO-INCL     PIC  X(020)     .
    03 OO-DTIN     PIC  X(010)     .
    03 OO-HRIN     PIC  X(008)     .
    03 OO-ALTE     PIC  X(020)     .
    03 OO-DTAL     PIC  X(010)     .
    03 OO-HRAL     PIC  X(008)     .

   EXEC SQL INCLUDE SQLCA END-EXEC.
   EXEC SQL BEGIN DECLARE SECTION END-EXEC.
        01 WS_ORDE.
           03 OD-NUME     PIC S9(006)     COMP-5.
           03 OD-EMIS     PIC  X(010)     .
           03 OD-CLIE     PIC S9(004)     COMP-5.
           03 OD-PROD-1   PIC S9(006)     COMP-5.
           03 OD-PROD-2   PIC S9(006)     COMP-5.
           03 OD-PROD-3   PIC S9(006)     COMP-5.
           03 OD-PROD-4   PIC S9(006)     COMP-5.
           03 OD-PROD-5   PIC S9(006)     COMP-5.
           03 OD-PROD-6   PIC S9(006)     COMP-5.
           03 OD-PROD-7   PIC S9(006)     COMP-5.
           03 OD-PROD-8   PIC S9(006)     COMP-5.
           03 OD-PROD-9   PIC S9(006)     COMP-5.
           03 OD-PROD-10  PIC S9(006)     COMP-5.
           03 OD-AREA-1   PIC S9(004)     COMP-5.
           03 OD-AREA-2   PIC S9(004)     COMP-5.
           03 OD-AREA-3   PIC S9(004)     COMP-5.
           03 OD-AREA-4   PIC S9(004)     COMP-5.
           03 OD-AREA-5   PIC S9(004)     COMP-5.
           03 OD-AREA-6   PIC S9(004)     COMP-5.
           03 OD-AREA-7   PIC S9(004)     COMP-5.
           03 OD-AREA-8   PIC S9(004)     COMP-5.
           03 OD-AREA-9   PIC S9(004)     COMP-5.
           03 OD-AREA-10  PIC S9(004)     COMP-5.
           03 OD-QUAN-1   PIC S9(012)V999 COMP-3.
           03 OD-QUAN-2   PIC S9(012)V999 COMP-3.
           03 OD-QUAN-3   PIC S9(012)V999 COMP-3.
           03 OD-QUAN-4   PIC S9(012)V999 COMP-3.
           03 OD-QUAN-5   PIC S9(012)V999 COMP-3.
           03 OD-QUAN-6   PIC S9(012)V999 COMP-3.
           03 OD-QUAN-7   PIC S9(012)V999 COMP-3.
           03 OD-QUAN-8   PIC S9(012)V999 COMP-3.
           03 OD-QUAN-9   PIC S9(012)V999 COMP-3.
           03 OD-QUAN-10  PIC S9(012)V999 COMP-3.
           03 OD-VOLU-1   PIC S9(004)     COMP-5.
           03 OD-VOLU-2   PIC S9(004)     COMP-5.
           03 OD-VOLU-3   PIC S9(004)     COMP-5.
           03 OD-VOLU-4   PIC S9(004)     COMP-5.
           03 OD-VOLU-5   PIC S9(004)     COMP-5.
           03 OD-VOLU-6   PIC S9(004)     COMP-5.
           03 OD-VOLU-7   PIC S9(004)     COMP-5.
           03 OD-VOLU-8   PIC S9(004)     COMP-5.
           03 OD-VOLU-9   PIC S9(004)     COMP-5.
           03 OD-VOLU-10  PIC S9(004)     COMP-5.
           03 OD-QVOL-1   PIC S9(009)V999 COMP-3.
           03 OD-QVOL-2   PIC S9(009)V999 COMP-3.
           03 OD-QVOL-3   PIC S9(009)V999 COMP-3.
           03 OD-QVOL-4   PIC S9(009)V999 COMP-3.
           03 OD-QVOL-5   PIC S9(009)V999 COMP-3.
           03 OD-QVOL-6   PIC S9(009)V999 COMP-3.
           03 OD-QVOL-7   PIC S9(009)V999 COMP-3.
           03 OD-QVOL-8   PIC S9(009)V999 COMP-3.
           03 OD-QVOL-9   PIC S9(009)V999 COMP-3.
           03 OD-QVOL-10  PIC S9(009)V999 COMP-3.
           03 OD-QAVL-1   PIC S9(009)V999 COMP-3.
           03 OD-QAVL-2   PIC S9(009)V999 COMP-3.
           03 OD-QAVL-3   PIC S9(009)V999 COMP-3.
           03 OD-QAVL-4   PIC S9(009)V999 COMP-3.
           03 OD-QAVL-5   PIC S9(009)V999 COMP-3.
           03 OD-QAVL-6   PIC S9(009)V999 COMP-3.
           03 OD-QAVL-7   PIC S9(009)V999 COMP-3.
           03 OD-QAVL-8   PIC S9(009)V999 COMP-3.
           03 OD-QAVL-9   PIC S9(009)V999 COMP-3.
           03 OD-QAVL-10  PIC S9(009)V999 COMP-3.
           03 OD-OBPR-1   PIC  X(030)     .
           03 OD-OBPR-2   PIC  X(030)     .
           03 OD-OBPR-3   PIC  X(030)     .
           03 OD-OBPR-4   PIC  X(030)     .
           03 OD-OBPR-5   PIC  X(030)     .
           03 OD-OBPR-6   PIC  X(030)     .
           03 OD-OBPR-7   PIC  X(030)     .
           03 OD-OBPR-8   PIC  X(030)     .
           03 OD-OBPR-9   PIC  X(030)     .
           03 OD-OBPR-10  PIC  X(030)     .
           03 OD-LOCA     PIC  X(020)     .
           03 OD-TRAN     PIC S9(006)     COMP-5.
           03 OD-TICK     PIC S9(006)     COMP-5.
           03 OD-TARA     PIC S9(012)V999 COMP-3.
           03 OD-BRUT     PIC S9(012)V999 COMP-3.
           03 OD-LIQU     PIC S9(012)V999 COMP-3.
           03 OD-ORVE     PIC S9(006)     COMP-5.
           03 OD-OVEM     PIC S9(002)     COMP-5.
           03 OD-OBSE     PIC  X(200)     .
           03 OD-VLUN-1   PIC S9(005)V9999 COMP-3.
           03 OD-VLUN-2   PIC S9(005)V9999 COMP-3.
           03 OD-VLUN-3   PIC S9(005)V9999 COMP-3.
           03 OD-VLUN-4   PIC S9(005)V9999 COMP-3.
           03 OD-VLUN-5   PIC S9(005)V9999 COMP-3.
           03 OD-VLUN-6   PIC S9(005)V9999 COMP-3.
           03 OD-VLUN-7   PIC S9(005)V9999 COMP-3.
           03 OD-VLUN-8   PIC S9(005)V9999 COMP-3.
           03 OD-VLUN-9   PIC S9(005)V9999 COMP-3.
           03 OD-VLUN-10  PIC S9(005)V9999 COMP-3.
           03 OD-VENC-1   PIC  X(010)     .
           03 OD-VENC-2   PIC  X(010)     .
           03 OD-VENC-3   PIC  X(010)     .
           03 OD-VENC-4   PIC  X(010)     .
           03 OD-VENC-5   PIC  X(010)     .
           03 OD-VALO-1   PIC S9(012)V99  COMP-3.
           03 OD-VALO-2   PIC S9(012)V99  COMP-3.
           03 OD-VALO-3   PIC S9(012)V99  COMP-3.
           03 OD-VALO-4   PIC S9(012)V99  COMP-3.
           03 OD-VALO-5   PIC S9(012)V99  COMP-3.
           03 OD-VEND     PIC S9(004)     COMP-5.
           03 OD-LIBE     PIC  X(020)     .
           03 OD-DTLB     PIC  X(010)     .
           03 OD-HRLB     PIC  X(008)     .
           03 OD-SITU     PIC S9(001)     COMP-5.
           03 OD-PEDV     PIC S9(006)     COMP-5.
           03 OD-QDFA-1   PIC S9(009)V999 COMP-3.
           03 OD-QDFA-2   PIC S9(009)V999 COMP-3.
           03 OD-QDFA-3   PIC S9(009)V999 COMP-3.
           03 OD-QDFA-4   PIC S9(009)V999 COMP-3.
           03 OD-QDFA-5   PIC S9(009)V999 COMP-3.
           03 OD-QDFA-6   PIC S9(009)V999 COMP-3.
           03 OD-QDFA-7   PIC S9(009)V999 COMP-3.
           03 OD-QDFA-8   PIC S9(009)V999 COMP-3.
           03 OD-QDFA-9   PIC S9(009)V999 COMP-3.
           03 OD-QDFA-10  PIC S9(009)V999 COMP-3.
           03 OD-SELE-1   PIC  X(001)     .
           03 OD-SELE-2   PIC  X(001)     .
           03 OD-SELE-3   PIC  X(001)     .
           03 OD-SELE-4   PIC  X(001)     .
           03 OD-SELE-5   PIC  X(001)     .
           03 OD-SELE-6   PIC  X(001)     .
           03 OD-SELE-7   PIC  X(001)     .
           03 OD-SELE-8   PIC  X(001)     .
           03 OD-SELE-9   PIC  X(001)     .
           03 OD-SELE-10  PIC  X(001)     .
           03 OD-FRET     PIC S9(011)V99  COMP-3.
           03 OD-ICFR     PIC S9(011)V99  COMP-3.
           03 OD-INCL     PIC  X(020)     .
           03 OD-DTIN     PIC  X(010)     .
           03 OD-HRIN     PIC  X(008)     .
           03 OD-ALTE     PIC  X(020)     .
           03 OD-DTAL     PIC  X(010)     .
           03 OD-HRAL     PIC  X(008)     .
   EXEC SQL END DECLARE SECTION END-EXEC.
*
01 Contador                   Pic 9(006)    value zeros.
01 Handle-TELA002             Handle Of Window.
01 FONT-TELA002-nLabel-001    Handle Of Font.
01 COLOR-TELA002-nLabel-001   Pic X Comp-X.
*
 Linkage Section.
 Copy "..\copy\linkage.cpy".
 01 Lk-Data-Inicial           Pic 9(008).
*
Screen section.
01 Tela-Tela002.
   03 Frame, Line    1,00, Col    2,00,
      Lines   6,00, Size   57,00 CELLS,
      Lowered
   .
   03 TELA002-nLabel-001 Label,
      "Aguarde...",
      Line    3,00, Col   25,00,
      Lines    2,00, Size   14,00, Label-OffSet = 20,
      Transparent,
      Left,
      ID = 011
      FONT FONT-TELA002-nLabel-001,
      COLOR COLOR-TELA002-nLabel-001
   .
   03 TELA001-nLabel-002 Label,
      Contador ,
      Line    9,00, Col    3,00,
      Lines    1,00, Size   55,00, Label-OffSet = 20,
      Transparent,
      Center,
      ID = 012
   .
*
 Procedure Division Using LK-Linkage, Lk-Data-Inicial.
 COPY "..\COPY\10000.MOD".
*
 Inicio.
   Display Floating Window, Size   59,00,
   Lines   6,00 Color 0257 System Menu Title-Bar
   Title "Verifying file: ORDE.DAT- Please Wait",
   Cell Height 15
   Cell Width   9
   Pop-Up Handle-TELA002.
   Display tela-tela002.
*
   Move "PROG944" To WS-PROG
   Move 80        To WS-COL-SCREEN

   Move Spaces to PathORDE.
   String Lk-Unidade        Delimited By Size
          "\DADOS\ORDE.DAT" Delimited By Size
          Into PathORDE
   End-String.
   OPEN I-O ORDE
   If Not valido-ORDE
      Display message box "erro ORDE" stat-ORDE
      Exit Program
   End-if
*
   EXEC SQL WHENEVER SQLERROR GOTO ERROR-EXIT END-EXEC

   EXEC SQL
        DECLARE CORDE CURSOR FOR
                SELECT * FROM IBICOARA.ORDE
   END-EXEC

   EXEC SQL OPEN CORDE END-EXEC
   MOVE "S" TO WS-PRI
   Perform until 1 = 0
       Initialize WS_ORDE
       EXEC SQL
            FETCH CORDE INTO :WS_ORDE
       END-EXEC
       IF WS_ORDE = SPACES
          EXIT PERFORM
       END-IF
       IF WS-PRI = "S"
          MOVE WS_ORDE TO OLD_ORDE
          MOVE "N"     TO WS-PRI
       ELSE
          IF WS_ORDE EQUAL OLD_ORDE
             EXIT PERFORM
          ELSE
             MOVE WS_ORDE TO OLD_ORDE
          END-IF
       END-IF
       IF OD-NUME > ZEROS
          Initialize ORDE-REGI
          MOVE OD-NUME     TO  ORDE-NUME
          MOVE OD-EMIS(1:4)TO  ORDE-EMIS(1:4)
          MOVE OD-EMIS(6:2)TO  ORDE-EMIS(5:2)
          MOVE OD-EMIS(9:2)TO  ORDE-EMIS(7:2)
          MOVE OD-CLIE     TO  ORDE-CLIE
          MOVE OD-PROD-1   TO  ORDE-PROD(1)
          MOVE OD-PROD-2   TO  ORDE-PROD(2)
          MOVE OD-PROD-3   TO  ORDE-PROD(3)
          MOVE OD-PROD-4   TO  ORDE-PROD(4)
          MOVE OD-PROD-5   TO  ORDE-PROD(5)
          MOVE OD-PROD-6   TO  ORDE-PROD(6)
          MOVE OD-PROD-7   TO  ORDE-PROD(7)
          MOVE OD-PROD-8   TO  ORDE-PROD(8)
          MOVE OD-PROD-9   TO  ORDE-PROD(9)
          MOVE OD-PROD-10  TO  ORDE-PROD(10)
          MOVE OD-AREA-1   TO  ORDE-AREA(1)
          MOVE OD-AREA-2   TO  ORDE-AREA(2)
          MOVE OD-AREA-3   TO  ORDE-AREA(3)
          MOVE OD-AREA-4   TO  ORDE-AREA(4)
          MOVE OD-AREA-5   TO  ORDE-AREA(5)
          MOVE OD-AREA-6   TO  ORDE-AREA(6)
          MOVE OD-AREA-7   TO  ORDE-AREA(7)
          MOVE OD-AREA-8   TO  ORDE-AREA(8)
          MOVE OD-AREA-9   TO  ORDE-AREA(9)
          MOVE OD-AREA-10  TO  ORDE-AREA(10)
          MOVE OD-QUAN-1   TO  ORDE-QUAN(1)
          MOVE OD-QUAN-2   TO  ORDE-QUAN(2)
          MOVE OD-QUAN-3   TO  ORDE-QUAN(3)
          MOVE OD-QUAN-4   TO  ORDE-QUAN(4)
          MOVE OD-QUAN-5   TO  ORDE-QUAN(5)
          MOVE OD-QUAN-6   TO  ORDE-QUAN(6)
          MOVE OD-QUAN-7   TO  ORDE-QUAN(7)
          MOVE OD-QUAN-8   TO  ORDE-QUAN(8)
          MOVE OD-QUAN-9   TO  ORDE-QUAN(9)
          MOVE OD-QUAN-10  TO  ORDE-QUAN(10)
          MOVE OD-VOLU-1   TO  ORDE-VOLU(1)
          MOVE OD-VOLU-2   TO  ORDE-VOLU(2)
          MOVE OD-VOLU-3   TO  ORDE-VOLU(3)
          MOVE OD-VOLU-4   TO  ORDE-VOLU(4)
          MOVE OD-VOLU-5   TO  ORDE-VOLU(5)
          MOVE OD-VOLU-6   TO  ORDE-VOLU(6)
          MOVE OD-VOLU-7   TO  ORDE-VOLU(7)
          MOVE OD-VOLU-8   TO  ORDE-VOLU(8)
          MOVE OD-VOLU-9   TO  ORDE-VOLU(9)
          MOVE OD-VOLU-10  TO  ORDE-VOLU(10)
          MOVE OD-QVOL-1   TO  ORDE-QVOL(1)
          MOVE OD-QVOL-2   TO  ORDE-QVOL(2)
          MOVE OD-QVOL-3   TO  ORDE-QVOL(3)
          MOVE OD-QVOL-4   TO  ORDE-QVOL(4)
          MOVE OD-QVOL-5   TO  ORDE-QVOL(5)
          MOVE OD-QVOL-6   TO  ORDE-QVOL(6)
          MOVE OD-QVOL-7   TO  ORDE-QVOL(7)
          MOVE OD-QVOL-8   TO  ORDE-QVOL(8)
          MOVE OD-QVOL-9   TO  ORDE-QVOL(9)
          MOVE OD-QVOL-10  TO  ORDE-QVOL(10)
          MOVE OD-QAVL-1   TO  ORDE-QAVL(1)
          MOVE OD-QAVL-2   TO  ORDE-QAVL(2)
          MOVE OD-QAVL-3   TO  ORDE-QAVL(3)
          MOVE OD-QAVL-4   TO  ORDE-QAVL(4)
          MOVE OD-QAVL-5   TO  ORDE-QAVL(5)
          MOVE OD-QAVL-6   TO  ORDE-QAVL(6)
          MOVE OD-QAVL-7   TO  ORDE-QAVL(7)
          MOVE OD-QAVL-8   TO  ORDE-QAVL(8)
          MOVE OD-QAVL-9   TO  ORDE-QAVL(9)
          MOVE OD-QAVL-10  TO  ORDE-QAVL(10)
          MOVE OD-OBPR-1   TO  ORDE-OBPR(1)
          MOVE OD-OBPR-2   TO  ORDE-OBPR(2)
          MOVE OD-OBPR-3   TO  ORDE-OBPR(3)
          MOVE OD-OBPR-4   TO  ORDE-OBPR(4)
          MOVE OD-OBPR-5   TO  ORDE-OBPR(5)
          MOVE OD-OBPR-6   TO  ORDE-OBPR(6)
          MOVE OD-OBPR-7   TO  ORDE-OBPR(7)
          MOVE OD-OBPR-8   TO  ORDE-OBPR(8)
          MOVE OD-OBPR-9   TO  ORDE-OBPR(9)
          MOVE OD-OBPR-10  TO  ORDE-OBPR(10)
          MOVE OD-LOCA     TO  ORDE-LOCA
          MOVE OD-TRAN     TO  ORDE-TRAN
          MOVE OD-TICK     TO  ORDE-TICK
          MOVE OD-TARA     TO  ORDE-TARA
          MOVE OD-BRUT     TO  ORDE-BRUT
          MOVE OD-LIQU     TO  ORDE-LIQU
          MOVE OD-ORVE     TO  ORDE-ORVE
          MOVE OD-OVEM     TO  ORDE-OVEM
          MOVE OD-OBSE     TO  ORDE-OBSE
          MOVE OD-VLUN-1   TO  ORDE-VLUN(1)
          MOVE OD-VLUN-2   TO  ORDE-VLUN(2)
          MOVE OD-VLUN-3   TO  ORDE-VLUN(3)
          MOVE OD-VLUN-4   TO  ORDE-VLUN(4)
          MOVE OD-VLUN-5   TO  ORDE-VLUN(5)
          MOVE OD-VLUN-6   TO  ORDE-VLUN(6)
          MOVE OD-VLUN-7   TO  ORDE-VLUN(7)
          MOVE OD-VLUN-8   TO  ORDE-VLUN(8)
          MOVE OD-VLUN-9   TO  ORDE-VLUN(9)
          MOVE OD-VLUN-10  TO  ORDE-VLUN(10)
          MOVE OD-VENC-1(1:4)TO  ORDE-VENC(1)(1:4)
          MOVE OD-VENC-1(6:2)TO  ORDE-VENC(1)(5:2)
          MOVE OD-VENC-1(9:2)TO  ORDE-VENC(1)(7:2)
          MOVE OD-VENC-2(1:4)TO  ORDE-VENC(2)(1:4)
          MOVE OD-VENC-2(6:2)TO  ORDE-VENC(2)(5:2)
          MOVE OD-VENC-2(9:2)TO  ORDE-VENC(2)(7:2)
          MOVE OD-VENC-3(1:4)TO  ORDE-VENC(3)(1:4)
          MOVE OD-VENC-3(6:2)TO  ORDE-VENC(3)(5:2)
          MOVE OD-VENC-3(9:2)TO  ORDE-VENC(3)(7:2)
          MOVE OD-VENC-4(1:4)TO  ORDE-VENC(4)(1:4)
          MOVE OD-VENC-4(6:2)TO  ORDE-VENC(4)(5:2)
          MOVE OD-VENC-4(9:2)TO  ORDE-VENC(4)(7:2)
          MOVE OD-VENC-5(1:4)TO  ORDE-VENC(5)(1:4)
          MOVE OD-VENC-5(6:2)TO  ORDE-VENC(5)(5:2)
          MOVE OD-VENC-5(9:2)TO  ORDE-VENC(5)(7:2)
          MOVE OD-VALO-1   TO  ORDE-VALO(1)
          MOVE OD-VALO-2   TO  ORDE-VALO(2)
          MOVE OD-VALO-3   TO  ORDE-VALO(3)
          MOVE OD-VALO-4   TO  ORDE-VALO(4)
          MOVE OD-VALO-5   TO  ORDE-VALO(5)
          MOVE OD-VEND     TO  ORDE-VEND
          MOVE OD-LIBE     TO  ORDE-LIBE
          MOVE OD-DTLB(1:4)TO  ORDE-DTLB(1:4)
          MOVE OD-DTLB(6:2)TO  ORDE-DTLB(5:2)
          MOVE OD-DTLB(9:2)TO  ORDE-DTLB(7:2)
          MOVE OD-HRLB     TO  ORDE-HRLB
          MOVE OD-SITU     TO  ORDE-SITU
          MOVE OD-PEDV     TO  ORDE-PEDV
          MOVE OD-QDFA-1   TO  ORDE-QDFA(1)
          MOVE OD-QDFA-2   TO  ORDE-QDFA(2)
          MOVE OD-QDFA-3   TO  ORDE-QDFA(3)
          MOVE OD-QDFA-4   TO  ORDE-QDFA(4)
          MOVE OD-QDFA-5   TO  ORDE-QDFA(5)
          MOVE OD-QDFA-6   TO  ORDE-QDFA(6)
          MOVE OD-QDFA-7   TO  ORDE-QDFA(7)
          MOVE OD-QDFA-8   TO  ORDE-QDFA(8)
          MOVE OD-QDFA-9   TO  ORDE-QDFA(9)
          MOVE OD-QDFA-10  TO  ORDE-QDFA(10)
          MOVE OD-SELE-1   TO  ORDE-SELE(1)
          MOVE OD-SELE-2   TO  ORDE-SELE(2)
          MOVE OD-SELE-3   TO  ORDE-SELE(3)
          MOVE OD-SELE-4   TO  ORDE-SELE(4)
          MOVE OD-SELE-5   TO  ORDE-SELE(5)
          MOVE OD-SELE-6   TO  ORDE-SELE(6)
          MOVE OD-SELE-7   TO  ORDE-SELE(7)
          MOVE OD-SELE-8   TO  ORDE-SELE(8)
          MOVE OD-SELE-9   TO  ORDE-SELE(9)
          MOVE OD-SELE-10  TO  ORDE-SELE(10)
          MOVE OD-FRET     TO  ORDE-FRET
          MOVE OD-ICFR     TO  ORDE-ICFR
          MOVE OD-INCL     TO  ORDE-INCL
          MOVE OD-DTIN(1:4)TO  ORDE-DTIN(1:4)
          MOVE OD-DTIN(6:2)TO  ORDE-DTIN(5:2)
          MOVE OD-DTIN(9:2)TO  ORDE-DTIN(7:2)
          MOVE OD-HRIN     TO  ORDE-HRIN
          MOVE OD-ALTE     TO  ORDE-ALTE
          MOVE OD-DTAL(1:4)TO  ORDE-DTAL(1:4)
          MOVE OD-DTAL(6:2)TO  ORDE-DTAL(5:2)
          MOVE OD-DTAL(9:2)TO  ORDE-DTAL(7:2)
          MOVE OD-HRAL     TO  ORDE-HRAL
          Write orde-Regi Invalid Key
            Rewrite orde-Regi
          End-Write
          If Not Valido-ORDE
             Display Message Box "Erro ao Atualizar 'ORDE.DAT' - Status -> " Stat-ORDE
             Exit Perform
          End-if
       END-IF
   End-Perform
   EXEC SQL CLOSE CORDE END-EXEC
   EXEC SQL DELETE FROM IBICOARA.ORDE END-EXEC
   EXEC SQL COMMIT END-EXEC
*
   Commit
   Close ORDE.
   Close Window Handle-TELA002.
   Exit Program.
*
 ERROR-EXIT.
     EXEC SQL WHENEVER SQLERROR CONTINUE END-EXEC.
     Display Message Box
       "SQL Error !"NEWLINE
       "       SQLCODE: " SQLCODE  OF SQLCA NEWLINE
       "       SQLSTATE: "SQLSTATE OF SQLCA NEWLINE
       "       SQLERRMC: "SQLERRMC OF SQLCA NEWLINE
    EXEC SQL DISCONNECT ALL END-EXEC.
    Exit PROGRAM.
*
   Copy "..\copy\screen.cpy".
