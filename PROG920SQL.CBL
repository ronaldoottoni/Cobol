*BACK-UP DO ARQUIVO SERV.DAT NO BANCO MYSQL EM CURITIBA
 Identification Division.
 Program-Id. PROG920SQL.
 Author. RONALDO OTTONI.
 Environment Division.
 Configuration Section.
 Special-Names.
  Copy "..\copy\progressbar.def".
  Copy "..\copy\acuclass.def".
 Input-Output Section.
 File-Control.
*
   Copy "..\COPY\SERV.SL".
   Copy "..\COPY\RELATO.SL".
*
 Data Division.
 File Section.
$XFD FILE=SERV
   Copy "..\COPY\SERV.FD".
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
 Copy "..\COPY\activex.def".
*
 01  Stat-SERV           PIC X(002).
     88 Valido-SERV      Value "00" THRU "09".
 01  PATHSERV            PIC X(060).
*
 01  Stat-RELATO         PIC X(002).
     88 Valido-RELATO    Value "00" THRU "09".
 01  PRINTER             PIC X(060).
*
77 ActiveX-Res        USAGE IS HANDLE OF RESOURCE.
01 WW-ITEN            pic 9(009).
01 int                Pic 9(006) value zeros.
01 WS-CALCULA               Pic 9(012)V9(05) VALUE ZEROS.
01 PARTE-VALOR.
   03 INT-VALOR             PIC 9(012).
   03 RESTO-VALOR           PIC 9(005).
01 perc-unit          Pic 9(003).
01 Handle-TELA002             Handle Of Window.
01 FONT-TELA002-nLabel-001    Handle Of Font.
01 COLOR-TELA002-nLabel-001   Pic X Comp-X.
   EXEC SQL INCLUDE SQLCA END-EXEC
   EXEC SQL BEGIN DECLARE SECTION END-EXEC
        01 WS-SER.
           03 SV-FILI        PIC S9(002)     COMP-5.
           03 SV-FORN        PIC S9(004)     COMP-5.
           03 SV-NOTA        PIC S9(006)     COMP-5.
           03 SV-SERI        PIC  X(003)           .
           03 SV-EMIS        PIC  X(010)           .
           03 SV-DESC        PIC  X(199)           .
           03 SV-FIXO        PIC  X(001)           .
           03 SV-VALO        PIC S9(012)V99  COMP-3.
           03 SV-IRRF        PIC S9(012)V99  COMP-3.
           03 SV-INSS        PIC S9(012)V99  COMP-3.
           03 SV-LIQU        PIC S9(012)V99  COMP-3.
           03 SV-CONT        PIC S9(004)     COMP-5.
           03 SV-ENTR        PIC  X(010)           .
           03 SV-CUST        PIC S9(004)     COMP-5.
           03 SV-TIPO        PIC S9(002)     COMP-5.
           03 SV-RETE-ISS    PIC S9(009)V99  COMP-3.
           03 SV-RETE-PIS    PIC S9(009)V99  COMP-3.
           03 SV-COFINS      PIC S9(009)V99  COMP-3.
           03 SV-CSLL        PIC S9(009)V99  COMP-3.
           03 SV-CSER        PIC S9(004)     COMP-5.
           03 SV-VALO-SERV   PIC S9(009)V99  COMP-3.
           03 SV-VALO-MATE   PIC S9(009)V99  COMP-3.
           03 SV-PERC-SERV   PIC S9(003)V99  COMP-3.
           03 SV-DECL-SIMP   PIC  X(001)           .
           03 SV-DECL-EMPR   PIC  X(001)           .
           03 SV-PROF-REGU   PIC  X(001)           .
           03 SV-MATE-ESPE   PIC  X(001)           .
           03 SV-PEDI        PIC S9(006)     COMP-5.
           03 SV-EXTE        PIC S9(001)     COMP-5.
           03 SV-PED2        PIC S9(006)     COMP-5.
           03 SV-EXT2        PIC S9(001)     COMP-5.
           03 SV-PED3        PIC S9(006)     COMP-5.
           03 SV-EXT3        PIC S9(001)     COMP-5.
           03 SV-PED4        PIC S9(006)     COMP-5.
           03 SV-EXT4        PIC S9(001)     COMP-5.
           03 SV-PED5        PIC S9(006)     COMP-5.
           03 SV-EXT5        PIC S9(001)     COMP-5.
           03 SV-PED6        PIC S9(006)     COMP-5.
           03 SV-EXT6        PIC S9(001)     COMP-5.
           03 SV-PED7        PIC S9(006)     COMP-5.
           03 SV-EXT7        PIC S9(001)     COMP-5.
           03 SV-PED8        PIC S9(006)     COMP-5.
           03 SV-EXT8        PIC S9(001)     COMP-5.
           03 SV-PED9        PIC S9(006)     COMP-5.
           03 SV-EXT9        PIC S9(001)     COMP-5.
           03 SV-PED10       PIC S9(006)     COMP-5.
           03 SV-EXT10       PIC S9(001)     COMP-5.
           03 SV-ABAT        PIC S9(012)V99  COMP-3.
           03 SV-ABAT-INIC   PIC  X(010)           .
           03 SV-ABAT-FINA   PIC  X(010)           .
           03 SV-QTD-COMB    PIC S9(007)V99  COMP-3.
           03 SV-VLR-COMB    PIC S9(007)V999 COMP-3.
           03 SV-COMP-ANO    PIC S9(004)     COMP-5.
           03 SV-COMP-MES    PIC S9(002)     COMP-5.
   EXEC SQL END DECLARE SECTION END-EXEC
*
 Linkage Section.
 Copy "..\copy\linkage.cpy".
 01 LK-Data-Inicial           Pic 9(008).
*
Screen section.
 Copy "..\copy\screen-pb.cpy".
*
 Procedure Division Using LK-Linkage, Lk-Data-Inicial.
 COPY "..\COPY\10000.MOD".
*
 Inicio.
   Display Floating Window, Size   25.00,
   Lines   5.00 Color 0257 System Menu Title-Bar
   Line    27.00, Col 110.00,
   Title "SERV (PROG920SQL)",
   Cell Height 15
   Cell Width   9
   Pop-Up Handle-TELA002.
   Display tela-tela002.
*
   Move "PROG920SQL" To WS-PROG
   Move 80           To WS-COL-SCREEN

   Move Spaces to PathSERV.
   String Lk-Unidade        Delimited By Size
          "\DADOS\SERV.DAT" Delimited By Size
          Into PathSERV
   End-String.
   OPEN Input SERV
   If Not valido-SERV
      Display message box "erro " stat-SERV
   End-if
*
   Display Tela-Tela002
*
   move 10000 to ww-iten
   compute perc-unit = ww-ITEN / 100
   Initialize SERV-Regi
   Start SERV Key is Not Less SERV-Key0
   READ SERV Next With no Lock
   Perform Until Not Valido-SERV
       If SERV-Entr Not < Lk-Data-Inicial
          MOVE SERV-FILI        TO  SV-FILI
          MOVE SERV-FORN        TO  SV-FORN
          MOVE SERV-NOTA        TO  SV-NOTA
          MOVE SERV-SERI        TO  SV-SERI
          IF SERV-EMIS > ZEROS
             STRING SERV-EMIS(1:4) DELIMITED BY SIZE
                    "-"            DELIMITED BY SIZE
                    SERV-EMIS(5:2) DELIMITED BY SIZE
                    "-"            DELIMITED BY SIZE
                    SERV-EMIS(7:2) DELIMITED BY SIZE
                    INTO SV-EMIS
             END-STRING
          ELSE
             MOVE "0000-00-00"  TO  SV-EMIS
          END-IF
          MOVE SERV-DESC        TO  SV-DESC
          MOVE SERV-FIXO        TO  SV-FIXO
          MOVE SERV-VALO        TO  SV-VALO
          MOVE SERV-IRRF        TO  SV-IRRF
          MOVE SERV-INSS        TO  SV-INSS
          MOVE SERV-LIQU        TO  SV-LIQU
          MOVE SERV-CONT        TO  SV-CONT
          IF SERV-ENTR > ZEROS
             STRING SERV-ENTR(1:4) DELIMITED BY SIZE
                    "-"            DELIMITED BY SIZE
                    SERV-ENTR(5:2) DELIMITED BY SIZE
                    "-"            DELIMITED BY SIZE
                    SERV-ENTR(7:2) DELIMITED BY SIZE
                    INTO SV-ENTR
             END-STRING
          ELSE
             MOVE "0000-00-00"  TO SV-ENTR
          END-IF
          MOVE SERV-CUST        TO  SV-CUST
          MOVE SERV-TIPO        TO  SV-TIPO
          MOVE SERV-RETE-ISS    TO  SV-RETE-ISS
          MOVE SERV-RETE-PIS    TO  SV-RETE-PIS
          MOVE SERV-COFINS      TO  SV-COFINS
          MOVE SERV-CSLL        TO  SV-CSLL
          MOVE SERV-CSER        TO  SV-CSER
          MOVE SERV-VALO-SERV   TO  SV-VALO-SERV
          MOVE SERV-VALO-MATE   TO  SV-VALO-MATE
          MOVE SERV-PERC-SERV   TO  SV-PERC-SERV
          MOVE SERV-DECL-SIMP   TO  SV-DECL-SIMP
          MOVE SERV-DECL-EMPR   TO  SV-DECL-EMPR
          MOVE SERV-PROF-REGU   TO  SV-PROF-REGU
          MOVE SERV-MATE-ESPE   TO  SV-MATE-ESPE
          MOVE SERV-PEDI        TO  SV-PEDI
          MOVE SERV-EXTE        TO  SV-EXTE
          MOVE SERV-PED2        TO  SV-PED2
          MOVE SERV-EXT2        TO  SV-EXT2
          MOVE SERV-PED3        TO  SV-PED3
          MOVE SERV-EXT3        TO  SV-EXT3
          MOVE SERV-PED4        TO  SV-PED4
          MOVE SERV-EXT4        TO  SV-EXT4
          MOVE SERV-PED5        TO  SV-PED5
          MOVE SERV-EXT5        TO  SV-EXT5
          MOVE SERV-PED6        TO  SV-PED6
          MOVE SERV-EXT6        TO  SV-EXT6
          MOVE SERV-PED7        TO  SV-PED7
          MOVE SERV-EXT7        TO  SV-EXT7
          MOVE SERV-PED8        TO  SV-PED8
          MOVE SERV-EXT8        TO  SV-EXT8
          MOVE SERV-PED9        TO  SV-PED9
          MOVE SERV-EXT9        TO  SV-EXT9
          MOVE SERV-PED10       TO  SV-PED10
          MOVE SERV-EXT10       TO  SV-EXT10
          MOVE SERV-ABAT        TO  SV-ABAT
          IF SERV-ABAT-INIC > ZEROS
             STRING SERV-ABAT-INIC(5:4) DELIMITED BY SIZE
                    "-"                 DELIMITED BY SIZE
                    SERV-ABAT-INIC(3:2) DELIMITED BY SIZE
                    "-"                 DELIMITED BY SIZE
                    SERV-ABAT-INIC(1:2) DELIMITED BY SIZE
                    INTO SV-ABAT-INIC
             END-STRING
          ELSE
             MOVE "0000-00-00"  TO SV-ABAT-INIC
          END-IF
          IF SERV-ABAT-FINA > ZEROS
             STRING SERV-ABAT-FINA(5:4) DELIMITED BY SIZE
                    "-"                 DELIMITED BY SIZE
                    SERV-ABAT-FINA(3:2) DELIMITED BY SIZE
                    "-"                 DELIMITED BY SIZE
                    SERV-ABAT-FINA(1:2) DELIMITED BY SIZE
                    INTO SV-ABAT-FINA
             END-STRING
          ELSE
             MOVE "0000-00-00"  TO SV-ABAT-FINA
          END-IF
          MOVE SERV-QTD-COMB    TO  SV-QTD-COMB
          MOVE SERV-VLR-COMB    TO  SV-VLR-COMB
          MOVE SERV-COMP-ANO    TO  SV-COMP-ANO
          MOVE SERV-COMP-MES    TO  SV-COMP-MES
          EXEC SQL WHENEVER SQLERROR GOTO ERROR-EXIT END-EXEC
          EXEC SQL
               INSERT INTO SERV
                          (SERV_FILI     ,
                           SERV_FORN     ,
                           SERV_NOTA     ,
                           SERV_SERI     ,
                           SERV_EMIS     ,
                           SERV_DESC     ,
                           SERV_FIXO     ,
                           SERV_VALO     ,
                           SERV_IRRF     ,
                           SERV_INSS     ,
                           SERV_LIQU     ,
                           SERV_CONT     ,
                           SERV_ENTR     ,
                           SERV_CUST     ,
                           SERV_TIPO     ,
                           SERV_RETE_ISS ,
                           SERV_RETE_PIS ,
                           SERV_COFINS   ,
                           SERV_CSLL     ,
                           SERV_CSER     ,
                           SERV_VALO_SERV,
                           SERV_VALO_MATE,
                           SERV_PERC_SERV,
                           SERV_DECL_SIMP,
                           SERV_DECL_EMPR,
                           SERV_PROF_REGU,
                           SERV_MATE_ESPE,
                           SERV_PEDI     ,
                           SERV_EXTE     ,
                           SERV_PED2     ,
                           SERV_EXT2     ,
                           SERV_PED3     ,
                           SERV_EXT3     ,
                           SERV_PED4     ,
                           SERV_EXT4     ,
                           SERV_PED5     ,
                           SERV_EXT5     ,
                           SERV_PED6     ,
                           SERV_EXT6     ,
                           SERV_PED7     ,
                           SERV_EXT7     ,
                           SERV_PED8     ,
                           SERV_EXT8     ,
                           SERV_PED9     ,
                           SERV_EXT9     ,
                           SERV_PED10    ,
                           SERV_EXT10    ,
                           SERV_ABAT     ,
                           SERV_ABAT_INIC,
                           SERV_ABAT_FINA,
                           SERV_QTD_COMB ,
                           SERV_VLR_COMB ,
                           SERV_COMP_ANO ,
                           SERV_COMP_MES)
               VALUES
                     (:SV-FILI     ,
                      :SV-FORN     ,
                      :SV-NOTA     ,
                      :SV-SERI     ,
                      :SV-EMIS     ,
                      :SV-DESC     ,
                      :SV-FIXO     ,
                      :SV-VALO     ,
                      :SV-IRRF     ,
                      :SV-INSS     ,
                      :SV-LIQU     ,
                      :SV-CONT     ,
                      :SV-ENTR     ,
                      :SV-CUST     ,
                      :SV-TIPO     ,
                      :SV-RETE-ISS ,
                      :SV-RETE-PIS ,
                      :SV-COFINS   ,
                      :SV-CSLL     ,
                      :SV-CSER     ,
                      :SV-VALO-SERV,
                      :SV-VALO-MATE,
                      :SV-PERC-SERV,
                      :SV-DECL-SIMP,
                      :SV-DECL-EMPR,
                      :SV-PROF-REGU,
                      :SV-MATE-ESPE,
                      :SV-PEDI     ,
                      :SV-EXTE     ,
                      :SV-PED2     ,
                      :SV-EXT2     ,
                      :SV-PED3     ,
                      :SV-EXT3     ,
                      :SV-PED4     ,
                      :SV-EXT4     ,
                      :SV-PED5     ,
                      :SV-EXT5     ,
                      :SV-PED6     ,
                      :SV-EXT6     ,
                      :SV-PED7     ,
                      :SV-EXT7     ,
                      :SV-PED8     ,
                      :SV-EXT8     ,
                      :SV-PED9     ,
                      :SV-EXT9     ,
                      :SV-PED10    ,
                      :SV-EXT10    ,
                      :SV-ABAT     ,
                      :SV-ABAT-INIC,
                      :SV-ABAT-FINA,
                      :SV-QTD-COMB ,
                      :SV-VLR-COMB ,
                      :SV-COMP-ANO ,
                      :SV-COMP-MES)
          END-EXEC
          Add 1 To int
          compute ws-calcula = int /100
          move ws-calcula to parte-valor
          if resto-valor = zeros
             display Tela001-nLabel-003
             exec sql
                  commit
             end-exec
             exec sql
                  DISCONNECT ALL
             end-exec
             EXEC SQL CONNECT TO "IGARASHIBA" user "root" using 'admin' END-EXEC
             EXEC USE IBICOARA END-EXEC
          end-if
          initialize ws-calcula
          compute ws-calcula = int / perc-unit
          move ws-calcula to parte-valor
          if resto-valor = zeros
             modify Progress-01, Value INT-VALOR
             modify Screen1-Fr-1, FILL-PERCENT INT-VALOR
          end-if
       End-if
       Read SERV Next With no Lock
   End-Perform
*
   exec sql
        commit
   end-exec
   Close SERV.
   Close Window Handle-TELA002.
   Exit Program .
*
 ERROR-EXIT.
     EXEC SQL WHENEVER SQLERROR CONTINUE END-EXEC.
    Display Message Box
       "SQL Error !"NEWLINE
       "       SQLCODE: " SQLCODE  OF SQLCA NEWLINE
       "       SQLSTATE: "SQLSTATE OF SQLCA NEWLINE
       "       SQLERRMC: "SQLERRMC OF SQLCA
       NEWLINE
       "Finalizando o Programa.".
    Close Window Handle-TELA002.
    Exit Program .
*
   Copy "..\copy\screen.cpy".
