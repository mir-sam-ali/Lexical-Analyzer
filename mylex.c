#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "mylex.h"

extern int yylex();
extern int yylineno;
extern char *yytext;
const int MAX = 100;

struct Node
{
    /* data */
    char *token_name, *lexeme;
    int lineNo;
    struct Node *next;
};

struct Node *head[MAX];

int HASH(char *lexeme)
{

    int sum = 0;
    int i = 0;

    while (lexeme[i] != '\0')
    {
        sum = sum + lexeme[i];

        i++;
    }

    return (sum % 100);
}

void printSymbolTable()
{
    printf("\n\n\t **** SYMBOL TABLE *****\n\n");
    for (int i = 0; i < MAX; i++)
    {
        if (head[i] != NULL)
        {
            struct Node *temp = head[i];
            while (temp != NULL)
            {
                printf("Token Name:\t%s\n", temp->token_name);
                printf("Lexeme:\t\t%s\n", temp->lexeme);
                printf("Line No.:\t%d\n\n", temp->lineNo);
                printf("#######################\n\n");
                temp = temp->next;
            }
        }
    }
}

// Function to find an identifier
int lookUp(char *lexeme)
{
    int index = HASH(lexeme);
    struct Node *start = head[index];

    if (start == NULL)
        return -1;

    while (start != NULL)
    {

        if (strcmp(start->lexeme, lexeme) == 0)
        {
            //found
            return 1;
        }

        start = start->next;
    }

    return -1; // not found
}

char *copyString(char *lexeme)
{
    int length = 0;
    while (lexeme[length] != '\0')
    {
        length++;
    }
    char *copy = (char *)malloc(sizeof(char) * length);
    int i = 0;
    while (lexeme[i] != '\0')
    {
        copy[i] = lexeme[i];
        i++;
    }
    return copy;
}

// Function to insert a token
void insert(char *token_name, char *lexeme,
            int lineno)
{

    int index = HASH(lexeme);

    struct Node *p = (struct Node *)malloc(sizeof(struct Node));
    p->token_name = token_name;

    p->lexeme = copyString(lexeme);

    p->lineNo = lineno;
    p->next = NULL;

    if (head[index] == NULL)
    {
        head[index] = p;
    }

    else
    {

        struct Node *start = head[index];
        while (start->next != NULL)
            start = start->next;

        start->next = p;
    }
}

// Driver code
int main()
{

    int ntoken;

    ntoken = yylex();

    while (ntoken)
    {
        switch (ntoken)
        {
        case INTEGER_LITERAL:
        {

            insert("INTEGER", yytext, yylineno);
            break;
        }
        case FLOAT_LITERAL:
        {

            insert("FLOATING POINT", yytext, yylineno);
            break;
        }
        case CHAR_LITERAL:
        {

            insert("CHARACTER", yytext, yylineno);
            break;
        }
        case STRING_LITERAL:
        {

            insert("STRING", yytext, yylineno);
            break;
        }
        case BOOLEAN_LITERAL:
        {

            insert("BOOLEAN", yytext, yylineno);
            break;
        }
        case IDENTIFIER:
        {

            // lookUp checks if yytext is already declared!
            if (lookUp(yytext) == -1)
            {
                insert("IDENTIFIER", yytext, yylineno);
            }

            break;
        }
        case NULL_LITERAL:
        {
            insert("NULL", yytext, yylineno);
            break;
        }

        default:
        {

            break;
        }
        }
        ntoken = yylex();
    }
    printSymbolTable();
}
