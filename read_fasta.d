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
import std.parallelism;
import std.conv;
import bio.sequence.fasta;

void main(string[] args){
  
  auto filename = args[1];
  long seq_size = to!long(args[2]);

  // convert seq_size to integer

  auto entry_name = regex(r"^>(.*)");

  Stream file = new BufferedFile(filename);
  auto current = appender!(char[]);
  string name;
  string[string] map;

  foreach(ulong n,char[] line; file) {
    
    auto entry = match(line,entry_name);
    
    if(entry){ //we are in a header line
      
      if(name){ //write what was caught 
        map[name] = current.data.idup; //dup because .current.data is reused
      }
      name = entry.hit.idup[1..$].chomp; //also get rid of the ">" character
      current.clear();
   
    }else{

      //remove spaces from the line
      line = removechars(line," ".dup);

      //make characters lowercase
      line = toLower(line);
      current.put(line);
    }
  }

  map[name] = current.data.idup;//remember last capture
  
  file.close();

  Records records;

  foreach(name,sequence;map){
    Record ent = new Record();
    ent.name = name;
    ent.seq = sequence;
    if(ent.seq_size > seq_size){
      //records ~= ent;
      writeln(ent.seq_size);
    }
  }
 
  //ulong total_records = records.length;

  //foreach(rec;parallel(records)){
    //writeln(rec.get_seq);
    //writeln(rec.count("c"));
    //writeln(rec.seq_size());
  //}

   //writefln("total records processed: %s ",total_records);
}
