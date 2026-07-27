# Snowflake Learning - Health/SNF Data

SQL code for learning Snowflake with healthcare (Skilled Nursing Facility) test data and credit monitoring.

## Structure

```
snowflake-learning/
├── stored_procedures/
│   ├── sp_patient_count_by_facility.sql   -- Main SP: patient count per facility → view
│   └── sp_patient_count_scheduled.sql     -- Wrapper SP: self-suspends after 2 runs
├── tasks/
│   └── task_patient_count.sql             -- Task: runs every 5 mins
├── monitoring/
│   ├── resource_monitor.sql               -- 400 credit budget with suspend triggers
│   ├── monitoring_views.sql               -- Views: usage by warehouse, task, budget %
│   └── email_alert.sql                    -- Email alert when usage > 30%
└── README.md
```

## Objects Created

### Health Data (LEARNING_DB.HEALTH_DATA)

| Object | Type | Purpose |
|--------|------|---------|
| `SP_PATIENT_COUNT_BY_FACILITY` | Stored Procedure | Counts patients per facility, stores in view |
| `SP_PATIENT_COUNT_SCHEDULED` | Stored Procedure | Wrapper with auto-suspend logic |
| `TASK_PATIENT_COUNT` | Task | Runs every 5 min, stops after 2 executions |
| `VW_PATIENT_COUNT_BY_FACILITY` | View | Output: facility name + patient count |
| `TASK_RUN_LOG` | Table | Tracks task execution count |

### Monitoring (LEARNING_DB.MONITORING)

| Object | Type | Purpose |
|--------|------|---------|
| `LEARNING_MONITOR` | Resource Monitor | 400 credit/month, notify at 30%/50%, suspend at 90% |
| `VW_CREDIT_USAGE_BY_WAREHOUSE` | View | Daily credit usage per warehouse (last 30 days) |
| `VW_CREDIT_BUDGET_STATUS` | View | Budget % used vs remaining |
| `VW_CREDIT_USAGE_BY_TASK` | View | Credit usage by serverless task |
| `VW_TOP_CREDIT_CONSUMERS` | View | Combined ranking: warehouses + tasks |
| `ALERT_CREDIT_USAGE` | Alert | Emails when usage exceeds 30% (checks hourly) |
