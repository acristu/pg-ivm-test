```sql

-- create a table to use as a basis for views and materialized views in various combinations
CREATE TABLE mv_base_a (i int, j int);
INSERT INTO mv_base_a VALUES
  (1,10),
  (2,20),
  (3,30),
  (4,40),
  (5,50);
CREATE TABLE mv_base_b (i int, k int);
INSERT INTO mv_base_b VALUES
  (1,101),
  (2,102),
  (3,103),
  (4,104);


-- support chained incremental materialized views
BEGIN;
CREATE INCREMENTAL MATERIALIZED VIEW mv_ivm_agg AS SELECT i, SUM(j) as s FROM mv_base_a GROUP BY i;
CREATE INCREMENTAL MATERIALIZED VIEW mv_ivm_chain AS SELECT a.i, v.s FROM mv_base_a a INNER JOIN mv_ivm_agg v ON a.i = v.i;
SELECT * FROM mv_ivm_agg ORDER BY 1,2;
SELECT * FROM mv_ivm_chain ORDER BY 1,2;
INSERT INTO mv_base_a VALUES(2,100);
SELECT * FROM mv_ivm_agg ORDER BY 1,2;
SELECT * FROM mv_ivm_chain ORDER BY 1,2;
ROLLBACK;

```