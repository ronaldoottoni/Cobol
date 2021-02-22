    IDENTIFICATION DIVISION.
    PROGRAM-ID. CONDITIONALS.
    DATA DIVISION.
      WORKING-STORAGE SECTION.
        01 NUM1 PIC 9(9).
        01 NUM2 PIC 9(9).
        01 NUM3 PIC 9(5).
        01 NUM4 PIC 9(6).

        01 NEG-NUM PIC S9(9) VALUE -1234.

        01 CLASS1 PIC X(9) VALUE 'ABCD '.

        *> Tipo de Variavel que utiliza valores pre-fixados
        *> para serem utilizados como validação booleana
        *> qualquer numero entre 000 e 040 retorna FAIL
        *> qualquer numero entre 041 e 100 retorna PASS
        01 CHECK-VAL PIC 9(3).
            88 PASS VALUES ARE 041 THRU 100.
            88 FAIL VALUES ARE 000 THRU 40.

    PROCEDURE DIVISION.
      MOVE 25 TO NUM1 NUM3.
      MOVE 15 TO NUM2 NUM4.
      *> compara 2 números e verifica se são iguais
      IF NUM1 > NUM2 THEN
        DISPLAY 'LOOP 1 - IF BLOCK'
        IF NUM3 = NUM4 THEN
          DISPLAY 'LOOP 2 - IF BLOCK'
        ELSE
          DISPLAY 'LOOP 2 - ELSE BLOCK'
        END-IF
      ELSE
        DISPLAY 'LOOP 1 -ELSE BLOCK'
      END-IF

    *> Utiliza as condicoes customizadas pre-definidas
    *> para checar utilizando CHECK-VAL
      MOVE 65 TO CHECK-VAL.
      IF PASS
        DISPLAY 'PASSED COM NUMERO 'CHECK-VAL.
      IF FAIL
        DISPLAY 'FAILED COM NUMERO 'CHECK-VAL.

    *> Condicional Switch
      EVALUATE TRUE
        WHEN NUM1 < 2
          DISPLAY 'NUM1 MENOR QUE 2'
        WHEN NUM1 < 19
          DISPLAY 'NUM1 MENOR QUE 19'
        WHEN NUM1 < 1000
          DISPLAY 'NUM1 MENOR QUE 1000'
      END-EVALUATE.

      *> NOT, Negando uma condição
      MOVE 50 TO NUM1.
      MOVE 60 TO NUM2.
      IF NOT NUM2 IS LESS THAN NUM1 THEN
        DISPLAY NUM2' NÃO É MENOR QUE 'NUM1
      END-IF

      *> AND, comparando multiplas possibilidades
      IF NUM1 IS LESS THAN NUM2 AND NUM1 IS LESS THAN 100 THEN
         DISPLAY 'CONDIÇÃO COMBINADA'
      ELSE
         DISPLAY 'MULTIPLAS CONDIÇÕES FALHARAM'
      END-IF

      *> Verificando se o valor e positivo ou negativo
      IF NEG-NUM IS POSITIVE OR NEG-NUM IS NEGATIVE THEN
         DISPLAY 'A É NÚMERO POSITIVO'.

      *> Verificando se o valor e positivo ou negativo
      IF NEG-NUM IS NEGATIVE THEN
         DISPLAY 'A É NÚMERO NEGATIVO'.

      *> verificando se a variável é de um tipo específico de dados
      IF CLASS1 IS ALPHABETIC OR CLASS1 IS NUMERIC THEN
         DISPLAY 'CLASS1 É ALFABÉTICA OU NUMÉRICA'.
    STOP RUN.

