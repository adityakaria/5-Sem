DROP TABLE IF EXISTS Employee_2;
CREATE TABLE Employee_2 (
  Id varchar(10),
  Salary int(10),
  Position varchar(20),
  PRIMARY KEY (Id)
);
INSERT INTO Employee_2
VALUES
  (1, 25000, 'Manager');
INSERT INTO Employee_2
VALUES
  (2, 40000, 'VP-Ed');
INSERT INTO Employee_2
VALUES
  (3, 10000, 'Peon');
INSERT INTO Employee_2
VALUES
  (4, 30000, 'Trainer');
INSERT INTO Employee_2
VALUES
  (5, 10000000, 'CEO');
