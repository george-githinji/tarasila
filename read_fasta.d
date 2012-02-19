
/* read the contents of a file from std input
   copyright (c) 2012
   Learning D programming for bioinformatics

 */

//import the needed modules
import std.stdio;
import std.stream;
import std.regex;
import std.array;
import std.algorithm;
import std.string;
import bio.sequence.fasta;

int main(string[] args){
  auto filename = args[1];
  auto entry_name = regex(r"^>(.*)");
  //auto fasta_regex = regex(r"(\>.+\n)([^\>]+\n)");

  Stream file = new BufferedFile(filename);
  auto current = appender!(char[]);
  string name;
  string[string] map;
  
  foreach(ulong n,char[] line; file) {
    auto entry = match(line,entry_name);
    if(entry){//we are in a header line
      if(name){//write what was caught 
        map[name] = current.data.idup;//dup because .current.data is reused
      }
      name = entry.hit.idup[1..$].chomp; //also get rid of the ">" character
      current.clear();
    }else{
      //remove spaces from the line
      //string line1 = line.idup;
      //char[] line2 = removechars(line1," ").dup;
      line = removechars(line," ".dup);
      //make characters lowercase
      line = toLower(line);
      current.put(line);
    }
  }
  map[name] = current.data.idup;//remember last capture
  file.close();
  writeln(map);

  entry ent = new entry();
  ent.name = "seq1";
  ent.seq  = "acgcccgat";

  writeln(ent.get_name);
  writeln(ent.get_seq);
  writeln(ent.count("A"));
  return 0;
}
