grammar Oracle;

// Define tokens
ID: [a-zA-Z_][a-zA-Z0-9_]* ;
INTEGER: [0-9]+ ;
FLOAT: [0-9]+ '.' [0-9]* ;
STRING: '\'' (~'\'')* '\'' ;
WS: [ \t\r\n]+ -> skip ; // Skip whitespace

// Define rules for SQL statements

sql_stmt: create_table_stmt | insert_stmt | select_stmt | update_stmt | delete_stmt ;

create_table_stmt: 'CREATE' 'TABLE' ID '(' column_def (',' column_def)* ')' ;

insert_stmt: 'INSERT' 'INTO' ID ('(' ID (',' ID)* ')')? 'VALUES' '(' expr (',' expr)* ')' ;

select_stmt: 'SELECT' ( '*' | select_list ) 'FROM' from_list (where_clause)? (order_by_clause)? (limit_clause)? ;

update_stmt: 'UPDATE' ID 'SET' set_list (where_clause)? ;

delete_stmt: 'DELETE' 'FROM' ID (where_clause)? ;

// Define rules for expressions and clauses

select_list: expr (',' expr)* ;

from_list: ID (',' ID)* ;

where_clause: 'WHERE' condition ;

order_by_clause: 'ORDER BY' ID ('ASC' | 'DESC')? (',' ID ('ASC' | 'DESC')?)* ;

limit_clause: 'FETCH FIRST' INTEGER 'ROWS ONLY' ;

set_list: set_item (',' set_item)* ;

set_item: ID '=' expr ;

// Define rules for expressions

expr: ID
    | INTEGER
    | FLOAT
    | STRING
    | expr ('+' | '-' | '*' | '/') expr // arithmetic expressions
    | '(' expr ')' // nested expressions
    | ID '.' ID // column reference
    | ID '(' (expr (',' expr)*)? ')' // function call
    | 'CASE' (when_clause)+ ('ELSE' expr)? 'END' // CASE expression
    ;

when_clause: 'WHEN' condition 'THEN' expr ;

condition: expr ('=' | '!=' | '<>' | '<' | '<=' | '>' | '>=') expr ;

// Other Oracle-specific elements can be added as needed

