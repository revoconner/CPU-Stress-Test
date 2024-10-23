       IDENTIFICATION DIVISION.
       PROGRAM-ID. CPU-STRESS.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       77 TIME-STRESS          PIC 9(5) VALUE 0.
       77 CORES-STRESS         PIC 9(3) VALUE 0.
       77 I                    PIC 9(3) VALUE 0.
       77 J                    PIC 9(3) VALUE 0.
       77 SECONDS              PIC 9(5) VALUE 0.
       77 TERMINATION          PIC X(3) VALUE 'NO'.
       77 F                    PIC 9(9)V9999 VALUE 46643.
       77 ONE-SECOND           PIC 9(5) VALUE 1000.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           DISPLAY "Enter the time in seconds for which you want to stress the CPU: "
           ACCEPT TIME-STRESS.
           DISPLAY "Enter the number of cores (logical cores if multithreaded) you want to stress: "
           ACCEPT CORES-STRESS.

           IF TIME-STRESS IS NUMERIC AND CORES-STRESS IS NUMERIC
               MOVE FUNCTION NUMVAL (TIME-STRESS) TO TIME-STRESS
               MOVE FUNCTION NUMVAL (CORES-STRESS) TO CORES-STRESS
           ELSE
               DISPLAY "Error: Invalid input"
               STOP RUN
           END-IF.

           DISPLAY "Starting test...".
           
           PERFORM VARYING SECONDS FROM 1 BY 1 UNTIL SECONDS > TIME-STRESS
               PERFORM STRESSER
               CALL "CBL_DELAY" USING ONE-SECOND
               DISPLAY "Time elapsed in seconds - " SECONDS
           END-PERFORM.

           DISPLAY "Terminating test.".
           ACCEPT TERMINATION FROM CONSOLE.

           STOP RUN.

       STRESSER SECTION.
           PERFORM UNTIL TERMINATION = 'YES'
               COMPUTE F = F * 46643 + 754276
           END-PERFORM.
           EXIT.
