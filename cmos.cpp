/**
 *        @file: cmos.cpp
 *      @author: Drew VanAtta and Jake Bailey
 *        @date: Feb 26, 2024
 *       @brief: Add Description
 */

#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <vector>
#include <fstream>
using namespace std;

///function prototypes


vector<string> generateKGrams(const string& text, int k) {
    vector<string> kGrams;

    for (int i = 0; i <= text.length() - k; ++i) {
        string kGram = text.substr(i, k);
        kGrams.push_back(kGram);
    }

    return kGrams;
}



int main(int argc, char const *argv[]) {

  ifstream inFile;
  inFile.open("tokens.txt");
  if(inFile.fail()){
    cout << "File failed to open" << endl;
    return 0;
  }

  string pretendstring = "ABCDEFGABCDEFGABCDEFG";

  
  int k = 54; //size of our k-gram
  vector <string> kGrams;
  for(int i = 0; i < k; i++)
    {
      string temp;
      inFile.ignore(' ');
      getline(inFile, temp);
      cout << temp << endl << endl;
    }

  


  
   return 0;
}// main