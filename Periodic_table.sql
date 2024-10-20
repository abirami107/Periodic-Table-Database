psql


camper: /project$  psql --username=freecodecamp --dbname=periodic_table
psql (12.17 (Ubuntu 12.17-1.pgdg22.04+1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

periodic_table=>  \d
             List of relations
 Schema |    Name    | Type  |    Owner     
--------+------------+-------+--------------
 public | elements   | table | freecodecamp
 public | properties | table | freecodecamp
(2 rows)

periodic_table=>  select * from elements;
periodic_table=>  \d properties
periodic_table=>  \d elements
                        Table "public.elements"
    Column     |         Type          | Collation | Nullable | Default 
---------------+-----------------------+-----------+----------+---------
 atomic_number | integer               |           | not null | 
 symbol        | character varying(2)  |           |          | 
 name          | character varying(40) |           |          | 
Indexes:
    "elements_pkey" PRIMARY KEY, btree (atomic_number)
    "elements_atomic_number_key" UNIQUE CONSTRAINT, btree (atomic_number)

periodic_table=> 
periodic_table=> 
periodic_table=> 
periodic_table=> 
periodic_table=> ALTER TABLE properties RENAME weight TO atomic_mass;
ALTER TABLE
periodic_table=>  \d properties
periodic_table=>  ALTER TABLE properties RENAME melting_point TO melting_point_celsius;
ALTER TABLE
periodic_table=>  ALTER TABLE properties RENAME boiling_point TO boilling_point_celsius;
ALTER TABLE
periodic_table=> \d properties
periodic_table=> ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE
periodic_table=>  ALTER TABLE properties RENAME boilling_point_celsius TO boiling_point_celsius ;
ALTER TABLE
periodic_table=> ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;
ALTER TABLE
periodic_table=> ALTER TABLE elements ADD UNIQUE(symbol);
ALTER TABLE
periodic_table=> ALTER TABLE elements ADD UNIQUE(name);
ALTER TABLE
periodic_table=> \d elements
periodic_table=> ALTER TABLE elements ALTER COLUMN name SET NOT NULL;
ALTER TABLE
periodic_table=>  ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE
periodic_table=> ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number);
ALTER TABLE
periodic_table=> CREATE TABLE types(types_id SERIAL NOT NULL);
CREATE TABLE
periodic_table=> \d types
                                Table "public.types"
  Column  |  Type   | Collation | Nullable |                 Default                 
----------+---------+-----------+----------+-----------------------------------------
 types_id | integer |           | not null | nextval('types_types_id_seq'::regclass)

periodic_table=> \d properties
periodic_table=> select * from properties;
periodic_table=>  ALTER TABLE types ADD COLUMN type VARCHAR(20) NOT NULL;
ALTER TABLE
periodic_table=>  INSERT INTO types(type) VALUES('nonmetal'),('metal'),('metalloid');
INSERT 0 3
periodic_table=> select * from types;
 types_id |   type    
----------+-----------
        1 | nonmetal
        2 | metal
        3 | metalloid
(3 rows)

periodic_table=>  ALTER TABLE types ADD PRIMARY KEY(type_id);
ERROR:  column "type_id" of relation "types" does not exist
periodic_table=>  \d types
                                       Table "public.types"
  Column  |         Type          | Collation | Nullable |                 Default                 
----------+-----------------------+-----------+----------+-----------------------------------------
 types_id | integer               |           | not null | nextval('types_types_id_seq'::regclass)
 type     | character varying(20) |           | not null | 

periodic_table=>  ALTER TABLE types RENAME types_id TO type_id;
ALTER TABLE
periodic_table=> \d types
                                       Table "public.types"
 Column  |         Type          | Collation | Nullable |                 Default                 
---------+-----------------------+-----------+----------+-----------------------------------------
 type_id | integer               |           | not null | nextval('types_types_id_seq'::regclass)
 type    | character varying(20) |           | not null | 

periodic_table=>  ALTER TABLE types ADD PRIMARY KEY(type_id);
ALTER TABLE
periodic_table=>  \d types
                                       Table "public.types"
 Column  |         Type          | Collation | Nullable |                 Default                 
---------+-----------------------+-----------+----------+-----------------------------------------
 type_id | integer               |           | not null | nextval('types_types_id_seq'::regclass)
 type    | character varying(20) |           | not null | 
Indexes:
    "types_pkey" PRIMARY KEY, btree (type_id)

periodic_table=> ALTER TABLE properties ADD COLUMN type_id INT REFERENCES types(type_id);
ALTER TABLE
periodic_table=>  select * from properties;
periodic_table=> 
periodic_table=> UPDATE properties SET type_id=1 WHERE type='nonmetal';
UPDATE 5
periodic_table=>  select * from properties;
periodic_table=> UPDATE properties SET type_id=2 WHERE type='metal';
UPDATE 2
periodic_table=> UPDATE properties SET type_id=3 WHERE type='metalloid';
UPDATE 2
periodic_table=> select * from types;
 type_id |   type    
---------+-----------
       1 | nonmetal
       2 | metal
       3 | metalloid
(3 rows)

periodic_table=>  select * from properties;
periodic_table=>  ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;
ALTER TABLE
periodic_table=> select * from elements;
periodic_table=> 
periodic_table=>  UPDATE elements SET symbol = 'He' WHERE symbol = 'he';
UPDATE 1
periodic_table=> UPDATE elements SET symbol = 'Li' WHERE symbol = 'li';
UPDATE 1
periodic_table=>  UPDATE elements SET symbol = 'Mt' WHERE symbol = 'mT';
UPDATE 1
periodic_table=> select * from properties;
periodic_table=>  ALTER TABLE properties ALTER COLUMN atomic_mass SET DATA TYPE numeric(9,1);
ALTER TABLE
periodic_table=>  \d properties
periodic_table=>  ALTER TABLE properties ALTER COLUMN atomic_mass SET DATA TYPE DECIMAL;
ALTER TABLE
periodic_table=>  select * from properties;
periodic_table=>  ALTER TABLE properties ALTER COLUMN atomic_mass SET DATA TYPE DECIMAL(9,0);
ALTER TABLE
periodic_table=> ALTER TABLE properties ALTER COLUMN atomic_mass SET DATA TYPE DECIMAL;
ALTER TABLE
periodic_table=> 
periodic_table=> select * from properties;
periodic_table=>  UPDATE properties SET atomic_mass = 15 WHERE atomic_number = 8;
UPDATE 1
periodic_table=>  INSERT INTO elements(atomic_number, symbol, name) VALUES(9, 'F', 'Fluorine');
INSERT 0 1
periodic_table=>  INSERT INTO elements(atomic_number, symbol, name) VALUES(10, 'Ne', 'Neon');
INSERT 0 1
periodic_table=>  INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(9, 'nonmetal', 18.998, -220, -188.1, 1);
INSERT 0 1
periodic_table=>  INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(10, 'nonmetal', 20.18, -248.6, -246.1, 1);
INSERT 0 1
periodic_table=> 
periodic_table=> ALTER TABLE properties DROP COLUMN type;
ALTER TABLE
periodic_table=>  select * from properties;
periodic_table=> UPDATE properties SET atomic_mass = 1.008 WHERE atomic_number=1;
UPDATE 1
periodic_table=>  select * from properties;
periodic_table=>  DELETE FROM properties WHERE atomic_number=1000;
DELETE 1
periodic_table=>  DELETE FROM elements WHERE atomic_number=1000;
DELETE 1
periodic_table=> ALTER TABLE properties DROP COLUMN type;
ERROR:  column "type" of relation "properties" does not exist
periodic_table=> select * from properties;
periodic_table=> select * from properties;
periodic_table=> UPDATE properties SET atomic_mass = 1.008 WHERE atomic_number =1;
UPDATE 1
periodic_table=> select * from properties;
periodic_table=> DELETE FROM properties WHERE atomic_number=1000;
DELETE 0
periodic_table=> select * from elements;
 atomic_number | symbol |   name    
---------------+--------+-----------
             1 | H      | Hydrogen
             4 | Be     | Beryllium
             5 | B      | Boron
             6 | C      | Carbon
             7 | N      | Nitrogen
             8 | O      | Oxygen
             2 | He     | Helium
             3 | Li     | Lithium
             9 | F      | Fluorine
            10 | Ne     | Neon
(10 rows)


bash terminal

camper: /project$ mkdir periodic_table
camper: /project$  cd periodic_table/
camper: /periodic_table$ git init
hint: Using 'master' as the name for the initial branch. This default branch name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint: 
hint:   git config --global init.defaultBranch <name>
hint: 
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint: 
hint:   git branch -m <name>
Initialized empty Git repository in /workspace/project/periodic_table/.git/
camper: /periodic_table$ git branch
camper: /periodic_table$ touch element.sh
camper: /periodic_table$  git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        element.sh

nothing added to commit but untracked files present (use "git add" to track)
camper: /periodic_table$  git branch
camper: /periodic_table$ git add .
camper: /periodic_table$ git commit -m "Initial commit"
[master (root-commit) e972dad] Initial commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 element.sh
camper: /periodic_table$ git branch
* master
camper: /periodic_table$ git branch main
camper: /periodic_table$ chmod +x element.sh
camper: /periodic_table$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   element.sh

no changes added to commit (use "git add" and/or "git commit -a")
camper: /periodic_table$ git add .
camper: /periodic_table$ git commit -m "feat: add database connection"
[master 4b9f291] feat: add database connection
 1 file changed, 3 insertions(+)
 mode change 100644 => 100755 element.sh
camper: /periodic_table$ ./element.sh 5
./element.sh: line 12: syntax error near unexpected token `else'
./element.sh: line 12: `     else'
camper: /periodic_table$ ./element.sh 5
Please provide element as an argument.
camper: /periodic_table$ ./element.sh 5
5
camper: /periodic_table$ ./element.sh 5
5 hello
camper: /periodic_table$ ./element.sh
 hello
camper: /periodic_table$ ./element.sh
 hello
camper: /periodic_table$ ./element.sh
camper: /periodic_table$ ./element.sh
Please provide element as an argument.
camper: /periodic_table$ ./element.sh 5
5
camper: /periodic_table$ man test
camper: /periodic_table$ ./element.sh 1
./element.sh: line 7: syntax error in conditional expression
./element.sh: line 8: syntax error near `then'
./element.sh: line 8: `     then'
camper: /periodic_table$ ./element.sh 1
./element.sh: line 7: syntax error in conditional expression
./element.sh: line 8: syntax error near `then'
./element.sh: line 8: `     then'
camper: /periodic_table$ ./element.sh 1
./element.sh: line 7: syntax error in conditional expression
./element.sh: line 8: syntax error near `then'
./element.sh: line 8: `     then'
camper: /periodic_table$ ./element.sh 1
./element.sh: line 7: syntax error in conditional expression
./element.sh: line 8: syntax error near `then'
./element.sh: line 8: `   then'
camper: /periodic_table$ ./element.sh 1
./element.sh: line 7: syntax error in conditional expression
./element.sh: line 8: syntax error near `then'
./element.sh: line 8: `  then'
camper: /periodic_table$ ./element.sh 1
./element.sh: line 7: syntax error in conditional expression
./element.sh: line 8: syntax error near `then'
./element.sh: line 8: `    then'
camper: /periodic_table$ ./element.sh 1
./element.sh: line 16: syntax error near unexpected token `then'
./element.sh: line 16: `      then'
camper: /periodic_table$ ./element.sh 1
./element.sh: line 16: syntax error near unexpected token `then'
./element.sh: line 16: `    then'
camper: /periodic_table$ ./element.sh 1
1|1.008|-259.1|-252.9|H|Hydrogen|nonmetal
camper: /periodic_table$ git add .
camper: /periodic_table$ git commit -m "feat: bring element"
[master 13b83ac] feat: bring element
 1 file changed, 27 insertions(+)
camper: /periodic_table$ git add .
camper: /periodic_table$ git commit -m "fix: bring separated data"
[master e187e6a] fix: bring separated data
 1 file changed, 2 insertions(+), 2 deletions(-)
camper: /periodic_table$ git checkout main
Switched to branch 'main'
camper: /periodic_table$ git merge master
Updating e972dad..e187e6a
Fast-forward
 element.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 mode change 100644 => 100755 element.sh
camper: /periodic_table$ git status
On branch main
nothing to commit, working tree clean
camper: /periodic_table$ git add .
camper: /periodic_table$ git commit -m "feat: bring data"
[main 0cbe247] feat: bring data
 1 file changed, 2 insertions(+), 2 deletions(-)
camper: /periodic_table$ ./element.sh 2
The element with atomic number 2  is Helium (He). It's a nonmetal, with a mass of  4 1.008 amu. Helium has a melting point of -272.2 celsius and a boiling point of -269 celsius.
camper: /periodic_table$ ./element.sh 1
The element with atomic number 1  is Hydrogen (H). It's a nonmetal, with a mass of  1.008 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
camper: /periodic_table$ ./element.sh H
The element with atomic number 1  is Hydrogen (H). It's a nonmetal, with a mass of  1.008 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
camper: /periodic_table$ ./element.sh
Please provide element as an argument.
camper: /periodic_table$ git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   element.sh

no changes added to commit (use "git add" and/or "git commit -a")
camper: /periodic_table$ man test
camper: /periodic_table$ git log
commit 0cbe247721a440973d449fffd775d26c19aad4c5 (HEAD -> main)
Author: abirami107 b <abiramibalasubramaniyan80@gmail.com>
Date:   Sun Oct 20 14:52:22 2024 +0000

    feat: bring data

commit e187e6ad66ad8f3534220dc5609a85766f2be3b0 (master)
Author: abirami107 b <abiramibalasubramaniyan80@gmail.com>
Date:   Sun Oct 20 14:37:21 2024 +0000

    fix: bring separated data

commit 13b83ac8aec78e9fca9e185cc18ac0ac57256bf3
Author: abirami107 b <abiramibalasubramaniyan80@gmail.com>
Date:   Sun Oct 20 14:33:38 2024 +0000

    feat: bring element

commit 4b9f291b7bac48c64dc12e514d3c93d8e6798f67
Author: abirami107 b <abiramibalasubramaniyan80@gmail.com>
Date:   Sun Oct 20 13:48:07 2024 +0000

    feat: add database connection

commit e972dad282663e65321e75ba2eeff6671a9ac79e
Author: abirami107 b <abiramibalasubramaniyan80@gmail.com>
Date:   Sun Oct 20 13:39:27 2024 +0000

    Initial commit
camper: /periodic_table$ chmod +x element.sh
camper: /periodic_table$ git branch
* main
  master
camper: /periodic_table$ git checkout main
M       element.sh
Already on 'main'
camper: /periodic_table$ git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   element.sh

no changes added to commit (use "git add" and/or "git commit -a")
camper: /periodic_table$ git add element.sh
camper: /periodic_table$ git commit -m "fix: Finalize database schema and constraints"
[main c1bfc78] fix: Finalize database schema and constraints
 1 file changed, 7 insertions(+), 9 deletions(-)
camper: /periodic_table$ git status
On branch main
nothing to commit, working tree clean
