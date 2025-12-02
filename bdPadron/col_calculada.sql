USE bdPadron;

ALTER TABLE taPoblacion
ADD COLUMN iPoblacion INTEGER AS (iHombres + iMujeres) VIRTUAL;
-- ADD COLUMN iPoblacion INTEGER AS (iHombres + iMujeres) STORED;
