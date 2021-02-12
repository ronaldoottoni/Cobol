       Identification Division
       Program-Id. CRYPTO.
       Author. RONALDO OTTONI.
      
       Data Division.
       Working-Storage Section.
       01 Cripto.
           05 BYTE-SENHA       PIC 9(02) COMP-X OCCURS 10.

       01 Counter              PIC 9(02) Value Zeros.
      
       Procedure Division.
        Display "Encriptando a palavra Teste"

        Move "Teste" To Cripto
           
        Perform Varying Counter From 1 By 1 Until Counter > 10
            Add 5       To Byte-Senha(Counter)
            Add Counter To Byte-Senha(Counter)
        End-Perform
           
        Display "Palavra Encriptada: " Cripto.

        Move zeros to Counter
        Perform Varying Counter From 1 By 1 Until Counter > 10
            Subtract 5       From Byte-Senha(Counter)
            Subtract Counter From Byte-Senha(Counter)
        End-Perform

        Display "Palavra Decriptada: " Cripto.
           
        Stop Run.
