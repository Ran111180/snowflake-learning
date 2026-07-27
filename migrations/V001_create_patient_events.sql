-- Migration V001: Create PATIENT_EVENTS table
-- Tracks real-time clinical events (vitals taken, meds given, falls, etc.)
-- Target: LEARNING_DB.HEALTH_DATA.PATIENT_EVENTS

CREATE TABLE IF NOT EXISTS HEALTH_DATA.PATIENT_EVENTS (
    EVENT_ID INT AUTOINCREMENT PRIMARY KEY,
    PATIENT_ID INT NOT NULL,
    FACILITY_ID INT NOT NULL,
    EVENT_TYPE VARCHAR(50) NOT NULL,
    EVENT_DESCRIPTION VARCHAR(500),
    SEVERITY VARCHAR(20) DEFAULT 'LOW',
    EVENT_TIMESTAMP TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    RECORDED_BY VARCHAR(100),
    CONSTRAINT FK_EVENTS_PATIENT FOREIGN KEY (PATIENT_ID) REFERENCES HEALTH_DATA.PATIENTS(PATIENT_ID),
    CONSTRAINT FK_EVENTS_FACILITY FOREIGN KEY (FACILITY_ID) REFERENCES HEALTH_DATA.FACILITIES(FACILITY_ID)
);

-- Insert test data
INSERT INTO HEALTH_DATA.PATIENT_EVENTS (PATIENT_ID, FACILITY_ID, EVENT_TYPE, EVENT_DESCRIPTION, SEVERITY, RECORDED_BY)
VALUES
(101, 1, 'FALL', 'Patient fell near bed, no injury', 'MEDIUM', 'Emily Garcia'),
(102, 2, 'VITAL_ALERT', 'BP reading 180/95 - above threshold', 'HIGH', 'Rachel Kim'),
(103, 3, 'MED_GIVEN', 'Albuterol nebulizer administered', 'LOW', 'Lisa Wong'),
(104, 4, 'THERAPY', 'PT session completed - 30 min', 'LOW', 'James Ortiz'),
(105, 5, 'VITAL_ALERT', 'O2 sat dropped to 88%', 'HIGH', 'Amy Ross'),
(106, 1, 'FALL', 'Found on floor near bathroom', 'HIGH', 'Emily Garcia'),
(107, 2, 'BEHAVIOR', 'Wandering in hallway at 2am', 'MEDIUM', 'Rachel Kim'),
(108, 3, 'MED_REFUSED', 'Patient refused morning medications', 'MEDIUM', 'Tom Harris'),
(109, 4, 'ADMISSION', 'New admission from General Hospital', 'LOW', 'Anna Lee'),
(110, 5, 'DISCHARGE', 'Discharged to home with PT services', 'LOW', 'Carlos Rivera');
