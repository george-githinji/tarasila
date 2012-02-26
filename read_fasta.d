/* read the contents of a file from std input
   copyright (c) 2012
   Learning D programming for bioinformatics
 */

//import modules
import std.stdio;
import std.parallelism;
import std.conv;
import bio.sequence.fasta;

void main(string[] args){
  
  auto filename = args[1];
  long seq_size = to!long(args[2]);
  string[string] map_hash;
  long total_records;
  Records records;

  FastaParser parser = new FastaParser();
  parser.inputfile = filename;            // reads a file path
  map_hash = parser.parse;               //an associative array

  foreach(name, sequence; map_hash){
    Record ent = new Record();
    ent.name = name;
    ent.seq = sequence;
    if(ent.seq_size > seq_size){
      records ~= ent;
    }
  }
  
  total_records = records.length;

  /* iterates in the fasta array of records in parallel */
  foreach(rec;parallel(records)){
    writeln(rec.get_seq);
    //writeln(rec.count("c"));
    //writeln(rec.seq_size());
  }

   writefln("total records filtered by length: %s ",total_records);
}
