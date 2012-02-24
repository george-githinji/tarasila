
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
import std.parallelism;

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
  //writeln(map);

  Records records;

  foreach(name,sequence;map){
    Record ent = new Record();
    ent.name = name;
    ent.seq = sequence;
    records ~= ent;
  }
 
  ulong total_records = records.length;

  foreach(rec;parallel(records)){
    //writeln(rec.get_seq);
    //writeln(rec.count("c"));
    writeln(rec.seq_size());
  }

   writefln("total records processed: %s ",total_records);
  return 0;
}
