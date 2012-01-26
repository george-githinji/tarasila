
/* read the contents of a fasta file from std input
   copyright (c) 2012
   learning D programming

 */

//import the needed modules
import std.stdio;
import std.stream;
import std.regex;
import std.array;
import bio.sequence.fasta;


int main(string[] args){
  auto filename = args[1];
  auto entry_name = regex(r"^>(.*)");

  Stream file = new BufferedFile(filename);
  auto current = appender!(char[]);
  string name;
  string[string] map;
   e = Entry.new

  foreach(ulong n, char[] line; file) {
    auto entry = match(line,entry_name);
    if(entry){//we are in a header line
      if(name){//write what was caught 
        map[name] = current.data.idup;//dup because .current.data is reused
      }
      name = entry.hit.idup[1..$].chomp; //also get rid of the ">" character
      current.clear();
    }else{
      current.put(line);
    }
  }
  map[name] = current.data.idup;//remember last capture
  file.close();
  writeln(map);
  return 0;
}
