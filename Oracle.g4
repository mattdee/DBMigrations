grammar Oracle;

sql_stmt: create_table_stmt | insert_stmt | select_stmt | ...;

create_table_stmt: 'CREATE' 'TABLE' ID '(' column_def (',' column_def)* ')' ;

insert_stmt: 'INSERT' 'INTO' ID '(' ID (',' ID)* ')' 'VALUES' '(' expr (',' expr)* ')' ;

select_stmt: 'SELECT' ('*' | select_list) 'FROM' table_name ;

...

ID: [a-zA-Z_][a-zA-Z0-9_]* ;
STRING: '\'' (~'\'')* '\'' ;
NUMERIC: [0-9]+ ;

