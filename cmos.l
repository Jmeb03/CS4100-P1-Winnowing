
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
#include <fstream>

using namespace std;

#define TKVARNAME 1 // TO TOKENIZE PLAGARIZED NAMES THAT WERE CHANGED
#define TKSTRINGVAL 2 // TO TOKENIZE PLAGARIZED STRING VALUES THAT WERE CHANGED
#define TKFUNCTION 3 //
#define TKTYPE 4
#define TKVAL 5
#define TKCOMMENT 6
#define TKINCLUDE 7
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
T int|char|float|double|void|bool|string


%%

_[{A}{D}]                   {    return TKVARNAME;  }

[a-zA-Z0-9]+[ \n]*;         {    return TKVARNAME;  }

[{D}]               {    return TKVAL;  }

[{D}].[{D}]          {    return TKVAL;  }  

"//"(.*)           {    return TKCOMMENT;  }

"/*"([^*]|\*+[^*/])*\*+"/"     {    return TKCOMMENT;  }

{T}               {    return TKTYPE;  } 

[ \t\n\f]					{    Addline(yytext[0]);   } 

[a-zA-Z]+[ \n][a-zA-Z_]+[(](.*)[)][;]      {  return TKFUNCTION;} //function call

[a-zA-Z]+[ \n][a-zA-Z_]+[ \n]*+[(](.*)[)][ \n]*[{]       { return TKFUNCTION; }

"#"(.*)           { return TKINCLUDE; }

.							{ 	//unmatched
                return TKIGNORE;
              }

%%

int yywrap(){
  return true;
}

int main() {

  ofstream outFile;
  outFile.open("token.txt");
  int token = 0;
  token = yylex();
  while(token){
    switch (token) {
      case TKIGNORE:
        //outFile << yytext;
        break;
      case TKVARNAME:
        outFile << "TKVARNAME";
        break;
      case TKSTRINGVAL:
        outFile << "TKSTRINGVAL";
        break;
      case TKTYPE:
        outFile << "TKTYPE";
        break;
      case TKFUNCTION:
        outFile << "TKFUNCTION";
        break;
      case TKVAL:
        outFile << "TKVAL";
        break;
}
    token = yylex();
  }
outFile.close();
}	