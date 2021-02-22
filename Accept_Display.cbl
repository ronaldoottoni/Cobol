IDENTIFICATION DIVISION.
PROGRAM-ID.  AcceptAndDisplay.

*> Usando o ACCEPT e DISPLAY para receber dados do estudante 
*> e mostrar alguns campos. Também mostrar como o ACCEPT
*> deve ser utilizado para pegar data e hora do sistema.

*> O formato YYYYMMDD no "ACCEPT  CurrentDate FROM DATE YYYYMMDD." 
*> é o formato do comando para informar que o ano deverá conter 4 digitos.
*> Se não for informado, o ano será fornecido pelo sistema terá
*> apenas 2 dígitos.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 StudentDetails.
   02  StudentId       PIC 9(7).
   02  StudentName.
       03 Surname      PIC X(8).
       03 Initials     PIC XX.
   02  CourseCode      PIC X(4).
   02  Gender          PIC X.

*> YYMMDD
01 CurrentDate.
   02  CurrentYear     PIC 9(4).
   02  CurrentMonth    PIC 99.
   02  CurrentDay      PIC 99.

*> YYDDD
01 DayOfYear.
   02  FILLER          PIC 9(4).
   02  YearDay         PIC 9(3).


*> HHMMSSss   s = S/100
01 CurrentTime.
   02  CurrentHour     PIC 99.
   02  CurrentMinute   PIC 99.
   02  FILLER          PIC 9(4).


PROCEDURE DIVISION.
Begin.
    DISPLAY "Informe os detalhes utilizando o TEMPLATE abaixo".
    DISPLAY "ID,Subrenome,Iniciais,Codigo do curso,Genero"
    DISPLAY "SSSSSSSNNNNNNNNIICCCCG".
    ACCEPT  StudentDetails.
    ACCEPT  CurrentDate FROM DATE YYYYMMDD.
    ACCEPT  DayOfYear FROM DAY YYYYDDD.
    ACCEPT  CurrentTime FROM TIME.
    DISPLAY "Nome é ", Initials SPACE Surname.
    DISPLAY "Data é " CurrentDay SPACE CurrentMonth SPACE CurrentYear.
    DISPLAY "Hoje é dia " YearDay " of the year".
    DISPLAY "A hora é " CurrentHour ":" CurrentMinute.

    STOP RUN.
