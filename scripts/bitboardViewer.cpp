#include <vector>
#include <iostream>
#include <bitset>
#include <algorithm>
#include <set>
#include <unordered_set>
#include <map>
#include <stack>
#include <unordered_map>
#include <math.h>
#define INF 0x7FFFFFFF
#define INFL 0x7FFFFFFFFFFFFFFF
typedef std::pair<int, int> ipair;
using namespace std;

int main(int argc , char **argv) {
  if (argc <= 2) return 0;
  string num = argv[1];
  unsigned long long base = stoull(argv[2]);
  
  unsigned long long bitboard = stoull(num, 0, base);

  unsigned long long i = 1; i <<= 63;
  string s = "";
  int j = 8;
  while (i){

    s = ((bitboard & i) ? "⬢ " : "⬡ ") + s;
    if (i & 0x101010101010101u) {
        cout << "// " << j << " ";
        j--;
        if (i & 0x100010001000100u) cout << " ";
        cout << s << endl; 
        s = "";

    }
    i = i >> 1;
  }
  cout << s ;
}
