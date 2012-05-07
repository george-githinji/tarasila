/* classifies dbla tags
   Copyright (c) 2012
 */

//import modules
import std.stdio;
import std.conv;
//import std.parallelism;
//import std.algorithm;
import bio.sequence.fasta;

void main(string[] args){
  auto filename = args[1];
  string[string] map_hash;
  Records records;

  FastaParser parser = new FastaParser;
  parser.inputfile = filename;
  map_hash = parser.makeHash;

  foreach(name,sequence; map_hash){
    Record ent = new Record();
    ent.name = name;
    ent.seq = sequence;
    records ~= ent;  
  }

  //classify each record in parallel
  foreach(rec; records){
    //writeln(rec.get_seq);
    writeln(rec.get_name);

    //count the number of cysteine
    long total_cys = rec.count_of("C");
    writefln("cys_count:",total_cys);
    
    //get the length of the sequence
    auto seq_len = rec.seq_size();
    //writeln("seq_length:",seq_len);

    //does sequence have WW?

    //does sequence have VW?

    //get the polv1 region

    //get the polv2 region

    //get the polv3 region

    //get the polv4 region

  }
}

