CREATE TABLE TWITTS
(
    USER_ID LONG NOT NULL,
    TWITT_ID LONG NOT NULL,
    CONTENT NVARCHAR,
    CREATION_TIME TIMESTAMP WITH TIME ZONE,
    CONSTRAINT TWITTS_PK PRIMARY KEY (USER_ID, TWITT_ID)
);