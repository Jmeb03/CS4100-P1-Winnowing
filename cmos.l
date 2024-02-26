
%{
//*****************************************************************************************
// File: inforScan.l
// Purpose: SORT THROUGH STUDENTS C CODE FOR PLAGARISM BY TOKENIZING THEIR CODE THAT IS OFTEN 
// CHANGED TO HIDE THEIR PLAGARISM
// build instructions
// flex infoScanner.l
// g++ -o infoScanner lex.yy.x
// ./infoScanner < data_file.txt
// ****************************************************************************************

//declarations

#include <iostream>

using namespace std;

#define TKVARNAME 1 // TO TOKENIZE PLAGARIZED NAMES THAT WERE CHANGED
#define TKSTRINGVAL 2 // TO TOKENIZE PLAGARIZED STRING VALUES THAT WERE CHANGED
#define TKFUNCTION 3 //
#define TKTYPE 4
#define TKVAL 5
#define TKCOMMENT 6
#define TKIGNORE 255


int linecount = 1;

void Addline(char c)
{
  if(c=='\n')
  {
    linecount++;
  }
}

int line_num(){
  return linecount;
}




%}

D [0-9] //digit
A [a-zA-Z] //english alphabet
T ["int"|"char"|"float"|"double"|"void"|"bool"|"string"]


%%

_[{A}{D}]                   {    return TKVARNAME;  }

[{A}+][{D}]                   {    return TKVARNAME;  }

[{D}]               {    return TKVAL;  }

[{D}].[{D}]          {    return TKVAL;  }  

"//"(.*)           {    return TKCOMMENT;  }

"/*"(.*)"*/"      {    return TKCOMMENT;  }

{T}               {    return TKTYPE;  } 

[ \t\n\f]					{    Addline(yytext[0]);   } 

[{A}+]" "[{A}+]"("(.*)")"";"      {return TKFUNCTION;} //function call



.							{ 	//unmatched
                return TKIGNORE;
              }

%%

int yywrap(){
  return true;
}

int main() {


  int token = 0;
  token = yylex();
  while(token){
    switch (token) {
      case TKIGNORE:
        cout << "you missed something buddy" << endl;
        break;
      case TKVARNAME:
        cout << "TKVARNAME";
        break;
      case TKSTRINGVAL:
        cout << "TKSTRINGVAL";
        break;
      case TKTYPE:
        cout << "TKTYPE";
        break;
      case TKFUNCTION:
        cout << "TKFUNCTION";
        break;
      case TKVAL:
        cout << "TKVAL";
        break;
}

    token = yylex();
  }
}	