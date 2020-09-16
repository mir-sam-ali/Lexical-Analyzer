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

// void Node_Initialization(struct Node *next)
// {
//     next = NULL;
// }

void Node_initialization(char *lexeme, char *token_name, int lineNo, struct Node *node)
{

    node->token_name = token_name;
    node->lexeme = lexeme;
    node->lineNo = lineNo;
    node->next = NULL;
}

void print(char *lexeme, char *token_name, int lineNo, struct Node *node)
{

    printf("Line Number:%d\t< %s , %s >\n", lineNo, token_name, lexeme);
}

/* data */
struct Node *head[MAX];

// public:
// SymbolTable()
// {
//     for (int i = 0; i < MAX; i++)
//         head[i] = NULL;
// }

// Function to modify an identifier
// bool SymbolTable::modify(string id, string s,
//                          string t, int l)
// {
//     int index = hashf(id);
//     Node *start = head[index];

//     if (start == NULL)
//         return "-1";

//     while (start != NULL)
//     {
//         if (start->identifier == id)
//         {
//             start->scope = s;
//             start->type = t;
//             start->lineNo = l;
//             return true;
//         }
//         start = start->next;
//     }

//     return false; // id not found
// }

// Function to delete an identifier
// bool SymbolTable::deleteRecord(string id)
// {
//     int index = hashf(id);
//     Node *tmp = head[index];
//     Node *par = head[index];

//     // no identifier is present at that index
//     if (tmp == NULL)
//     {
//         return false;
//     }
//     // only one identifier is present
//     if (tmp->identifier == id && tmp->next == NULL)
//     {
//         tmp->next = NULL;
//         delete tmp;
//         return true;
//     }

//     while (tmp->identifier != id && tmp->next != NULL)
//     {
//         par = tmp;
//         tmp = tmp->next;
//     }
//     if (tmp->identifier == id && tmp->next != NULL)
//     {
//         par->next = tmp->next;
//         tmp->next = NULL;
//         delete tmp;
//         return true;
//     }

//     // delete at the end
//     else
//     {
//         par->next = NULL;
//         tmp->next = NULL;
//         delete tmp;
//         return true;
//     }
//     return false;
// }

int hashf(char *lexeme)
{
    printf("HASHING...%s\n", lexeme);
    int sum = 0;
    int i = 0;

    while (lexeme[i] != '\0')
    {
        sum = sum + lexeme[i];

        i++;
    }

    return (sum % 100);
}

// Function to find an identifier
int find(char *lexeme)
{
    printf("FINDING...\n");
    int index = hashf(lexeme);
    struct Node *start = head[index];

    if (start == NULL)
        return -1;

    while (start != NULL)
    {
        printf("%s %s\n", start->lexeme, start->token_name);
        if (strcmp(start->lexeme, lexeme) == 0)
        {
            return 1;
        }

        start = start->next;
    }

    return -1; // not found
}

// Function to insert an identifier
int insert(char *token_name, char *lexeme,
           int lineno)
{
    printf("INSERTING...\n");
    int index = hashf(lexeme);

    struct Node *p = (struct Node *)malloc(sizeof(struct Node));
    p->token_name = token_name;

    p->lexeme = lexeme;
    printf("HASH: %s\n", p->lexeme);
    p->lineNo = lineno;
    p->next = NULL;

    if (head[index] == NULL)
    {
        head[index] = p;
        return 1;
    }

    else
    {
        struct Node *start = head[index];
        while (start->next != NULL)
            start = start->next;

        start->next = p;

        return 1;
    }

    return -1;
}

void init()
{
    for (int i = 0; i < MAX; i++)
    {
        head[i] = NULL;
    }
}

// Driver code
int main()
{
    init();
    printf("**** SYMBOL_TABLE ****\n");
    int ntoken, vtoken;

    ntoken = yylex();

    while (ntoken)
    {

        switch (ntoken)
        {
        case INTEGER_LITERAL:
        {

            int x = insert("INTEGER", yytext, yylineno);
            break;
        }
        case FLOAT_LITERAL:
        {

            int x = insert("FLOATING POINT", yytext, yylineno);
            break;
        }
        case CHAR_LITERAL:
        {

            int x = insert("CHARACTER", yytext, yylineno);
            break;
        }
        case STRING_LITERAL:
        {

            int x = insert("STRING", yytext, yylineno);
            break;
        }
        case BOOLEAN_LITERAL:
        {

            int x = insert("BOOLEAN", yytext, yylineno);
            break;
        }
        case IDENTIFIER:
        {
            int x;
            if (find(yytext) == -1)
            {
                x = insert("IDENTIFIER", yytext, yylineno);
            }

            break;
        }

        default:
            break;
        }
        ntoken = yylex();
    }
}
