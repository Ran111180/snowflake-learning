-- Stored Procedure: SP_PATIENT_COUNT_SCHEDULED
-- Purpose: Wrapper SP called by the task; self-suspends after 2 runs
-- Database: LEARNING_DB | Schema: HEALTH_DATA

CREATE OR REPLACE PROCEDURE LEARNING_DB.HEALTH_DATA.SP_PATIENT_COUNT_SCHEDULED()
RETURNS VARCHAR
LANGUAGE SQL
AS
DECLARE
    run_count INT;
BEGIN
    -- Check how many times this has already run
    SELECT COUNT(*) INTO :run_count
    FROM LEARNING_DB.HEALTH_DATA.TASK_RUN_LOG
    WHERE TASK_NAME = 'TASK_PATIENT_COUNT';

    -- If already run 2 times, suspend the task and exit
    IF (:run_count >= 2) THEN
        ALTER TASK LEARNING_DB.HEALTH_DATA.TASK_PATIENT_COUNT SUSPEND;
        RETURN 'Task suspended after 2 runs.';
    END IF;

    -- Run the actual logic
    CALL LEARNING_DB.HEALTH_DATA.SP_PATIENT_COUNT_BY_FACILITY();

    -- Log this run
    INSERT INTO LEARNING_DB.HEALTH_DATA.TASK_RUN_LOG (TASK_NAME, STATUS)
    VALUES ('TASK_PATIENT_COUNT', 'SUCCESS');

    -- If this was the 2nd run, suspend
    IF (:run_count + 1 >= 2) THEN
        ALTER TASK LEARNING_DB.HEALTH_DATA.TASK_PATIENT_COUNT SUSPEND;
        RETURN 'Run #' || (:run_count + 1)::VARCHAR || ' complete. Task suspended (reached 2 runs).';
    END IF;

    RETURN 'Run #' || (:run_count + 1)::VARCHAR || ' complete.';
END;
