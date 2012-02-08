
/* read the contents of a fasta file from std input
   copyright (c) 2012
   learning D programming

 */

//import the needed modules
import std.stdio;
import std.stream;
import std.regex;
import std.array;
import std.algorithm;
import bio.sequence.fasta;


int main(string[] args){
  auto filename = args[1];
  auto current = appender!(char[]);
  string name;
  string[string] map;

  Stream file = new BufferedFile(filename);
  auto entry_name = regex(r"^>(.*)");

  foreach(ulong n, char[] line; file) {
    auto entry = match(line,entry_name);
    if(entry){//we are in a header line
      if(name){//write what was caught 
        map[name] = current.data.idup;//dup because .current.data is reused
      }
      name = entry.hit.idup[1..$].chomp; //remove the ">" 
      current.clear();
    }else{
      //remove spaces from the line
      line = removechars(line," ".dup);
      current.put(line);
    }
  }
  map[name] = current.data.idup;//remember last capture
  file.close();
  writeln(map);
  return 0;
}
