# Snowflake Learning - Health/SNF Data

SQL code for learning Snowflake with healthcare (Skilled Nursing Facility) test data.

## Structure

```
snowflake-learning/
├── stored_procedures/
│   ├── sp_patient_count_by_facility.sql   -- Main SP: patient count per facility → view
│   └── sp_patient_count_scheduled.sql     -- Wrapper SP: self-suspends after 2 runs
├── tasks/
│   └── task_patient_count.sql             -- Task: runs every 5 mins
└── README.md
```

## Objects Created

| Object | Type | Purpose |
|--------|------|---------|
| `LEARNING_DB` | Database | Learning environment |
| `HEALTH_DATA` | Schema | Health/SNF data |
| `SP_PATIENT_COUNT_BY_FACILITY` | Stored Procedure | Counts patients per facility, stores in view |
| `SP_PATIENT_COUNT_SCHEDULED` | Stored Procedure | Wrapper with auto-suspend logic |
| `TASK_PATIENT_COUNT` | Task | Runs every 5 min, stops after 2 executions |
| `VW_PATIENT_COUNT_BY_FACILITY` | View | Output: facility name + patient count |
| `TASK_RUN_LOG` | Table | Tracks task execution count |
