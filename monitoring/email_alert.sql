-- Email Alert: Credit usage notification
-- Checks every 60 minutes; sends email when usage exceeds 30% of 400 credits

-- Email notification integration
CREATE OR REPLACE NOTIFICATION INTEGRATION LEARNING_EMAIL_NOTIFICATION
    TYPE = EMAIL
    ENABLED = TRUE
    ALLOWED_RECIPIENTS = ('ranga.k565@gmail.com');

-- Alert: fires when monthly credits exceed 30% (120 credits)
CREATE OR REPLACE ALERT LEARNING_DB.MONITORING.ALERT_CREDIT_USAGE
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = '60 MINUTE'
    IF (EXISTS (
        SELECT 1
        FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
        WHERE START_TIME >= DATE_TRUNC('MONTH', CURRENT_TIMESTAMP())
        HAVING SUM(CREDITS_USED) > 120  -- 30% of 400
    ))
    THEN
        CALL SYSTEM$SEND_EMAIL(
            'LEARNING_EMAIL_NOTIFICATION',
            'ranga.k565@gmail.com',
            'Snowflake Credit Alert - Usage Over 30%',
            'Your Snowflake credit consumption has exceeded 30% of your 400 credit budget this month. Check LEARNING_DB.MONITORING.VW_CREDIT_BUDGET_STATUS for details.'
        );

-- Activate the alert
ALTER ALERT LEARNING_DB.MONITORING.ALERT_CREDIT_USAGE RESUME;
